import 'package:url_launcher/url_launcher.dart';

import 'constants.dart';

Future<void> downloadCv() async {
  await launchUrl(
    Uri.parse(AppConstants.cv),
    mode: LaunchMode.externalApplication,
  );
}
