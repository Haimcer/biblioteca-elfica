import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leitor_ebooks/controllers/user_infos.dart';
import 'package:leitor_ebooks/globals/globals_users_widget.dart';
import 'package:leitor_ebooks/globals/globals_vars.dart';
import 'package:leitor_ebooks/modals/categoria.dart';
import 'package:leitor_ebooks/pages/configuracoes/area_escritor/area_escritor_page.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/profile_user_principal.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/registrar_escritor_page.dart';
import 'package:leitor_ebooks/request/categorias/get_categorias.dart';
import 'package:provider/provider.dart';
import '../../globals/store/globals_store.dart';
import '../tabBar/tab_principal.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  List<CategoriaModel> categorias = [];
  bool loading = true;
  Widget _conteudoAtual = const Center(child: Text('Carregando...'));

  @override
  void initState() {
    super.initState();
    _carregarCategorias();
  }

  Future<void> _carregarCategorias() async {
    final response = await GetTodasCategoriasRequest(context).getCategorias();
    final globalsStore = Provider.of<GlobalsStore>(context, listen: false);

    if (response != null && response.isNotEmpty) {
      setState(() {
        categorias = response;
        globalsStore.setNomeCategoria(categorias.first.nome);
        _conteudoAtual = TabBarPrincipal(
          key: ValueKey(categorias.first.id!.toString()),
          categoriaId: categorias.first.id!.toString(),
        );
        loading = false;
      });
    } else {
      setState(() {
        setState(() {
          categorias = [];
          _conteudoAtual = TabBarPrincipal(categoriaId: '');
          loading = false;
        });

        loading = false;
      });
    }
  }

  void _trocarConteudo(String categoriaId) {
    setState(() {
      _conteudoAtual = TabBarPrincipal(
        key: ValueKey(categoriaId), // força recriação
        categoriaId: categoriaId,
      );
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final globalsStore = Provider.of<GlobalsStore>(context);
    final userInfos = Provider.of<UserInfos>(context);

    return Scaffold(
        drawer: Drawer(
          child: ListView(
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(color: Colors.deepOrange),
                child: Text('TechInnovate',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              for (var cat in categorias)
                ListTile(
                    leading: const Icon(Icons.book),
                    title: Text(cat.nome ?? 'Sem nome'),
                    onTap: () {
                      globalsStore.setNomeCategoria(cat.nome);
                      _trocarConteudo(cat.id!.toString());
                    }),
            ],
          ),
        ),
        endDrawer: Drawer(
          // <<< MENU DO LADO DIREITO
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.blueAccent),
                child: Text('Menu Lateral Direito',
                    style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil Usuário'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileUserPage(
                              idUsuario: userInfos.usuario.id ?? '',
                              tipo: 'usuario',
                            )),
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.pen),
                title: Text('Perfil Escritor'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (_) => ProfileUserPage(
                              idUsuario: userInfos.usuario.id ?? '',
                              tipo: 'escritor',
                            )),
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.book),
                title: Text('Área do escritor'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => WriterAreaPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.pencil),
                title: Text('Registar Escritor'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => CadastroEscritorPage()),
                  );
                },
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.fileContract),
                title: Text('Assinatura'),
              ),
              ListTile(
                leading: Icon(FontAwesomeIcons.file),
                title: Text('Planos'),
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: loading
              ? const Center(child: CircularProgressIndicator())
              : Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Stack(
                    children: [
                      Positioned.fill(
                          child:
                              _conteudoAtual), // conteúdo da página (com imagem)
                      _buildOverlayHeader(context), // cabeçalho fixo por cima
                    ],
                  ),
                ),
        ));
  }
}

Widget _buildOverlayHeader(BuildContext context) {
  final userInfos = Provider.of<UserInfos>(context);
  var celular = getNumeroDeLinhas(context);
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    child: SafeArea(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Builder(
            builder: (context) => IconButton(
              icon: const Icon(Icons.menu, color: Colors.white),
              onPressed: () => Scaffold.of(context).openDrawer(),
            ),
          ),
          Text(
            '',
            style: TextStyle(
              color: Colors.white,
              fontSize: GlobalsSizes(context).sizeSubtitulo,
              fontWeight: FontWeight.bold,
            ),
          ),
          Builder(
              builder: (context) => SizedBox(
                    width: celular > 3 ? 180 : 90,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: GestureDetector(
                        onTap: () => Scaffold.of(context).openEndDrawer(),
                        child: GlobalsUsersWidget(context).imgNameUser(
                            GlobalsSizes(context).sizeTitulo,
                            networkImage: userInfos.usuario.foto,
                            nome: userInfos.usuario.nomeUsuario),
                      ),
                    ),
                  )),
        ],
      ),
    ),
  );
}
