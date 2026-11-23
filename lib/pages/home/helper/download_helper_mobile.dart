import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'download_helper.dart';

class DownloadHelperImpl extends DownloadHelper {
  @override
  Future<void> startDownload({
    required String url,
    required String fileName,
  }) async {
    final Directory appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory() ?? await getApplicationDocumentsDirectory()
        : await getApplicationDocumentsDirectory();

    final String path = '${appDocDir.path}/$fileName';
    // final File file = File(path);

    await Dio().download(url, path);
  }
}
