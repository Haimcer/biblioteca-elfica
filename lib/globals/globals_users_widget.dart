import 'package:flutter/material.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/globals/theme_controller.dart';
import 'package:leitor_ebooks/modals/usuario_model.dart';
import 'package:provider/provider.dart';

class GlobalsUsersWidget {
  BuildContext context;
  GlobalsUsersWidget(this.context);

  Widget imgPerfilUser({
    double? sizeImg,
    VoidCallback? onTap,
    String? imageUser,
    bool? otherImgae,
    UsuarioModel? user,
    bool? exibirImagem,
    String? nomeUsuario
  }) {
    final usuarioInfos = Provider.of<UserInfos>(context);
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: sizeImg ?? 40,
        width: sizeImg ?? 40,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: globalsThemeVar.iGlobalsColors.primaryColor,
            border: Border.all(
              color: globalsThemeVar.iGlobalsColors.tertiaryColor,
            )),
        child: otherImgae ?? false
            ? !(imageUser == null || imageUser == 'null' || imageUser == '')
                ? ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(500)),
                    child: Hero(
                      tag: '${imageUser}',
                      child: Image.network(
                        imageUser,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                              'assets/img_error.png');
                        },
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(500)),
                    child: Image.network(
                      "https://ui-avatars.com/api/?name=${user?.nomeUsuario == 'null' || user?.nomeUsuario == null ? nomeUsuario == 'null' || nomeUsuario == null ? usuarioInfos.usuario.nomeUsuario : nomeUsuario :  usuarioInfos.usuario.nomeUsuario}&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
                      fit: BoxFit.cover,
                    ),
                  )
            : usuarioInfos.usuario.foto == null ||
                    usuarioInfos.usuario.foto == 'null'
                ? usuarioInfos.usuario.nomeUsuario == 'null' ||
                        usuarioInfos.usuario.nomeUsuario == null
                    ? ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                        child: Image.asset(
                          'assets/img_error.png',
                          fit: BoxFit.cover,
                        ),
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(500)),
                        child: Image.network(
                          "https://ui-avatars.com/api/?name=${user?.nomeUsuario == 'null' || user?.nomeUsuario == null ? usuarioInfos.usuario.nomeUsuario : user?.nomeUsuario}&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
                          fit: BoxFit.cover,
                        ),
                      )
                : ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(500)),
                    child: Hero(
                      tag: '${usuarioInfos.usuario.id}',
                      child: Image.network(
                        "${usuarioInfos.usuario.foto}",
                        errorBuilder: (context, error, stackTrace) {
                          return Image.asset(
                            'assets/img_error.png',
                            fit: BoxFit.cover,
                          );
                        },
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
      ),
    );
  }

  Widget imgNameUser(
    double sizeText, {
    String? networkImage,
    String? nome,
  }) {
    final globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    return Row(
      children: [
        Container(
          height: sizeText,
          width: sizeText,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: networkImage == null || networkImage == 'null'
              ? nome == 'null' || nome == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                      child: Image.asset(
                        'assets/img_error.png',
                        color: globalsThemeVar.iGlobalsColors.primaryColor,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                      child: Image.network(
                        "https://ui-avatars.com/api/?name=$nome&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
                        fit: BoxFit.cover,
                      ),
                    )
              : ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(500)),
                  child: Image.network(
                    networkImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/img_error.png',
                        color: globalsThemeVar.iGlobalsColors.primaryColor,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  nome == 'null' || nome == null ? '' : nome,
                  style: TextStyle(
                      color: globalsThemeVar.iGlobalsColors.textColorMedio,
                      fontSize: GlobalsSizes(context).sizeText),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget imgRedondaUser(
    double size, {
    String? networkImage,
    String? nome,
    bool? borda,
  }) {
    final globalsThemeVar =
        Provider.of<GlobalsThemeVar>(context, listen: false);
    return Row(
      children: [
        Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            border: borda == true
                ? Border.all(
                    width: 5.2,
                    color: globalsThemeVar.iGlobalsColors.tertiaryColor)
                : Border.all(),
            shape: BoxShape.circle,
            color: globalsThemeVar.iGlobalsColors.primaryColor,
          ),
          child: networkImage == null
              ? nome == 'null' || nome == null
                  ? ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                      child: Image.asset(
                        'assets/img_error.png',
                        color: globalsThemeVar.iGlobalsColors.primaryColor,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(500)),
                      child: Image.network(
                        "https://ui-avatars.com/api/?name=$nome&background=${globalsThemeVar.iGlobalsColors.colorBackgroundImage}&color=FFFFFF",
                        fit: BoxFit.cover,
                      ),
                    )
              : ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(500)),
                  child: Image.network(
                    networkImage,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/img_error.png',
                        color: globalsThemeVar.iGlobalsColors.primaryColor,
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
        ),
      ],
    );
  }
}
