import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/widgets/projects.dart';

void main() {
  test('CV projects and existing portfolio projects remain available', () {
    final titles = PortfolioContent.projects.map((p) => p.title).toSet();
    expect(
      titles,
      containsAll(<String>[
        'SuperFit',
        'Meethaq',
        'Wareed',
        'Gym App',
        'Notes App',
        'Books App',
        'News App',
        'Social App',
        'Shop App',
        'Cookbook App',
        'Pizza Delivery App',
        'E-Commerce UI App',
      ]),
    );
    expect(PortfolioContent.projects.where((p) => p.url != null).length, 4);
  });

  testWidgets('home renders at a narrow mobile width', (tester) async {
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();
    expect(find.text('Download CV'), findsOneWidget);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.dark_mode));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.light_mode), findsOneWidget);
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, const Color(0xFF1F1E1B));
    expect(tester.takeException(), isNull);

    await tester.tap(find.byIcon(Icons.light_mode));
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.dark_mode), findsOneWidget);
  });

  testWidgets('project cover opens a multi-image carousel', (tester) async {
    const project = PortfolioProject(
      title: 'Demo project',
      description: 'A project with two real asset paths.',
      tags: ['Flutter'],
      images: ['assets/brand/haya-logo-original.png', 'assets/brand/haya-logo-original.png'],
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(width: 360, child: ProjectCard(project: project)),
          ),
        ),
      ),
    );
    await tester.tap(find.text('View 2 images'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Next image'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);
  });
}
