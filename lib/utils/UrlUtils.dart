import 'package:url_launcher/url_launcher.dart';

Future<void> launchInBrowser(final Uri url) async {
  await launchUrl(url, mode: LaunchMode.externalApplication);
}
