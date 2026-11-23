import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:flutter_quill/quill_delta.dart';
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'package:leitor_ebooks/globals/globals_widgets.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/escrever_livro.dart/model/dragglabe_model.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/escrever_livro.dart/utils/dragglabe_image.dart';

class BookEditorPage extends StatefulWidget {
  const BookEditorPage({Key? key}) : super(key: key);

  @override
  _BookEditorPageState createState() => _BookEditorPageState();
}

class ChapterModel {
  final String title;
  final int page;
  final bool isTitle;

  ChapterModel(
      {required this.title, required this.page, required this.isTitle});
}

class _BookEditorPageState extends State<BookEditorPage> {
  final ScrollController _scrollController = ScrollController();
  final ImagePicker _picker = ImagePicker();
  List<QuillController> _pages = [QuillController.basic()];
  List<FocusNode> _focusNodes = [FocusNode()];
  List<List<DraggableImageData>> _pageImages = [[]];
  bool _showToolbar = true;
  int _currentPageIndex = 0;
  double _scale = 1.5;
  final List<GlobalKey> _pageKeys = [GlobalKey()];
  List<ScrollController> _editorScrollControllers = [ScrollController()];
  bool _isAddingPage = false;

  final List<String> _sheetAssets = [
    'assets/paper/amarelada.png',
    'assets/paper/branca.png',
    'assets/paper/preta.png',
  ];
  int _selectedSheet = 0;

  double _marginLeft = 24,
      _marginRight = 24,
      _marginTop = 24,
      _marginBottom = 24;

  final Map<String, String> _fontFamilyValues = {
    'Sans Serif': 'OpenSans',
    'Serif': 'Merriweather',
    'Monospace': 'SourceCodePro',
  };
  int _selectedFontIndex = 0;

  List<ChapterModel> _chapters = [];

