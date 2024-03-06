import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_tilt/flutter_tilt.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank/animations/fade_zoom.dart';
import 'package:neo_bank/buttons/scale_button.dart';
import 'package:neo_bank/features/onboarding/models/tilted_card_model.dart';
import 'package:neo_bank/features/onboarding/widgets/onboarding_bg_painter.dart';
import 'package:neo_bank/routes/routes.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  late List<TiltedCardModel> cards;
  List<Offset> positions = [
    const Offset(10.0, 20.0), // 0
    const Offset(150.0, 30.0), // 1
    const Offset(400.0, 50.0), // 2
    const Offset(300.0, 50.0), // 3
    const Offset(400.0, 180.0), // 4
    const Offset(20.0, 180.0), // 5
    const Offset(500.0, 300.0), // 6
    const Offset(30.0, 400.0), // 7
    const Offset(350.0, 450.0), // 8
    const Offset(700.0, 450.0), // 9
    const Offset(180.0, 500.0), // 10
    const Offset(450.0, 520.0), // 11
    const Offset(20.0, 550.0), // 12
    const Offset(360.0, 580.0), // 13
    const Offset(550.0, 50.0), // 14
    const Offset(420.0, 320.0), // 15
  ];

  bool placeCard = false;

  @override
  void initState() {
    super.initState();
    setPositions();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0, end: 400).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    )..addListener(() {
        setState(() {});
      });

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _animationController.forward();
      Future.delayed(const Duration(milliseconds: 800)).then((_) {
        setState(() {
          placeCard = true;
        });
      });
    });
  }

  void setPositions() {
    Random random = Random();

    cards = List.generate(
      16,
      (index) {
        return TiltedCardModel(
          tiltOffset: Offset(
            random.nextBool()
                ? -random.nextDouble() * 2.0
                : -random.nextDouble() * 2.0,
            random.nextBool()
                ? random.nextDouble() * 2.0
                : random.nextDouble() * 2.0,
          ),
          angle: random.nextDouble() * pi,
          position: positions[index],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomPaint(
        painter: OnboardingBGPainter(
          radius: _animation.value,
        ),
        child: Stack(
          children: [
            ...cards.map(
              (e) => AnimatedPositioned(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastEaseInToSlowEaseOut,
                left: placeCard
                    ? e.position.dx
                    : MediaQuery.sizeOf(context).width / 2 - 17,
                top: placeCard ? e.position.dy : 200,
                child: Transform.rotate(
                  angle: e.angle,
                  child: Tilt(
                    borderRadius: BorderRadius.circular(3),
                    tiltConfig: TiltConfig(
                      initial: e.tiltOffset,
                    ),
                    lightConfig: LightConfig(
                      color: Colors.blue.shade900,
                    ),
                    child: Container(
                      height: 50,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.4),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            ...cards.map(
              (e) => AnimatedPositioned(
                duration: const Duration(milliseconds: 2000),
                curve: Curves.fastEaseInToSlowEaseOut,
                right: placeCard
                    ? e.position.dx
                    : MediaQuery.sizeOf(context).width / 2 - 17,
                top: placeCard ? e.position.dy : 195,
                child: Opacity(
                  opacity: .1,
                  child: Transform.rotate(
                    angle: e.angle,
                    child: Tilt(
                      borderRadius: BorderRadius.circular(3),
                      tiltConfig: TiltConfig(
                        initial: e.tiltOffset,
                      ),
                      lightConfig: LightConfig(
                        color: Colors.blue.shade900,
                      ),
                      child: Container(
                        height: 60,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(.4),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              top: 80,
              right: 20,
              child: FilledIconButton(
                child: Text("Skip"),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Transform.rotate(
                            angle: pi * .3,
                            child: Tilt(
                              shadowConfig: const ShadowConfig(disable: true),
                              borderRadius: BorderRadius.circular(15),
                              tiltConfig: const TiltConfig(
                                initial: Offset(-1, -1),
                              ),
                              lightConfig: const LightConfig(
                                color: Color(0xFFD44F93),
                              ),
                              child: Container(
                                height: 300,
                                width: 200,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF683C1C),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 80),
                  const FadeInAnimation(
                    delay: 1,
                    child: Text(
                      "An exceptional offer",
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  FadeInAnimation(
                    delay: 1.25,
                    child: Text(
                      "in a limitless world of credit cards",
                      style: TextStyle(
                          fontSize: 16, color: Colors.white.withOpacity(.6)),
                    ),
                  ),
                  const SizedBox(height: 30),
                  FadeInAnimation(
                    delay: 1.5,
                    child: Text(
                      "Visa Gold© card with all applied\nrewards and benefits and more.",
                      style: TextStyle(
                          fontSize: 16, color: Colors.white.withOpacity(.6)),
                    ),
                  ),
                  const SizedBox(height: 50),
                  FadeInAnimation(
                    delay: 1.75,
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 70,
                        ),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        context.push(AppRoutes.home.path);
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(),
                      ),
                    ),
                  ),
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FilledIconButton extends StatelessWidget {
  const FilledIconButton({
    super.key,
    required this.child,
    this.padding,
  });

  final Widget child;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return ScaleButton(
      onTap: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color(0xFF461B3B),
        ),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: child,
      ),
    );
  }

  static Widget rounded({
    required Widget child,
    double padding = 10,
  }) {
    return FilledIconButton(
      padding: EdgeInsets.all(padding),
      child: child,
    );
  }
}
