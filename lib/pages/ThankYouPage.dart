import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:confetti/confetti.dart';

import '../services/UserServices/AuthService.dart';
import 'login.dart';

class ThankYouPage extends StatefulWidget {
  const ThankYouPage({super.key});

  @override
  _ThankYouPageState createState() => _ThankYouPageState();
}

class _ThankYouPageState extends State<ThankYouPage>
    with SingleTickerProviderStateMixin {
  int _countdown = 5;
  final AuthService authService = AuthService();
  late AnimationController _controller;
  late ConfettiController _confettiController;

  @override
  void initState() {
    super.initState();
    _controller =
    AnimationController(vsync: this, duration: const Duration(seconds: 1))
      ..repeat(reverse: true);
    _confettiController =
    ConfettiController(duration: const Duration(seconds: 5))
      ..play();
    _startCountdown();
  }

  @override
  void dispose() {
    _controller.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _startCountdown() {
    Future.delayed(const Duration(seconds: 1), () {
      if (_countdown > 0) {
        setState(() {
          _countdown--;
        });
        _startCountdown();
      } else {
        if (mounted) {
          Navigator.of(context).pushReplacement(
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) => LoginPage(authService: authService),
              transitionsBuilder: (context, animation, secondaryAnimation, child) {
                // Define fade and scale transition
                final fadeAnimation = CurvedAnimation(parent: animation, curve: Curves.easeOutSine);
                final scaleAnimation = Tween<double>(begin: 0.2, end: 1.0).animate(fadeAnimation);

                return FadeTransition(
                  opacity: fadeAnimation,
                  child: ScaleTransition(
                    scale: scaleAnimation,
                    child: child,
                  ),
                );
              },
            ),
          );

        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(18, 149, 117, 1),
      body: Stack(
        children: [
          // Particle Animation (Background)
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(18, 149, 117, 1),
                    Color.fromRGBO(10, 124, 111, 1),
                    Color.fromRGBO(33, 170, 170, 1),
                    Color.fromRGBO(21, 100, 170, 1),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Icon
                AnimatedContainer(
                  duration: const Duration(seconds: 1),
                  curve: Curves.elasticInOut,
                  child: const Icon(
                    Icons.emoji_events_rounded,
                    size: 100,
                    color: Colors.amber,
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()
                      ..shader = const LinearGradient(
                        colors: [Colors.amber, Colors.orange],
                      ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  'You are now upgraded to Chef.',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // Countdown with Flip Animation
                Stack(
                  alignment: Alignment.center,
                  children: [
                    // Card-flipping countdown animation
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: Tween<double>(begin: 0.5, end: 1.0).animate(animation),
                          child: child,
                        );
                      },
                      child: Container(
                        key: ValueKey<int>(_countdown),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                        child: Text(
                          '$_countdown',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                            color: Color.fromRGBO(18, 149, 117, 1),
                          ),
                        ),
                      ),
                    ),
                    // Subtitle text
                    const Positioned(
                      bottom: 50,
                      child: Text(
                        'Redirecting you shortly...',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white70,
                        ),
                      ),
                    ),
                  ],
                ),


                const SizedBox(height: 32),
                // Redirecting Message
                const Text(
                  'Redirecting to the login page...',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 16),
                // Spinner for Extra Animation
                const SpinKitFadingCircle(
                  color: Colors.white,
                  size: 40,
                ),
              ],
            ),
          ),
          // Confetti Animation
          Align(
            alignment: Alignment.topCenter,
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirectionality: BlastDirectionality.explosive,
              shouldLoop: false,
              colors: const [
                Colors.yellow,
                Colors.red,
                Colors.white,
                Colors.blue,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
