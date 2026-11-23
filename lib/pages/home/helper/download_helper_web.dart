import 'dart:js' as js;
import 'download_helper.dart';

class DownloadHelperImpl extends DownloadHelper {
  @override
  Future<void> startDownload({
    required String url,
    required String fileName,
  }) async {
    js.context.callMethod('open', [url]);
  }
}
