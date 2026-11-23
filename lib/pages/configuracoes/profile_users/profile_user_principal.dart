import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/profile_user_functions.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/profile_user_widget.dart';
import 'package:provider/provider.dart';
import '../../../globals/globals_widgets.dart';
import '../../../globals/theme_controller.dart';
import 'store/profile_user_store.dart';

// ignore: must_be_immutable
class ProfileUserPage extends StatefulWidget {
  ProfileUserPage({super.key, required this.idUsuario, required this.tipo});
  String idUsuario;
  String tipo;

  @override
  State<ProfileUserPage> createState() => _ProfileUserPageState();
}

class _ProfileUserPageState extends State<ProfileUserPage>
    with SingleTickerProviderStateMixin {
  late GlobalsThemeVar globalsThemeVar;
  late ProfileUserFunctions profileUserFunctions;
  late ProfileUserStore profileUserStore;

  late TabController _tabController;

  bool carregando = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    globalsThemeVar = Provider.of<GlobalsThemeVar>(context);
    profileUserFunctions = Provider.of<ProfileUserFunctions>(context);
    profileUserStore = Provider.of<ProfileUserStore>(context);
    print('entrei aqui');
    _tabController = TabController(length: 2, vsync: this);
    _iniciaPage();
  }

  Future<void> _iniciaPage() async {
    print('comecei a carregar');
    setState(() => carregando = true);
    await profileUserFunctions.carregarPerfil(
        profileUserStore, widget.idUsuario, widget.tipo);
    if (!mounted) return;
    setState(() => carregando = false);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: globalsThemeVar.iGlobalsColors.tertiaryColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: globalsThemeVar.iGlobalsColors.primaryColor,
          onRefresh: _iniciaPage,
          child: Stack(
            children: [
              carregando
                  ? GlobalsWidgets(context).loading()
                  : ProfileUserWidget(context, widget.tipo)
                      .profileUserPrincipal(
                      profileUserStore,
                      profileUserFunctions,
                      _tabController,
                    ),
              Observer(builder: (_) {
                return Visibility(
                  visible: profileUserStore.loading,
                  child: GlobalsWidgets(context).loading(),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
