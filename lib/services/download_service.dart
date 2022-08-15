import 'package:flutter/foundation.dart';
import 'package:universal_html/html.dart' as html;

abstract class DownloadService {
  Future<void> download({required String url});
}

class MobileDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) {
    throw UnimplementedError();
  }
}

class WebDownloadService implements DownloadService {
  @override
  Future<void> download({required String url}) async {
    html.window.open(url, "_blank");
  }
}

Future<void> downloadFile(String url) async {
  DownloadService downloadService =
  kIsWeb ? WebDownloadService() : MobileDownloadService();
  await downloadService.download(url: url);
}