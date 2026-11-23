import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/globals/globals_buttons.dart';
import 'package:leitor_ebooks/globals/globals_form.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/store/registrar_escritor_store.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/utils_imagem/subir_imagem_celular.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/utils_imagem/subir_imagem_web.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show Uint8List, kIsWeb;
import 'registrar_escritor_functions.dart';

class CadastroEscritorWidget {
  BuildContext context;
  CadastroEscritorWidget(this.context);

  Widget cadastroEscritorWidgetPrincipal(BuildContext contextAux) {
    final size = MediaQuery.of(context).size;
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final resgistrarEscritorStore =
        Provider.of<ResgistrarEscritorStore>(context);
    var celular = getNumeroDeLinhas(context);
    return ListView(
      // mainAxisAlignment: MainAxisAlignment.center,
      padding: celular > 3
          ? EdgeInsets.symmetric(horizontal: size.width * 0.15)
          : EdgeInsets.symmetric(horizontal: size.width * 0.05),
      shrinkWrap: true,
      children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Icon(
                    Icons.arrow_back_ios,
                    color:
                        globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
                    size: GlobalsSizes(context).sizeTextMedio,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: GlobalsSizes(contextAux).marginSpaceSize,
        ),
        Observer(builder: (_) {
          return circleAvatarFoto(
            resgistrarEscritorStore.foto,
            () async {
              if (kIsWeb) {
                await selecionarImagemWeb((imagemBytes, nomeImagem) {
                  print('Nome do arquivo: $nomeImagem');
                  print('Tamanho da imagem em bytes: ${imagemBytes.length}');
                  resgistrarEscritorStore.setFoto(imagemBytes);
                });
              } else {
                await selecionarImagemCelular((imagemBytes, nomeImagem) {
                  print('Nome do arquivo: $nomeImagem');
                  print('Tamanho da imagem em bytes: ${imagemBytes.length}');
                  resgistrarEscritorStore.setFoto(imagemBytes);
                });
              }
            },
          );
        }),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        _formulario(),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        toggleEscritorAnonimo(context: contextAux),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        _btnCadastrarConta(contextAux),
        SizedBox(
          height: GlobalsSizes(contextAux).marginPageSize,
        ),
        _btnEnviar(contextAux),
        SizedBox(
          height: GlobalsSizes(contextAux).marginPageSize,
        ),
      ],
    );
  }

  Widget circleAvatarFoto(dynamic foto, VoidCallback onButtonPressed) {
    var celular = getNumeroDeLinhas(context);
    double tamanho = celular > 3 ? 160 : 80;
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: celular > 3 ? 70 : 40,
            backgroundColor: Colors.grey[300],
            child: Builder(
              builder: (context) {
                if (foto == null) {
                  return Icon(Icons.person, color: Colors.white, size: 40);
                }

                if (foto is String && foto.isNotEmpty) {
                  return ClipOval(
                    child: CachedNetworkImage(
                      imageUrl: foto,
                      fit: BoxFit.cover,
                      width: tamanho,
                      height: tamanho,
                      errorWidget: (context, url, error) {
                        return fallbackImage(context, foto, tamanho);
                      },
                    ),
                  );
                }

                if (foto is Uint8List && foto.isNotEmpty) {
                  return ClipOval(
                    child: Image.memory(
                      foto,
                      fit: BoxFit.cover,
                      width: tamanho,
                      height: tamanho,
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.person,
                            color: Colors.white, size: 40);
                      },
                    ),
                  );
                }

                return Icon(Icons.person, color: Colors.white, size: 40);
              },
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: InkWell(
              onTap: onButtonPressed,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                padding: EdgeInsets.all(4),
                child: Icon(Icons.edit, color: Colors.white, size: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget fallbackImage(BuildContext context, dynamic foto, double tamanho) {
    if (foto is Uint8List && foto.isNotEmpty) {
      return Image.memory(
        foto,
        fit: BoxFit.cover,
        width: tamanho,
        height: tamanho,
        errorBuilder: (context, error, stackTrace) {
          return Icon(Icons.person, color: Colors.white, size: 40);
        },
      );
    }
    return Icon(Icons.person, color: Colors.white, size: 40);
  }

  Widget _formulario() {
    final cadastroEscritorFunctions =
        Provider.of<CadastroEscritorFunctions>(context);
    return Column(
      children: [
        _tituloSecao('Como você quer ser chamado?'),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        GlobalsForm(context).campoTextFieldTexto(
          cadastroEscritorFunctions.nomeCompletoController,
          'Exemplo: Ana Escritora, ShadowWriter',
        ),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        _tituloSecao('Apresente-se aos leitores'),
        SizedBox(height: GlobalsSizes(context).marginSpaceSize),
        GlobalsForm(context).campoTextFieldTexto(
          cadastroEscritorFunctions.bioDescricaoController,
          maxLines: 5,
          height: 180,
          'Fale um pouco sobre você como escritor',
        ),
      ],
    );
  }

  Widget _tituloSecao(String title) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: globalsThemeVar.iGlobalsColors.textColorFraco,
            fontSize: GlobalsSizes(context).sizeTextMedio,
          ),
        ),
      ],
    );
  }

  Widget toggleEscritorAnonimo({
    required BuildContext context,
  }) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final resgistrarEscritorStore =
        Provider.of<ResgistrarEscritorStore>(context);
    final sizeText = GlobalsSizes(context).sizeTextMedio;
    var celular = getNumeroDeLinhas(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: celular > 3
          ? MainAxisAlignment.start
          : MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: celular > 3 ? 2 : 4,
          child: Text(
            'Deseja esconder seu usuário?',
            style: TextStyle(
              color: globalsThemeVar.iGlobalsColors.textColorFraco,
              fontSize: sizeText,
            ),
          ),
        ),
        Observer(builder: (_) {
          return Expanded(
            flex: celular > 3 ? 4 : 2,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Switch(
                  value: resgistrarEscritorStore.isAnonimo,
                  onChanged: (value) {
                    resgistrarEscritorStore.setIsAnonimo(value);
                  },
                  activeColor: globalsThemeVar.iGlobalsColors.primaryColor,
                ),
              ],
            ),
          );
        }),
      ],
    );
  }

  Widget _btnCadastrarConta(contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final cadastroEscritorFunctions =
        Provider.of<CadastroEscritorFunctions>(context, listen: false);
    return GlobalsButtons(context).buttonPrimary(
      globalsThemeVar.iGlobalsColors.tertiaryColor,
      isSombreado: true,
      corBorda: globalsThemeVar.iGlobalsColors.primaryColor,
      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
      cadastroEscritorFunctions.escritorModelEsc != null
          ? "Editar Conta Bancária"
          : "Cadastrar Conta Bancária",
      () async {},
    );
  }

  Widget _btnEnviar(contextAux) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    final globalsStore = Provider.of<GlobalsStore>(context, listen: false);
    final resgistrarEscritorStore =
        Provider.of<ResgistrarEscritorStore>(context, listen: false);
    final cadastroEscritorFunctions =
        Provider.of<CadastroEscritorFunctions>(context, listen: false);
    return GlobalsButtons(context).buttonPrimary(
      globalsThemeVar.iGlobalsColors.primaryColor,
      globalsThemeVar.iGlobalsColors.textColorPrimaryInverse,
      cadastroEscritorFunctions.escritorModelEsc != null
          ? "Confirmar"
          : "Salvar",
      () async {
        globalsStore.setLoading(true);
        await cadastroEscritorFunctions.cadastraFornecedor(
            contextAux, resgistrarEscritorStore);
        globalsStore.setLoading(false);
      },
    );
  }
}
