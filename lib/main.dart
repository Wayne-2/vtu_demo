import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:regentspacevtu/demo_pages/utils/navigator.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: LoadingPage(),
  ));
}

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  Color myColor = const Color.fromARGB(255, 255, 247, 234);
  Color appNameColor = const Color.fromARGB(204, 0, 0, 0);
  Color primaryapptheme = const Color.fromARGB(255, 250, 182, 144);
  Color homePagebgColor = const Color.fromARGB(255, 255, 247, 234);
  Color iconthemeColor = const Color.fromARGB(204, 0, 0, 0);

  @override
  void initState() {
    super.initState();

    // Status bar color & immersive mode
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Animation for fade-in effect
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 6), () {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (_) => BottomNav(
          appNameColor: appNameColor,
          myColor: myColor,
          primaryapptheme: primaryapptheme,
          homePagebgColor: homePagebgColor,
          iconthemeColor: iconthemeColor,
          selectedBgImagePath: 'assets/newbg.png',
        ),
      ));
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFE5D1), // light peach
              Color(0xFFFAB690), // primary theme
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo
              Image.asset(
                'assets/addLogo.png',
                width: 150,
                height: 150,
              ),
              const SizedBox(height: 30),

              // App Name
              Text(
                'Regents VTU Demo',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                  color: Colors.brown.shade900,
                ),
              ),

              const SizedBox(height: 20),

              // Sub-text (tagline)
              const Text(
                'Just • demoing • the • app',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),

              const SizedBox(height: 40),

              // Loading Indicator
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                strokeWidth: 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
