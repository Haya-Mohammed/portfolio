import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/content/projects_data.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/theme/app_theme.dart';
import 'package:my_portfolio/widgets/contact.dart';
import 'package:my_portfolio/widgets/projects.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('portfolio projects remain available', () {
    final titles = kProjects.map((p) => p.title).toSet();
    expect(
      titles,
      containsAll(<String>[
        'SuperFit',
        'Meethaq – Project & Contract Management',
        'NOVA – The Fashion Edit',
        'Mahalli - Smart Store Management App',
        'Mira – Beauty Salon Booking App',
        'Wareed',
        'Gym App',
        'Notes App',
        'Books App',
        'Alhayaa News App',
        'Cookbook App',
        'Pizza Delivery App',
        'E-Commerce UI App',
      ]),
    );
    expect(kProjects.where((p) => p.url != null).length, 4);
    expect(kProjects.every((p) => p.summary != null), isTrue);
    expect(PortfolioContent.certificates.where((c) => c.featured).length, 3);
  });

  test('updated projects have descriptions and image placeholders', () {
    final projects = {for (final project in kProjects) project.id: project};
    for (final (id, imageCount) in [('meethaq', 3), ('nova', 3), ('mahalli', 4), ('mira', 3)]) {
      final project = projects[id]!;
      expect(project.description, isNotEmpty);
      expect(project.images.length, imageCount);
      expect(project.images, [
        for (var index = 1; index <= imageCount; index++) 'assets/projects/$id-$index.jpg',
      ]);
    }
  });

  testWidgets('home renders at a narrow mobile width', (tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    tester.binding.platformDispatcher.platformBrightnessTestValue = Brightness.dark;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.binding.platformDispatcher.clearPlatformBrightnessTestValue);
    await tester.pumpWidget(const PortfolioApp());
    await tester.pumpAndSettle();
    expect(find.text('Download CV'), findsOneWidget);
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, const Color(0xFF1F1E1B));
    final projectFrame = find.descendant(
      of: find.byType(ProjectCard).first,
      matching: find.byWidgetPredicate((widget) => widget is Material && widget.shape != null),
    );
    expect(tester.widget<Material>(projectFrame).color, const Color(0xFF151513));
    expect(
      (tester.widget<Container>(find.byKey(const Key('contact-callout'))).decoration
              as BoxDecoration)
          .color,
      const Color(0xFF151513),
    );
    final logo = find.byWidgetPredicate(
      (widget) => widget is Image && widget.semanticLabel == 'Haya Obaid monogram brand artwork',
    );
    expect(
      (tester.widget<Image>(logo).image as AssetImage).assetName,
      'assets/brand/haya-logo-dark.png',
    );
    expect(tester.takeException(), isNull);

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    await tester.tap(find.byTooltip('Switch to light mode'));
    await tester.pumpAndSettle();
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, const Color(0xFFF1ECE4));
    expect(tester.widget<Material>(projectFrame).color, const Color(0xFFE5DDD1));
    expect(
      (tester.widget<Container>(find.byKey(const Key('contact-callout'))).decoration
              as BoxDecoration)
          .color,
      const Color(0xFFE3DCD2),
    );
    expect(
      (tester.widget<Image>(logo).image as AssetImage).assetName,
      'assets/brand/haya-logo-original.png',
    );
    expect(tester.takeException(), isNull);

    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    await tester.tap(find.byTooltip('Switch to dark mode'));
    await tester.pumpAndSettle();
    expect(tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor, const Color(0xFF1F1E1B));
    expect(tester.widget<Material>(projectFrame).color, const Color(0xFF151513));
    expect(
      (tester.widget<Container>(find.byKey(const Key('contact-callout'))).decoration
              as BoxDecoration)
          .color,
      const Color(0xFF151513),
    );
    expect((await SharedPreferences.getInstance()).getString('portfolio_theme_mode'), 'dark');
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
    final cover = tester.widget<Image>(
      find.byWidgetPredicate(
        (widget) => widget is Image && widget.semanticLabel == 'Demo project cover image',
      ),
    );
    expect(cover.fit, BoxFit.contain);
    final description = tester.widget<Text>(find.text(project.description!));
    expect(description.maxLines, 3);
    expect(description.overflow, TextOverflow.ellipsis);
    await tester.tap(find.text('View 2 images'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 2'), findsOneWidget);
    await tester.tap(find.byTooltip('Next image'));
    await tester.pumpAndSettle();
    expect(find.text('2 / 2'), findsOneWidget);
  });

  testWidgets('project strip opens a page with all phone cards', (tester) async {
    Brand.isDark = false;
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ProjectsSection())),
      ),
    );
    await tester.pumpAndSettle();
    final cards = find.byType(ProjectCard);
    expect(cards, findsNWidgets(6));
    expect(tester.getSize(cards.first).height, 470);
    expect(tester.getSize(cards.first).width, 240);
    expect(tester.getTopLeft(cards.at(0)).dy, tester.getTopLeft(cards.at(1)).dy);
    expect(tester.getTopLeft(cards.at(1)).dx, greaterThan(tester.getTopLeft(cards.at(0)).dx));
    final startingX = tester.getTopLeft(cards.first).dx;
    await tester.tap(find.byTooltip('Next projects'));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(cards.first).dx, lessThan(startingX));
    await tester.tap(find.byTooltip('Previous projects'));
    await tester.pumpAndSettle();
    final phoneFrames = find.descendant(
      of: cards.first,
      matching: find.byWidgetPredicate(
        (widget) => widget is Material && widget.color == Brand.deviceFrame,
      ),
    );
    expect(phoneFrames, findsOneWidget);
    await tester.tap(cards.first);
    await tester.pumpAndSettle();
    expect(find.byTooltip('Close project'), findsOneWidget);
    await tester.tap(find.byTooltip('Close project'));
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('See all projects'));
    await tester.tap(find.text('See all projects'));
    await tester.pumpAndSettle();
    expect(find.byType(AllProjectsScreen), findsOneWidget);
    expect(find.text('All projects'), findsOneWidget);
    expect(cards, findsNWidgets(kProjects.length));
    await tester.tap(find.byTooltip('Back'));
    await tester.pumpAndSettle();
    expect(find.byType(AllProjectsScreen), findsNothing);
    expect(cards, findsNWidgets(6));
    expect(tester.takeException(), isNull);
  });

  testWidgets('all projects page fits a narrow mobile width', (tester) async {
    Brand.isDark = false;
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const MaterialApp(home: AllProjectsScreen()));
    await tester.pumpAndSettle();
    expect(find.byType(ProjectCard), findsNWidgets(kProjects.length));
    expect(tester.getSize(find.byType(ProjectCard).first).width, 240);
    expect(tester.takeException(), isNull);
  });

  testWidgets('contact keeps secondary profiles available without crowding the callout', (
    tester,
  ) async {
    Brand.isDark = false;
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: ContactSection())));
    expect(find.text('Email me'), findsOneWidget);
    expect(find.text('LinkedIn'), findsOneWidget);
    expect(find.text('GitHub'), findsOneWidget);
    expect(find.text('Upwork'), findsNothing);
    await tester.tap(find.text('More ways to connect'));
    await tester.pumpAndSettle();
    expect(find.text('Upwork'), findsOneWidget);
  });
}
