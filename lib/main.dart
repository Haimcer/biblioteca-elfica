import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:leitor_ebooks/controllers/app_inicializer.dart';
import 'package:leitor_ebooks/globals/globals_loading_widget.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/registrar_escritor_functions.dart';
import 'package:leitor_ebooks/pages/configuracoes/registrar_escritor/store/registrar_escritor_store.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/detalhes_page_functions.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/store/detalhes_livro_store.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/profile_user_functions.dart';
import 'package:leitor_ebooks/pages/configuracoes/profile_users/store/profile_user_store.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'globals/store/globals_store.dart';
import 'globals/theme_controller.dart';
import 'controllers/user_ids.dart';
import 'controllers/user_infos.dart';
import 'pages/login/login_principal_functions.dart';
import 'pages/login/store/login_principal_store.dart';
import 'pages/login/create_login/store/create_login_store.dart';
import 'pages/login/create_login/create_login_functions.dart';
import 'pages/favorite/store/favorite_store.dart';
import 'pages/favorite/favorites_page_functions.dart';
import 'pages/home/store/home_store.dart';
import 'pages/home/home_page_functions.dart';
import 'pages/tela_error/tela_error.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_localizations/flutter_localizations.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('pt_BR', null);

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: String.fromEnvironment('FIREBASE_API_KEY'),
        authDomain: String.fromEnvironment('FIREBASE_AUTH_DOMAIN'),
        projectId: String.fromEnvironment('FIREBASE_PROJECT_ID'),
        storageBucket: String.fromEnvironment('FIREBASE_STORAGE_BUCKET'),
        messagingSenderId: String.fromEnvironment('FIREBASE_MESSAGING_SENDER_ID'),
        appId: String.fromEnvironment('FIREBASE_APP_ID'),
        measurementId: String.fromEnvironment('FIREBASE_MEASUREMENT_ID'),
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  ErrorWidget.builder = (FlutterErrorDetails details) {
    return TelaErroPage(
      text:
          'Ops!\n ${details.exception}\n\n Dica:\n Reabra o app novamente para continuar utilizando',
    );
  };

  runApp(
    MultiProvider(
      providers: [
        //controllers
        Provider<UserIds>(
          create: (context) => UserIds(),
        ),

        // 🔹 FUNCTIONS
        Provider<CadastroEscritorFunctions>(
            create: (context) => CadastroEscritorFunctions(context)),
        Provider<ProfileUserFunctions>(
            create: (context) => ProfileUserFunctions(context)),
        Provider<HomePrincipalFunctions>(
            create: (context) => HomePrincipalFunctions(context)),
        Provider<LoginPrincipalFunctions>(
            create: (context) => LoginPrincipalFunctions(context)),
        Provider<CreateLoginFunctions>(
            create: (context) => CreateLoginFunctions(context)),
        Provider<FavoritePrincipaFunctions>(
            create: (context) => FavoritePrincipaFunctions(context)),
        Provider<DetalhesPrincipalFunctions>(
            create: (context) => DetalhesPrincipalFunctions(context)),

        // 🔹 STORES
        Provider<ResgistrarEscritorStore>(
            create: (context) => ResgistrarEscritorStore()),
        Provider<ProfileUserStore>(create: (context) => ProfileUserStore()),
        Provider<LivroDetalhesStore>(
            create: (context) => LivroDetalhesStore(context)),
        Provider<LoginPrincipalStore>(
            create: (context) => LoginPrincipalStore()),
        Provider<CreateLoginStore>(create: (context) => CreateLoginStore()),
        Provider<HomeStore>(create: (context) => HomeStore()),
        Provider<FavoriteStore>(create: (context) => FavoriteStore()),
        Provider<GlobalsStore>(create: (context) => GlobalsStore()),

        // 🔹 CHANGE NOTIFIERS
        ChangeNotifierProvider<UserInfos>(create: (_) => UserInfos()),
        ChangeNotifierProvider<GlobalsThemeVar>(
            create: (_) => GlobalsThemeVar()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    // 🔹 Aguarda o contexto estar disponível antes de chamar `_initializeApp()`
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initializeApp();
    });
  }

  Future<void> _initializeApp() async {
    final context = navigatorKey.currentContext;
    if (context == null) return;

    final userIds = Provider.of<UserIds>(context, listen: false);
    final userInfos = Provider.of<UserInfos>(context, listen: false);

    await AppInitializer.initialize(
      userIds,
      userInfos,
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      locale: Locale('pt'),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // 🔥 precisa desse
        GlobalWidgetsLocalizations.delegate, // 🔥 precisa desse
        GlobalCupertinoLocalizations.delegate, // 🔥 precisa desse
        quill.FlutterQuillLocalizations.delegate, // 🔥 para o Flutter Quill
      ],

      supportedLocales: const [
        Locale('en'), // inglês
        Locale('pt'), // português (opcional)
        // outros idiomas que quiser suportar
      ],
      navigatorObservers: [routeObserver],
      debugShowCheckedModeBanner: false,
      // theme: ThemeData(fontFamily: 'YourFontFamily'),
      home: GlobalsLoadingWidget(context).loagingPageInicio(
        MediaQuery.of(context).size.height,
        MediaQuery.of(context).size.width,
      ),
    );
  }
}