  void _saveDraft() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Rascunho salvo!')),
    );
  }

  void _cloneCurrentPage() {
    final currentIndex = _currentPageIndex;
    if (currentIndex >= 0 && currentIndex < _pages.length) {
      final originalController = _pages[currentIndex];

      // Clona o conteúdo do QuillController
      final clonedDoc =
          Document.fromJson(originalController.document.toDelta().toJson());
      final clonedController = QuillController(
        document: clonedDoc,
        selection: const TextSelection.collapsed(offset: 0),
      );

      // Clona imagens da página
      final clonedImages = _pageImages[currentIndex].map((img) {
        return DraggableImageData(
          imageBytes: img.imageBytes,
          position: img.position + Offset(20, 20), // desloca um pouco
          width: img.width,
          height: img.height,
        );
      }).toList();

      // Insere a nova página após a atual
      setState(() {
        _pages.insert(currentIndex + 1, clonedController);
        _focusNodes.insert(currentIndex + 1, FocusNode());
        _pageKeys.add(GlobalKey());
        _editorScrollControllers.add(ScrollController());
        _pageImages.insert(currentIndex + 1, clonedImages);
        _currentPageIndex = currentIndex + 1;
        _updateChapters();
      });

      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToPage(_currentPageIndex + 1);
      });
    }
  }

  void _selectPaperSheet() {
    showModalBottomSheet(
      context: context,
      builder: (ctx) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(_sheetAssets.length, (index) {
            return ListTile(
              leading: Image.asset(
                _sheetAssets[index],
                width: 40,
                height: 40,
                fit: BoxFit.cover,
              ),
              title: Text('Folha ${index + 1}'),
              onTap: () {
                setState(() {
                  _selectedSheet = index;
                });
                Navigator.of(ctx).pop();
              },
            );
          }),
        ),
      ),
    );
  }

  void _addPage() {
    setState(() {
      _pages.add(QuillController.basic());
      _focusNodes.add(FocusNode());
      _pageKeys.add(GlobalKey());
      _pageImages.add([]);
      _editorScrollControllers.add(ScrollController());
      _updateChapters();
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent + 850,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  void _editMargins() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatefulBuilder(builder: (context, setModalState) {
              return _buildMarginSlider('Margem Esquerda', _marginLeft, (v) {
                setState(() => _marginLeft = v);
                setModalState(() {}); // força atualização do slider
              });
            }),
            StatefulBuilder(builder: (context, setModalState) {
              return _buildMarginSlider('Margem Direita', _marginRight, (v) {
                setState(() => _marginRight = v);
                setModalState(() {});
              });
            }),
            StatefulBuilder(builder: (context, setModalState) {
              return _buildMarginSlider('Margem Superior', _marginTop, (v) {
                setState(() => _marginTop = v);
                setModalState(() {});
              });
            }),
            StatefulBuilder(builder: (context, setModalState) {
              return _buildMarginSlider('Margem Inferior', _marginBottom, (v) {
                setState(() => _marginBottom = v);
                setModalState(() {});
              });
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMarginSlider(
      String label, double value, ValueChanged<double> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        Slider(
          min: 0,
          max: 64,
          divisions: 16,
          label: value.round().toString(),
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  void _updateChapters() {
    final chapters = <ChapterModel>[];

    for (int i = 0; i < _pages.length; i++) {
      final ctrl = _pages[i];
      final delta = ctrl.document.toDelta().toList();

      String? title;
      bool isTitle = false;

      for (int j = 0; j < delta.length; j++) {
        final op = delta[j];

        if (op.isInsert && op.data != null) {
          final text = op.data.toString().trim();
          if (text.isEmpty) continue;

          bool currentIsHeading = false;

          // ⚡ Olha o PRÓXIMO op
          if (j + 1 < delta.length) {
            final nextOp = delta[j + 1];
            if (nextOp.isInsert && nextOp.data == '\n') {
              final attrs = nextOp.attributes;
              if (attrs != null && attrs.containsKey('header')) {
                currentIsHeading = true;
              }
            }
          }

          title = text.split('\n').first.trim();
          isTitle = currentIsHeading;
          break; // achou o que precisava
        }
      }

      title ??= "(pág. ${i + 1})";

      chapters.add(
        ChapterModel(
          title: title,
          page: i + 1,
          isTitle: isTitle,
        ),
      );
    }

    setState(() {
      _chapters = chapters;
    });
  }

  void _scrollToPage(int pageNumber) {
    final double offsetPerPage = 850 + 32; // altura + margin
    final double targetOffset = (pageNumber - 1) * offsetPerPage;

    _scrollController.animateTo(
      targetOffset,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
        actions: const [
          // Row(
          //   children: [
          //     Text(_showToolbar ? 'Esconder opções' : 'Mostrar opções'),
          //     IconButton(
          //       icon: Icon(_showToolbar
          //           ? Icons.keyboard_arrow_right
          //           : Icons.keyboard_arrow_left),
          //       onPressed: () {
          //         setState(() {
          //           _showToolbar = !_showToolbar;
          //         });
          //       },
          //     ),
          //   ],
          // ),
        ],
      ),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Índice lateral automático
          Expanded(
            flex: 2,
            child: SizedBox(
                height: size.height,
                child: Column(
                  children: [
                    const Text(
                      'Navegação',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Expanded(
                      child: ListView(
                        children: _chapters.map((chapter) {
                          return ListTile(
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  chapter.title,
                                  style: TextStyle(
                                    fontSize: chapter.isTitle ? 21 : 14,
                                    fontWeight: chapter.isTitle
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  'Página ${chapter.page}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey[700],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              _scrollToPage(chapter.page);
                              setState(() {
                                _currentPageIndex =
                                    chapter.page - 1; // começa do 0
                              });
                            },
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                )),
          ),
          // Área de edição
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Transform.scale(
                    scale: _scale,
                    alignment: Alignment.topCenter,
                    child: ListView(
                      controller: _scrollController,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      children: [
                        ..._pages.map((ctrl) => _buildPage(ctrl)),
                        SizedBox(height: 16),
                        Center(
                          child: ElevatedButton.icon(
                            icon: Icon(Icons.add),
                            label: Text('Adicionar Página'),
                            onPressed: _addPage,
                          ),
                        ),
                        SizedBox(height: 250 * _scale),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: IconButton(
                    icon: Icon(_showToolbar
                        ? Icons.keyboard_arrow_right
                        : Icons.keyboard_arrow_left),
                    onPressed: () {
                      setState(() {
                        _showToolbar = !_showToolbar;
                      });
                    },
                  ),
                ),
                Visibility(
                  visible: _showToolbar,
                  child: SizedBox(
                    height: size.height,
                    width: 120,
                    child: Column(
                      children: [
                        IconButton(
                            icon: Icon(Icons.margin), onPressed: _editMargins),
                        IconButton(
                          icon: Icon(Icons.image),
                          onPressed: () async {
                            final XFile? file = await _picker.pickImage(
                                source: ImageSource.gallery);
                            if (file != null) {
                              final bytes = await file.readAsBytes();
                              final currentIndex = _currentPageIndex;

                              setState(() {
                                _pageImages[currentIndex].add(
                                  DraggableImageData(
                                    imageBytes: bytes,
                                    position: Offset(100, 100),
                                  ),
                                );
                              });
                            }
                          },
                        ),

                        // IconButton(
                        //   icon: Icon(Icons.image),
                        //   onPressed: () async {
                        //     final XFile? file =
                        //         await _picker.pickImage(source: ImageSource.gallery);
                        //     if (file != null) {
                        //       final url = await _onImagePickCallback(File(file.path));
                        //       final idx = _pages.last.selection.baseOffset;
                        //       _pages.last.document.insert(idx, BlockEmbed.image(url!));
                        //       setState(() {});
                        //       _updateChapters();
                        //     }
                        //   },
                        // ),
                        IconButton(
                            icon: Icon(Icons.save), onPressed: _saveDraft),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(Icons.zoom_in),
                              onPressed: () {
                                setState(() {
                                  _scale = (_scale + 0.1).clamp(
                                      0.5, 2.0); // 0.5 = mínimo, 2.0 = máximo
                                });
                                // setState(() {
                                //   _scale += 0.1;
                                // });
                              },
                            ),
                            IconButton(
                              icon: Icon(Icons.zoom_out),
                              onPressed: () {
                                setState(() {
                                  _scale = (_scale - 0.1).clamp(0.5, 2.0);
                                });
                              },
                            ),
                          ],
                        ),

                        IconButton(
                          icon: Icon(Icons.copy),
                          tooltip: 'Clonar Página',
                          onPressed: _cloneCurrentPage,
                        ),

                        IconButton(
                          icon: Icon(Icons.style), // ou Icons.layers
                          tooltip: 'Selecionar Folha',
                          onPressed: _selectPaperSheet,
                        ),

                        QuillSimpleToolbar(
                          controller: _pages[_currentPageIndex],
                          config: const QuillSimpleToolbarConfig(
                            toolbarIconCrossAlignment: WrapCrossAlignment.end,
                            showFontSize: true,
                            showFontFamily: true,
                            showInlineCode: true,
                            showHeaderStyle: true,
                            showListBullets: true,
                            showListNumbers: true,
                            showCodeBlock: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(QuillController ctrl) {
    int index = _pages.indexOf(ctrl);
    final pageKey = _pageKeys[index];
    final images = _pageImages[index];
    _focusNodes[index].addListener(() {
      if (_focusNodes[index].hasFocus) {
        setState(() {
          _currentPageIndex = index;
        });
      }
    });

    ctrl.addListener(() {
      _updateChapters();

      if (index != _pages.length - 1) return;

      final doc = ctrl.document.toDelta().toList();
      final lineCount =
          doc.where((op) => op.data.toString().contains('\n')).length;

      if (lineCount >= 45) {
        _addPage();

        // ⏳ Espera 1 frame para garantir que a nova página está montada
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final newCtrl = _pages.last;
          newCtrl.updateSelection(
            const TextSelection.collapsed(offset: 0),
            ChangeSource.local,
          );
          FocusScope.of(context).requestFocus(_focusNodes.last);
        });
      }
    });

    _editorScrollControllers[index].addListener(() {
      final controller = _editorScrollControllers[index];

      if (_isAddingPage) return;

      if (controller.offset >= controller.position.maxScrollExtent - 10 &&
          !controller.position.outOfRange &&
          index == _pages.length - 1) {
        _isAddingPage = true;

        final doc = ctrl.document;
        final deltaList = doc.toDelta().toList();

        if (deltaList.length <= 1) {
          _isAddingPage = false;
          return;
        }

        final half = (deltaList.length * 0.6).floor();
        final oldDelta = Delta()..insert('\n');
        final newDelta = Delta()..insert('\n');

        for (int i = 0; i < deltaList.length; i++) {
          if (i <= half) {
            oldDelta.push(deltaList[i]);
          } else {
            newDelta.push(deltaList[i]);
          }
        }

        ctrl.document = Document.fromDelta(oldDelta);

        final newCtrl = QuillController(
          document: Document.fromDelta(newDelta),
          selection: const TextSelection.collapsed(offset: 0),
        );

        setState(() {
          _pages.add(newCtrl);
          _focusNodes.add(FocusNode());
          _pageImages.add([]);
          _editorScrollControllers.add(ScrollController());
          _pageKeys.add(GlobalKey());
          _currentPageIndex = _pages.length - 1;
          _updateChapters();
        });

        WidgetsBinding.instance.addPostFrameCallback((_) {
          FocusScope.of(context).requestFocus(_focusNodes.last);
          _isAddingPage = false;
        });
      }
    });

    return Align(
      alignment: Alignment.topCenter,
      key: pageKey,
      child: Container(
        width: 600,
        height: 850,
        margin: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
            boxShadow: [GlobalsWidgets(context).sombreadoBoxShadow()]),
        child: Stack(
          children: [
            // 1️⃣ Fundo da folha
            Positioned.fill(
              child: Image.asset(
                _sheetAssets[_selectedSheet],
                fit: BoxFit.cover,
              ),
            ),

            // 2️⃣ Imagens arrastáveis (entre fundo e texto)
            for (int i = 0; i < images.length; i++)
              DraggableImage(
                key: images[i].key,
                data: images[i],
                onBringToFront: () {
                  setState(() {
                    final item = images.removeAt(i);
                    images.add(item);
                  });
                },
                onSendToBack: () {
                  setState(() {
                    final item = images.removeAt(i);
                    images.insert(0, item);
                  });
                },
                onDelete: () {
                  setState(() {
                    images.removeAt(i);
                  });
                },
                onDuplicate: () {
                  setState(() {
                    final clone = DraggableImageData(
                      imageBytes: images[i].imageBytes,
                      position: images[i].position +
                          Offset(20, 20), // ligeiro deslocamento
                      width: images[i].width,
                      height: images[i].height,
                    );
                    images.insert(i + 1, clone);
                  });
                },
              ),

            // 3️⃣ Texto
            Padding(
              padding: EdgeInsets.fromLTRB(
                _marginLeft,
                _marginTop,
                _marginRight,
                _marginBottom,
              ),
              child: SizedBox(
                height: 850 - _marginTop - _marginBottom,
                child: QuillEditor(
                  controller: ctrl,
                  focusNode: _focusNodes[index],
                  scrollController: _editorScrollControllers[index],
                  config: QuillEditorConfig(
                    autoFocus: false,
                    expands: true,
                    embedBuilders: kIsWeb
                        ? FlutterQuillEmbeds.editorWebBuilders()
                        : FlutterQuillEmbeds.editorBuilders(),
                    padding: EdgeInsets.zero,
                    scrollable: true,
                    customStyles: DefaultStyles(
                      sizeLarge: TextStyle(
                        fontFamily: _fontFamilyValues.values
                            .elementAt(_selectedFontIndex),
                        fontSize: 20,
                      ),
                      small: TextStyle(
                        fontFamily: _fontFamilyValues.values
                            .elementAt(_selectedFontIndex),
                        fontSize: 11,
                      ),
                      sizeHuge: TextStyle(
                        fontFamily: _fontFamilyValues.values
                            .elementAt(_selectedFontIndex),
                        fontSize: 30,
                      ),
                      paragraph: DefaultTextBlockStyle(
                        TextStyle(
                          fontFamily: _fontFamilyValues.values
                              .elementAt(_selectedFontIndex),
                          fontSize: 16,
                        ),
                        const HorizontalSpacing(0, 0),
                        const VerticalSpacing(0, 0),
                        const VerticalSpacing(0, 0),
                        null,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
