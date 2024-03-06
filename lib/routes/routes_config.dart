import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:neo_bank/features/home/home_screen.dart';
import 'package:neo_bank/features/onboarding/onboarding.dart';
import 'package:neo_bank/routes/routes.dart';

final router = GoRouter(
  initialLocation: AppRoutes.onBoarding.path,
  routes: [
    GoRoute(
      name: AppRoutes.onBoarding.name,
      path: AppRoutes.onBoarding.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: OnboardingScreen(),
      ),
    ),
    GoRoute(
      name: AppRoutes.home.name,
      path: AppRoutes.home.path,
      pageBuilder: (context, state) => const CupertinoPage(
        child: HomePage(),
      ),
    )
  ],
);
