export 'download_helper_mobile.dart'
  if (dart.library.html) 'download_helper_web.dart';

abstract class DownloadHelper {
  Future<void> startDownload({
    required String url,
    required String fileName,
  });
}
