import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart'
    show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:leitor_ebooks/globals/store/globals_store.dart';
import 'package:leitor_ebooks/pages/detalhes_livro.dart/store/detalhes_livro_store.dart';
import 'package:leitor_ebooks/pages/home/helper/download_helper_mobile.dart';
import 'package:leitor_ebooks/request/livros/get_livro_por_id.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/services.dart';
import 'package:leitor_ebooks/globals/globals_local_storage.dart';
import 'package:leitor_ebooks/globals/globlas_alert.dart';

import '../../modals/livro.dart';

class DetalhesPrincipalFunctions {
  BuildContext context;
  DetalhesPrincipalFunctions(this.context);

  late LivroDetalhesStore livroDetalhesStoreAux;
  late GlobalsStore globalsStoreAux;
  bool loading = false;
  List<String> listDownloads = [];
  List<String> listFavorite = [];

  Future detalhesFunctionPrincipal(GlobalsStore globalsStore,
      LivroDetalhesStore livroDetalhesStore, String livroId) async {
    listFavorite.clear();
    listDownloads.clear();
    await _loadDownloadsAndFavorites();

    globalsStoreAux = globalsStore;
    livroDetalhesStoreAux = livroDetalhesStore;

    await _fetchLivro(livroDetalhesStore, livroId);
  }

  Future<void> _loadDownloadsAndFavorites() async {
    final response = await GlobalsLocalStorage().getDownloads();
    final favorite = await GlobalsLocalStorage().getFavorite();
    listFavorite.addAll(favorite ?? []);
    listDownloads.addAll(response ?? []);
  }

  Future<void> _fetchLivro(
      LivroDetalhesStore livroDetalhesStore, String livroId) async {
    try {
      var result = await GetLivroPorIdRequest(context).getLivro(livroId);
      if (result != null) {
        livroDetalhesStore.setLivro(LivrosModel.fromJson(result));
      }
    } catch (e) {
      print("Erro ao buscar livros: $e");
    }
  }

  Future<void> fetchAndroidVersion(
      LivrosModel? livro, BuildContext contextAux) async {
    final String? version = await getAndroidVersion();
    if (version != null) {
      String? firstPart;
      if (version.contains(".")) {
        int indexOfFirstDot = version.indexOf(".");
        firstPart = version.substring(0, indexOfFirstDot);
      } else {
        firstPart = version;
      }
      int intValue = int.parse(firstPart);
      if (intValue >= 13) {
        await startDownload(livro, contextAux);
      } else {
        final PermissionStatus status = await Permission.storage.status;
        if (status.isGranted) {
          await startDownload(livro, contextAux);
          return;
        }
        final PermissionStatus statusFinal = await Permission.storage.request();
        if (statusFinal.isGranted) {
          await startDownload(livro, contextAux);
          return;
        }
        livro?.setLoading(false);
      }
    }
  }

  Future<String?> getAndroidVersion() async {
    try {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.version.release;
    } catch (e) {
      print("Erro ao obter informações: $e");
    }
    return null;
  }

  Future<void> startDownload(
      LivrosModel? livro, BuildContext contextAux) async {
    final downloadUrl = livro?.downloadUrl;
    if (downloadUrl == null || downloadUrl.isEmpty) {
      GlobalsAlert(contextAux).alertError(
        contextAux,
        text: 'URL de download inválida.',
      );
      livro?.setLoading(false);
      return;
    }

    try {
      final downloader = DownloadHelperImpl();
      await downloader.startDownload(
        url: downloadUrl,
        fileName: '${livro?.title ?? 'livro'}-${livro?.id}.epub',
      );

      listDownloads.add(livro?.id.toString() ?? '');
      await GlobalsLocalStorage().setDawmloads(listDownloads: listDownloads);
      livro?.setIsDownloadOk(true);
    } catch (e) {
      GlobalsAlert(contextAux).alertError(
        contextAux,
        text: 'Falha ao baixar o livro. Tente novamente.',
      );
      livro?.setIsDownloadOk(false);
    } finally {
      livro?.setLoading(false);
    }
  }

  Future<void> download(LivrosModel livro, BuildContext contextAux) async {
    if (kIsWeb) {
      await startDownload(livro, contextAux);
      return;
    }

    if (defaultTargetPlatform == TargetPlatform.iOS) {
      final PermissionStatus status = await Permission.storage.request();
      if (status == PermissionStatus.granted) {
        await startDownload(livro, contextAux);
      } else {
        await Permission.storage.request();
      }
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      await fetchAndroidVersion(livro, contextAux);
    } else {
      throw PlatformException(code: '500', message: 'Plataforma não suportada');
    }
  }
}
