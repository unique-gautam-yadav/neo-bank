class APR {
  final String name;
  final String path;
  APR({
    required this.name,
    required this.path,
  });
}

class AppRoutes {
  static APR onBoarding = APR(name: 'onboarding', path: '/onboardin');
  static APR home = APR(name: 'home', path: '/home');
}
