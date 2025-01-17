import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:Lostify/backend/login_details.dart';
import 'package:Lostify/components/navigation.dart';
import 'package:Lostify/pages/login_page.dart';
import 'package:Lostify/security_layouts/security_pages/security_layout.dart';
import 'package:Lostify/theme/default_theme.dart';

class LoginIntermediatePage extends StatefulWidget {
  const LoginIntermediatePage({super.key});

  @override
  State<LoginIntermediatePage> createState() => _LoginIntermediatePageState();
}

class _LoginIntermediatePageState extends State<LoginIntermediatePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<double> _nonBouncyAnimation;

  @override
  void initState() {
    super.initState();
    selectedPageIndex = 1;
    selectedSecurityPageIndex = 1;
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    const curve = Cubic(0.7, 0, 0.04, 1.0); // Customize this to your needs
    _animation = CurvedAnimation(parent: _animationController, curve: curve)
      ..addListener(() {
        setState(() {});
      });
    const nonBouncyCurve = Cubic(1, 0.01, 0.54, 1);
    _nonBouncyAnimation =
        CurvedAnimation(parent: _animationController, curve: nonBouncyCurve)
          ..addListener(() {
            setState(() {});
          });
    // _animation = Tween<double>(begin: 0, end: 1).animate(_controller)
    //   ..addListener(() {
    //     setState(() {});
    //   });

    _animationController.forward().then((value) {
      // Navigator.pushReplacement(context, PageRouteBuilder(
      //     pageBuilder: (context, animation, secondaryAnimation) {
      //   return const Layout();
      // }));
      navigateToAppropriatePostVerificationPage(context, this);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double topPaddingHeight = MediaQuery.of(context).padding.top;
    return Stack(
      children: [
        layoutWidget,
        AnimatedBuilder(
          animation: _nonBouncyAnimation,
          builder: (BuildContext context, Widget? child) {
            return BackdropFilter(
              filter: ImageFilter.blur(
                  sigmaX: 5 * (1 - _nonBouncyAnimation.value),
                  sigmaY: 5 * (1 - _nonBouncyAnimation.value)),
              child: Container(
                  color: backgroundAnimationColor.withOpacity(
                      0.5 * (1 - _nonBouncyAnimation.value).abs())),
            );
          },
        ),
        AnimatedBuilder(
          animation: _animation,
          builder: (BuildContext context, Widget? child) {
            return Transform.translate(
              offset: Offset(
                0,
                -_animation.value *
                    (screenHeight -
                        56.0 -
                        topPaddingHeight), // 56.0 is the height of the app bar
              ),
              // child: loginPageContent(context, _animationController),
              child: Stack(children: [
                const LoginPage(),
                Column(
                  children: [
                    const Spacer(),
                    Opacity(
                        opacity: _nonBouncyAnimation.value,
                        child: currentAppBar),
                  ],
                )
              ]),
            );
          },
        ),
      ],
    );
  }
}
