import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_portfolio/content/certificates_data.dart';
import 'package:my_portfolio/content/portfolio_content.dart';
import 'package:my_portfolio/content/projects_data.dart';
import 'package:my_portfolio/core/theme/app_colors.dart';
import 'package:my_portfolio/main.dart';
import 'package:my_portfolio/models/project.dart';
import 'package:my_portfolio/widgets/common/animated_backdrop.dart';
import 'package:my_portfolio/widgets/common/floating_tech_cloud.dart';
import 'package:my_portfolio/widgets/common/motion.dart';
import 'package:my_portfolio/widgets/contact.dart';
import 'package:my_portfolio/widgets/projects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:visibility_detector/visibility_detector.dart';

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
        'E-Commerce UI App',
      ]),
    );
    expect(kProjects.where((p) => p.hasGithubUrl).length, 4);
    expect(kProjects.every((p) => p.summary != null), isTrue);
    expect(kCertificates.where((c) => c.featured).length, 3);
  });

  test('project links survive JSON and copyWith', () {
    const project = PortfolioProject(
      title: 'Linked project',
      githubUrl: 'https://github.com/example/app',
      customUrl: 'https://example.com/app',
    );
    final restored = PortfolioProject.fromJson(project.toJson());
    expect(restored.githubUrl, project.githubUrl);
    expect(restored.customUrl, project.customUrl);
    expect(
      restored.copyWith(customUrl: 'https://example.com/demo').customUrl,
      'https://example.com/demo',
    );
    expect(
      PortfolioProject.fromJson({
        'title': 'Legacy',
        'url': 'https://github.com/example/old',
      }).githubUrl,
      'https://github.com/example/old',
    );
  });

  test('updated projects have descriptions and image placeholders', () {
    final projects = {for (final project in kProjects) project.id: project};
    for (final (id, imageCount) in [
      ('meethaq', 3),
      ('nova', 3),
      ('mahalli', 4),
      ('mira', 3),
    ]) {
      final project = projects[id]!;
      expect(project.description, isNotEmpty);
      expect(project.images.length, imageCount);
      expect(project.images, [
        for (var index = 1; index <= imageCount; index++)
          'assets/projects/$id-$index.png',
      ]);
    }
  });

  testWidgets('home renders at a narrow mobile width', (tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    tester.binding.platformDispatcher.platformBrightnessTestValue =
        Brightness.dark;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(
      tester.binding.platformDispatcher.clearPlatformBrightnessTestValue,
    );
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 750));
    expect(find.text('Download CV'), findsOneWidget);
    expect(find.byType(FloatingTechCloud), findsOneWidget);
    for (final skill in PortfolioContent.featuredTech) {
      expect(
        find.descendant(
          of: find.byType(FloatingTechCloud),
          matching: find.text(skill),
        ),
        findsOneWidget,
      );
    }
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      const Color(0xFF1F1E1B),
    );
    final projectFrame = find.descendant(
      of: find.byType(ProjectCard).first,
      matching: find.byWidgetPredicate(
        (widget) => widget is Material && widget.shape != null,
      ),
    );
    expect(
      tester.widget<Material>(projectFrame).color,
      const Color(0xFF151513),
    );
    expect(
      (tester
                  .widget<Container>(find.byKey(const Key('contact-callout')))
                  .decoration
              as BoxDecoration)
          .color,
      const Color(0xFF151513),
    );
    final logo = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.semanticLabel == 'Haya Obaid monogram brand artwork',
    );
    expect(
      (tester.widget<Image>(logo).image as AssetImage).assetName,
      'assets/brand/haya-logo-dark.png',
    );
    expect(tester.takeException(), isNull);

    expect(find.byIcon(Icons.light_mode_outlined), findsOneWidget);
    await tester.tap(find.byTooltip('Switch to light mode'));
    await tester.pump(const Duration(milliseconds: 750));
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      const Color(0xFFF1ECE4),
    );
    expect(
      tester.widget<Material>(projectFrame).color,
      const Color(0xFFE5DDD1),
    );
    expect(
      (tester
                  .widget<Container>(find.byKey(const Key('contact-callout')))
                  .decoration
              as BoxDecoration)
          .color,
      const Color(0xFF292720),
    );
    expect(
      (tester.widget<Image>(logo).image as AssetImage).assetName,
      'assets/brand/haya-logo-original.png',
    );
    expect(tester.takeException(), isNull);

    expect(find.byIcon(Icons.dark_mode_outlined), findsOneWidget);
    await tester.tap(find.byTooltip('Switch to dark mode'));
    await tester.pump(const Duration(milliseconds: 750));
    expect(
      tester.widget<Scaffold>(find.byType(Scaffold)).backgroundColor,
      const Color(0xFF1F1E1B),
    );
    expect(
      tester.widget<Material>(projectFrame).color,
      const Color(0xFF151513),
    );
    expect(
      (tester
                  .widget<Container>(find.byKey(const Key('contact-callout')))
                  .decoration
              as BoxDecoration)
          .color,
      const Color(0xFF151513),
    );
    expect(
      (await SharedPreferences.getInstance()).getString('portfolio_theme_mode'),
      'dark',
    );
  });

  testWidgets('project cover opens a multi-image carousel', (tester) async {
    const project = PortfolioProject(
      title: 'Demo project',
      description: 'A project with two real asset paths.',
      tags: ['Flutter'],
      images: [
        'assets/brand/haya-logo-original.png',
        'assets/brand/haya-logo-original.png',
      ],
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
        (widget) =>
            widget is Image &&
            widget.semanticLabel == 'Demo project cover image',
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

  testWidgets('project details auto slide, pause, and wrap', (tester) async {
    const project = PortfolioProject(
      title: 'Slideshow project',
      description: 'Three images and two destinations.',
      images: [
        'assets/brand/haya-logo-original.png',
        'assets/brand/haya-logo-original.png',
        'assets/brand/haya-logo-original.png',
      ],
      githubUrl: 'https://github.com/example/app',
      customUrl: 'https://example.com/app',
    );
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(width: 240, child: ProjectCard(project: project)),
          ),
        ),
      ),
    );
    await tester.tap(find.byType(ProjectCard));
    await tester.pumpAndSettle();
    expect(find.text('1 / 3'), findsOneWidget);
    expect(find.text('View on GitHub'), findsOneWidget);
    expect(find.text('Visit project'), findsOneWidget);
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('2 / 3'), findsOneWidget);
    await tester.tap(find.byTooltip('Pause slideshow'));
    await tester.pump(const Duration(seconds: 5));
    expect(find.text('2 / 3'), findsOneWidget);
    await tester.tap(find.byTooltip('Play slideshow'));
    await tester.pump(const Duration(seconds: 4));
    await tester.pump(const Duration(milliseconds: 700));
    expect(find.text('3 / 3'), findsOneWidget);
    await tester.tap(find.byTooltip('Next image'));
    await tester.pumpAndSettle();
    expect(find.text('1 / 3'), findsOneWidget);
    await tester.tap(find.byTooltip('Close project'));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('project card highlights on mouse hover', (tester) async {
    AppColors.isDark = false;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 240,
              child: ProjectCard(project: kProjects.first),
            ),
          ),
        ),
      ),
    );
    final frame = find.descendant(
      of: find.byType(ProjectCard),
      matching: find.byWidgetPredicate(
        (widget) => widget is Material && widget.shape != null,
      ),
    );
    expect(tester.widget<Material>(frame).elevation, 0);
    final mouse = await tester.createGesture(kind: PointerDeviceKind.mouse);
    await mouse.addPointer();
    await mouse.moveTo(tester.getCenter(find.byType(ProjectCard)));
    await tester.pumpAndSettle();
    expect(tester.widget<Material>(frame).elevation, 12);
    await mouse.moveTo(const Offset(0, 0));
    await tester.pumpAndSettle();
    expect(tester.widget<Material>(frame).elevation, 0);
    await mouse.removePointer();
  });

  testWidgets('section reveal starts when scrolled into view', (tester) async {
    tester.view.physicalSize = const Size(400, 400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 700),
                RevealOnScroll(
                  child: SizedBox(height: 100, child: Text('Revealed')),
                ),
              ],
            ),
          ),
        ),
      ),
    );
    final opacity = find.descendant(
      of: find.byType(RevealOnScroll),
      matching: find.byType(Opacity),
    );
    await tester.pump();
    expect(tester.widget<Opacity>(opacity).opacity, 0);
    await tester.drag(
      find.byType(SingleChildScrollView),
      const Offset(0, -500),
    );
    await tester.pumpAndSettle();
    expect(tester.widget<Opacity>(opacity).opacity, 1);
  });

  testWidgets('background moves and honors reduced motion', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: AnimatedBackdrop())),
    );
    final canvas = find.byKey(const Key('animated-backdrop'));
    final first = tester.widget<CustomPaint>(canvas).painter!;
    await tester.pump(const Duration(seconds: 2));
    final next = tester.widget<CustomPaint>(canvas).painter!;
    expect(next.shouldRepaint(first), isTrue);

    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: AnimatedBackdrop(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('animated-backdrop')), findsOneWidget);
  });

  testWidgets('floating tech badges honor reduced motion', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: MediaQuery(
            data: MediaQueryData(disableAnimations: true),
            child: SizedBox(
              width: 320,
              height: 320,
              child: FloatingTechCloud(),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byKey(const Key('floating-tech-cloud')), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('header progress follows page scroll', (tester) async {
    SharedPreferences.setMockInitialValues({});
    tester.view.physicalSize = const Size(800, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(const PortfolioApp());
    await tester.pump(const Duration(milliseconds: 800));
    final progress = find.byKey(const Key('page-scroll-progress'));
    expect(tester.widget<LinearProgressIndicator>(progress).value, 0);
    await tester.drag(
      find.byType(SingleChildScrollView).first,
      const Offset(0, -600),
    );
    await tester.pump(const Duration(milliseconds: 800));
    expect(
      tester.widget<LinearProgressIndicator>(progress).value,
      greaterThan(0),
    );
  });

  testWidgets('project strip opens a page with all phone cards', (
    tester,
  ) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    addTearDown(
      () => VisibilityDetectorController.instance.updateInterval =
          const Duration(milliseconds: 500),
    );
    AppColors.isDark = false;
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
    expect(cards, findsNWidgets(kProjects.length));
    expect(tester.getSize(cards.first).height, 470);
    expect(tester.getSize(cards.first).width, 240);
    expect(
      tester.getTopLeft(cards.at(0)).dy,
      tester.getTopLeft(cards.at(1)).dy,
    );
    expect(
      tester.getTopLeft(cards.at(1)).dx,
      greaterThan(tester.getTopLeft(cards.at(0)).dx),
    );
    final startingX = tester.getTopLeft(cards.first).dx;
    await tester.tap(find.byTooltip('Next projects'));
    await tester.pumpAndSettle();
    expect(tester.getTopLeft(cards.first).dx, lessThan(startingX));
    await tester.tap(find.byTooltip('Previous projects'));
    await tester.pumpAndSettle();
    final phoneFrames = find.descendant(
      of: cards.first,
      matching: find.byWidgetPredicate(
        (widget) => widget is Material && widget.color == AppColors.deviceFrame,
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
    expect(cards, findsNWidgets(kProjects.length));
    expect(tester.takeException(), isNull);
  });

  testWidgets('project carousel advances through the last project', (
    tester,
  ) async {
    VisibilityDetectorController.instance.updateInterval = Duration.zero;
    addTearDown(
      () => VisibilityDetectorController.instance.updateInterval =
          const Duration(milliseconds: 500),
    );
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(body: SingleChildScrollView(child: ProjectsSection())),
      ),
    );
    await tester.pump();
    for (var i = 0; i < kProjects.length; i++) {
      await tester.pump(const Duration(seconds: 3));
      await tester.pump(const Duration(milliseconds: 700));
    }
    final last = kProjects.length.toString().padLeft(2, '0');
    expect(find.text('$last / $last'), findsOneWidget);
    expect(find.byType(ProjectCard), findsNWidgets(kProjects.length));
  });

  testWidgets('all projects page fits a narrow mobile width', (tester) async {
    AppColors.isDark = false;
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

  testWidgets(
    'contact keeps secondary profiles available without crowding the callout',
    (tester) async {
      AppColors.isDark = false;
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(body: SingleChildScrollView(child: ContactSection())),
        ),
      );
      expect(find.text('Email me'), findsOneWidget);
      expect(find.text('LinkedIn'), findsOneWidget);
      expect(find.text('GitHub'), findsOneWidget);
      expect(find.text('Upwork'), findsNothing);
      await tester.ensureVisible(find.text('More ways to connect'));
      await tester.tap(find.text('More ways to connect'));
      await tester.pumpAndSettle();
      expect(find.text('Upwork'), findsOneWidget);
    },
  );

  testWidgets('contact actions stack cleanly on a narrow screen', (
    tester,
  ) async {
    AppColors.isDark = false;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          SystemChannels.platform,
          (call) async => null,
        );
    addTearDown(
      () => TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
          .setMockMethodCallHandler(SystemChannels.platform, null),
    );
    tester.view.physicalSize = const Size(320, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ContactSection(),
            ),
          ),
        ),
      ),
    );
    expect(find.text('Email me'), findsOneWidget);
    expect(find.text('Copy email'), findsOneWidget);
    expect(find.text('WhatsApp'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('LinkedIn')).dy,
      greaterThan(
        tester.getTopLeft(find.byKey(const Key('contact-callout'))).dy,
      ),
    );
    await tester.ensureVisible(find.text('Copy email'));
    await tester.tap(find.text('Copy email'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text('Email address copied'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
