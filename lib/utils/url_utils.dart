import 'package:url_launcher/url_launcher.dart';

Future<void> openLink(String url) async {
  final uri = Uri.parse(url);

  if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
    throw Exception('无法打开网址: $url');
  }
}
