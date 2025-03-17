import 'dart:convert';
import 'dart:developer';

import 'package:civix_app/constants.dart';
import 'package:civix_app/core/helper_functions/show_dialog.dart';
import 'package:civix_app/core/services/shared_prefrences_singleton.dart';
import 'package:civix_app/core/utils/app_images.dart';
import 'package:civix_app/features/auth/presentation/views/signin_view.dart';
import 'package:civix_app/features/home/presentation/views/home_view.dart';
import 'package:civix_app/features/on_boarding/presentation/views/on_boarding_view.dart';
import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();
    initAnimation();
    WidgetsBinding.instance.addPostFrameCallback((_) => executeNavigation());
  }

  @override
  void dispose() {
    _controller.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Image.asset(
              Assets.imagesLogo,
            ),
          ),
        ),
      ),
    );
  }

  void initAnimation() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _fadeController,
        curve: Curves.ease,
      ),
    );

    slideAnimation =
        Tween<Offset>(begin: const Offset(-2, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubicEmphasized,
      ),
    );

    scaleAnimation = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.ease,
    ));

    _controller.forward();
    _fadeController.forward();
  }

  void executeNavigation() async {
    final targetRoute = await getTargetRoute(); // Get the target route safely

    if (!mounted) return; // Prevent navigation after disposal

    if (targetRoute == 'tokenExpired') {
      Navigator.pushReplacementNamed(context, SigninView.routeName);
    } else {
      Navigator.pushReplacementNamed(context, targetRoute);
    }
  }

  Future<String> getTargetRoute() async {
    await Future.delayed(const Duration(milliseconds: 1200));

    bool isOnBoardingSeen = Prefs.getBool(kIsOnBoardingSeen) ?? false;
    String? user = await Prefs.getString(kUserData);

    if (isOnBoardingSeen) {
      if (user != null) {
        Map<String, dynamic> userMap = jsonDecode(user);
        var token = userMap['token'] ?? '';
        if (JwtDecoder.isExpired(token)) {
          await Prefs.remove(kUserData);
          return 'tokenExpired'; // Return the route
        } else {
          return HomeView.routeName; // Return the route
        }
      } else {
        return SigninView.routeName; // Return the route
      }
    } else {
      return OnBoardingView.routeName; // Return the route
    }
  }
}
