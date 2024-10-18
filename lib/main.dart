import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explicit Animation with Tween',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AnimationDemo(),
    );
  }
}

class AnimationDemo extends StatefulWidget {
  const AnimationDemo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AnimationDemoState createState() => _AnimationDemoState();
}

class _AnimationDemoState extends State<AnimationDemo>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isAnimating = false;

  @override
  void initState() {
    super.initState();
    // Initialize AnimationController
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Initialize Tween to animate the position from 0.0 to 1.0
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  // Toggle animation on button press
  void _toggleAnimation() {
    if (_isAnimating) {
      _controller.stop();
    } else {
      _controller.repeat();
    }
    setState(() {
      _isAnimating = !_isAnimating;
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
      appBar: AppBar(
        title: const Text("Explicit Animation"),
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Stack(
              children: [
                // Animate the Container widget using Tween and AnimationBuilder
                Positioned(
                  left: MediaQuery.of(context).size.width * _animation.value,
                  top: 100,
                  child: Container(
                    width: 100,
                    height: 100,
                    color: Colors.blue,
                  ),
                ),
              ],
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _toggleAnimation,
        child: Icon(_isAnimating ? Icons.pause : Icons.play_arrow),
      ),
    );
  }
}
