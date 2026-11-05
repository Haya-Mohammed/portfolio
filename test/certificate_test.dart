import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/models/certificate.dart';
import 'package:my_portfolio/widgets/about.dart';

void main() {
  test('certificate fields survive JSON conversion', () {
    const certificate = Certificate(
      title: 'Flutter course',
      hours: 40,
      url: 'https://example.com/certificate',
      skills: ['Flutter', 'Dart'],
    );

    final restored = Certificate.fromJson(certificate.toJson());
    expect(restored.hours, 40);
    expect(restored.url, certificate.url);
    expect(restored.skills, ['Flutter', 'Dart']);
  });

  testWidgets('certificate entry shows optional fields at narrow width', (
    tester,
  ) async {
    const certificate = Certificate(
      title: 'Flutter course',
      issuer: 'Example Academy',
      date: 'Oct 2026',
      hours: 40,
      url: 'https://example.com/certificate',
      skills: ['Flutter', 'Responsive layouts'],
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SizedBox(
            width: 220,
            child: CertificateEntry(certificate: certificate),
          ),
        ),
      ),
    );

    expect(find.text('Example Academy · Oct 2026 · 40 hours'), findsOneWidget);
    expect(find.text('Flutter'), findsOneWidget);
    expect(find.text('Responsive layouts'), findsOneWidget);
    expect(find.text('View certificate'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: CertificateEntry(
            certificate: Certificate(title: 'Unlinked course'),
          ),
        ),
      ),
    );
    expect(find.text('View certificate'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
