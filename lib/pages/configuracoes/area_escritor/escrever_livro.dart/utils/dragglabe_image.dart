import 'package:flutter/material.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/escrever_livro.dart/model/dragglabe_model.dart';

class DraggableImage extends StatefulWidget {
  final DraggableImageData data;
  final VoidCallback onBringToFront;
  final VoidCallback onSendToBack;
  final VoidCallback onDelete;
  final VoidCallback onDuplicate;

  const DraggableImage(
      {Key? key,
      required this.data,
      required this.onBringToFront,
      required this.onSendToBack,
      required this.onDelete,
      required this.onDuplicate})
      : super(key: key);

  @override
  State<DraggableImage> createState() => _DraggableImageState();
}

class _DraggableImageState extends State<DraggableImage> {
  late Offset position;
  late double width;
  late double height;

  @override
  void initState() {
    super.initState();
    position = widget.data.position;
    width = widget.data.width;
    height = widget.data.height;
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: GestureDetector(
        onPanUpdate: (details) {
          setState(() {
            position += details.delta;
            widget.data.position = position;
          });
        },
        child: Stack(
          children: [
            Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black26),
              ),
              child: Image.memory(
                widget.data.imageBytes,
                width: width,
                height: height,
                fit: BoxFit.cover,
              ),
            ),
            // 🔁 Botões no canto superior direito
            Positioned(
              top: 0,
              right: 0,
              child: Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_upward, size: 16),
                    onPressed: widget.onBringToFront,
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  IconButton(
                    icon: Icon(Icons.arrow_downward, size: 16),
                    onPressed: widget.onSendToBack,
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  IconButton(
                    icon: Icon(Icons.copy, size: 16),
                    onPressed: widget.onDuplicate,
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, size: 16),
                    onPressed: widget.onDelete,
                    color: Colors.white,
                    padding: EdgeInsets.zero,
                    constraints: BoxConstraints(),
                  ),
                ],
              ),
            ),
            // 🔧 Handle de resize no canto inferior direito
            Positioned(
              right: 0,
              bottom: 0,
              child: GestureDetector(
                onPanUpdate: (details) {
                  setState(() {
                    width += details.delta.dx;
                    height += details.delta.dy;
                    widget.data.width = width;
                    widget.data.height = height;
                  });
                },
                child: Container(
                  width: 20,
                  height: 20,
                  color: Colors.black.withOpacity(0.4),
                  child:
                      Icon(Icons.open_in_full, size: 14, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
