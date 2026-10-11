import 'package:web/web.dart' as web;

Future<void> downloadCv() async {
  final anchor = web.HTMLAnchorElement()
    ..href = Uri.base.resolve('Haya_Obaid_CV.pdf').toString()
    ..download = 'Haya_Obaid_CV.pdf';
  anchor.click();
}
