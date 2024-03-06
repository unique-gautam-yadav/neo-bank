import 'dart:math';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax/iconsax.dart';
import 'package:neo_bank/animations/fade_zoom.dart';
import 'package:neo_bank/buttons/scale_button.dart';
import 'package:neo_bank/features/onboarding/onboarding.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: .8);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomPaint(
        painter: HomePainter(),
        child: SafeArea(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(width: 20),
                  const FilledIconButton(
                    child: Row(
                      children: [
                        Icon(Iconsax.shapes_1),
                        SizedBox(width: 10),
                        Text("Hide balance"),
                      ],
                    ),
                  ),
                  const Spacer(),
                  FilledIconButton.rounded(
                    child: const Icon(Iconsax.more),
                  ),
                  const SizedBox(width: 20),
                ],
              ),
              const SizedBox(height: 80),
              FadeInAnimation(
                delay: 1,
                child: SizedBox(
                  height: 200,
                  width: double.infinity,
                  child: PageView(
                    controller: _pageController,
                    children: [
                      ScaleButton(
                        onTap: () {},
                        child: CreditCard(
                          colors: [
                            const Color(0xFFD44F93),
                            Colors.orange.shade200,
                            Colors.orange.shade700,
                          ],
                          lastDigits: '4923',
                        ),
                      ),
                      CreditCard(
                        colors: [
                          const Color(0xFFC54BEC),
                          Colors.deepPurple.shade900,
                        ],
                        lastDigits: '8941',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeIn(
                child: const Text(
                  "\$34839593.00",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              FadeInAnimation(
                delay: 1.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CustomPaint(
                      painter: CardPainter(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 30),
                        child: Column(
                          children: [
                            FadeInAnimation(
                              delay: 2,
                              child: _firstValueRow(),
                            ),
                            FadeInAnimation(
                              delay: 2.5,
                              child: _secondValueRow(),
                            ),
                            FadeInAnimation(
                              delay: 3,
                              child: _thirdValueRow(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _thirdValueRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Icon(Iconsax.airplane),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "210",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text("Miles earned")
            ],
          ),
        ],
      ),
    );
  }

  Padding _secondValueRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Icon(Iconsax.shapes),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "\$12324.00",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text("Cashback earned")
            ],
          ),
          Spacer(),
          SizedBox(
            width: 100,
            height: 30,
            child: Stack(
              children: [
                BrandImage(
                  right: 0,
                  assetName: 'assets/images/kfc.png',
                ),
                BrandImage(
                  right: 15,
                  assetName: 'assets/images/netflix.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Padding _firstValueRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Row(
        children: [
          Icon(Iconsax.align_horizontally),
          SizedBox(width: 20),
          Text(
            "\$12324.00",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Spacer(),
          SizedBox(
            width: 100,
            height: 30,
            child: Stack(
              children: [
                BrandImage(
                  right: 0,
                  assetName: 'assets/images/nike.png',
                ),
                BrandImage(
                  right: 15,
                  assetName: 'assets/images/pepsi.png',
                ),
                BrandImage(
                  right: 30,
                  assetName: 'assets/images/burger_king.png',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BrandImage extends StatelessWidget {
  const BrandImage({
    super.key,
    required this.right,
    required this.assetName,
  });

  final double right;
  final String assetName;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: right,
      height: 25,
      width: 25,
      child: Container(
        padding: const EdgeInsets.all(4),
        width: 25,
        height: 25,
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          assetName,
          height: 25,
          width: 25,
        ),
      ),
    );
  }
}

class CreditCard extends StatelessWidget {
  const CreditCard({
    super.key,
    required this.colors,
    required this.lastDigits,
  });

  final List<Color> colors;
  final String lastDigits;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      transform: const GradientRotation(pi * .22),
                      colors: colors,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          "● ● ● ●   ● ● ● ●  ● ● ● ●   ",
                          style: TextStyle(
                            fontSize: 8,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          lastDigits,
                          style: const TextStyle(
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 50,
                color: Colors.white,
                padding: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Gautam Yadav",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    SvgPicture.asset('assets/svgs/visa.svg'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePainter extends CustomPainter {
  HomePainter({this.radius = 400});

  final double radius;
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(0, -radius * 1.5),
          radius: radius,
        ),
      );

    canvas.drawShadow(
      path,
      Colors.pink.shade500,
      350,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class CardPainter extends CustomPainter {
  CardPainter();
  @override
  void paint(Canvas canvas, Size size) {
    Path path = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(size.width, -200),
          radius: 200,
        ),
      );
    Path path2 = Path()
      ..addOval(
        Rect.fromCircle(
          center: Offset(0, size.height - 200),
          radius: 200,
        ),
      );

    canvas.drawShadow(
      path2,
      Colors.yellow.shade300.withOpacity(.15),
      200,
      true,
    );
    canvas.drawShadow(
      path,
      Colors.pink.shade300.withOpacity(.15),
      200,
      true,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
