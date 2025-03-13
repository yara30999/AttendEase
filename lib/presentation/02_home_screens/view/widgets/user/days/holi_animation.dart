import 'dart:math' as math;
import 'package:easy_localization/easy_localization.dart' as easyLocale;
import 'package:flutter/material.dart';
import '../../../../../resourses/colors_manager.dart';
import '../../../../../resourses/styles_manager.dart';
import '../../time/live_date_time.dart';
import '../time_card.dart';

class HoliAnimation extends StatefulWidget {
  final String groupName;
  const HoliAnimation(this.groupName, {super.key});

  @override
  State<StatefulWidget> createState() {
    return HoliAnimationState();
  }
}

class HoliAnimationState extends State<HoliAnimation>
    with TickerProviderStateMixin {
  int colorParticles = 250;
  bool isIncreasing = true;
  late AnimationController _particleAnimationController;
  late AnimationController _particleController;
  late AnimationController _cloudController;
  late AnimationController _rainController;
  late Animation<int> _particleAnimation;
  bool showMessage = false;

  @override
  void initState() {
    super.initState();
    _particleController = AnimationController(
      duration: const Duration(milliseconds: 40),
      vsync: this,
    )..repeat();
    _cloudController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();
    _rainController = AnimationController(
      duration: const Duration(milliseconds: 10000),
      vsync: this,
    )..repeat();
    // Store reference to the AnimationController
    _particleAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _particleAnimation = IntTween(begin: 100, end: 300).animate(
      CurvedAnimation(
        parent: _particleAnimationController, // Use stored reference
        curve: Curves.easeInOut,
      ),
    )..addListener(() {
      setState(() {
        colorParticles = _particleAnimation.value;
      });
    });
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          showMessage = true;
        });
      }
    });
  }

  @override
  void dispose() {
    _particleController.dispose();
    _cloudController.dispose();
    _rainController.dispose();
    _particleAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            HSVColor.fromAHSV(
              1.0,
              _cloudController.value * 360,
              0.3,
              0.95,
            ).toColor(),
            HSVColor.fromAHSV(
              1.0,
              (_cloudController.value * 360 + 60) % 360,
              0.2,
              0.9,
            ).toColor(),
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _cloudController,
              builder: (context, child) {
                return CloudLayer(_cloudController);
              },
            ),
          ),
          Positioned.fill(
            top: 140,
            child: AnimatedBuilder(
              animation: _rainController,
              builder: (context, child) {
                return ColorRain(_rainController);
              },
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 0,
                  children: [
                    SizedBox(height: 30),
                    Text(
                      widget.groupName,
                      style: Styles.style24Bold().copyWith(
                        color: ColorsManager.black,
                      ),
                    ),
                    TimeCard(
                      color: Colors.white.withValues(alpha: 0.90),
                      textColor: ColorsManager.black,
                    ),
                    LiveDateTime(textColor: ColorsManager.black),
                  ],
                ),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ColorBurstWidget(colorParticles, _particleController),
                      if (showMessage)
                        AnimatedOpacity(
                          opacity: showMessage ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 1000),
                          child: const HoliMessageWidget(),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CloudLayer extends StatelessWidget {
  final AnimationController controller;
  static final rng = math.Random();

  const CloudLayer(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final cloudWidgets = <Widget>[];
    for (int i = 0; i < 6; i++) {
      double xPos =
          (i * 120 + controller.value * 300) % (size.width + 300) - 150;
      double yPos = 50 + (i % 3) * 60;
      double cloudScale = 1.0 + (i % 3) * 0.5;
      cloudWidgets.add(
        Positioned(
          left: xPos,
          top: yPos,
          child: Opacity(
            opacity: 0.7,
            child: Transform.scale(scale: cloudScale, child: const Cloud()),
          ),
        ),
      );
    }
    return Stack(children: cloudWidgets);
  }
}

class Cloud extends StatelessWidget {
  const Cloud({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      height: 100,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            left: 50,
            child: Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 90,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 30,
            child: Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            left: 60,
            bottom: 10,
            child: Container(
              width: 75,
              height: 75,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.9),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ColorRain extends StatelessWidget {
  final AnimationController controller;
  static final rng = math.Random();

  static final List<Color> rainColors = [
    const Color(0xFFE91E63), // Pink
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF2196F3), // Blue
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFFEB3B), // Yellow
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFF5722), // Deep Orange
  ];

  const ColorRain(this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final droplets = <Widget>[];
    for (int i = 0; i < 5; i++) {
      final startPos = (i * 37) % size.width;
      final speed = 1.0 + (i % 5) * 0.2;
      final dropColor = rainColors[i % rainColors.length];
      final dropSize = 7.0 + (i % 4) * 1.0;
      final baseOffset = controller.value * speed * size.height * 2;
      final yPos = (baseOffset + i * 30) % (size.height + 100) - 50;
      droplets.add(
        Positioned(
          left: startPos.toDouble(),
          top: yPos,
          child: ColorDrop(dropColor, size: dropSize),
        ),
      );
    }
    return Stack(children: droplets);
  }
}

class ColorDrop extends StatelessWidget {
  final Color color;
  final double size;

  const ColorDrop(this.color, {required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size * 1.5,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(size / 2),
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 3,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class ColorBurstWidget extends StatelessWidget {
  static const tau = math.pi * 2;
  static const scaleFactor = 1 / 25;
  static const size = 600.0;
  static final phi = (math.sqrt(5) + 1) / 2;
  static final rng = math.Random();
  final int colorParticles;
  final AnimationController controller;
  static final List<Color> holiColors = [
    const Color(0xFFE91E63), // Pink
    const Color(0xFF9C27B0), // Purple
    const Color(0xFF3F51B5), // Indigo
    const Color(0xFF2196F3), // Blue
    const Color(0xFF4CAF50), // Green
    const Color(0xFFFFEB3B), // Yellow
    const Color(0xFFFF9800), // Orange
    const Color(0xFFFF5722), // Deep Orange
  ];
  const ColorBurstWidget(this.colorParticles, this.controller, {super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final colorWidgets = <Widget>[];
        for (var i = 0; i < colorParticles; i++) {
          final theta = i * tau / phi;
          final r = math.sqrt(i) * scaleFactor;
          final animValue = (controller.value + i / colorParticles) % 1.0;
          final pulseScale = 0.8 + math.sin(animValue * math.pi * 2) * 0.2;
          colorWidgets.add(
            Align(
              key: ValueKey('color_$i'),
              alignment: Alignment(
                r * math.cos(theta + controller.value * tau / 5),
                r * math.sin(theta + controller.value * tau / 5),
              ),
              child: Transform.scale(
                scale: pulseScale,
                child: ColorDot(
                  holiColors[i % holiColors.length],
                  size: 6.0 + (i % 3) * 2,
                ),
              ),
            ),
          );
        }
        for (var j = 0; j < 30; j++) {
          final angle = tau * j / 30;
          final radius = 0.9;
          final pulseScale =
              0.8 +
              math.sin((controller.value * 2 + j / 30) * math.pi * 2) * 0.2;
          colorWidgets.add(
            Align(
              key: ValueKey('ring_$j'),
              alignment: Alignment(
                radius * math.cos(angle + controller.value * tau / 3),
                radius * math.sin(angle + controller.value * tau / 3),
              ),
              child: Transform.scale(
                scale: pulseScale,
                child: ColorDot(holiColors[j % holiColors.length], size: 10.0),
              ),
            ),
          );
        }
        return FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            height: size,
            width: size,
            child: Stack(children: colorWidgets),
          ),
        );
      },
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final double size;

  const ColorDot(this.color, {required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: color.withValues(alpha: 0.3),
            blurRadius: 5,
            spreadRadius: 1,
          ),
        ],
      ),
    );
  }
}

class HoliMessageWidget extends StatelessWidget {
  const HoliMessageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.withValues(alpha: 0.3),
            blurRadius: 15,
            spreadRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ShimmerText(
            context.tr('today_is_off'),
            baseColor: Colors.pink,
            highlightColor: Colors.blue,
            fontSize: 36,
            fontWeight: FontWeight.bold,
          ),
          const SizedBox(height: 15),
          Text(
            context.tr('have_a_nice_day'),
            textAlign: TextAlign.center,
            style: Styles.style35Bold().copyWith(color: ColorsManager.black),
          ),
          const SizedBox(height: 15),
          Text(
            context.tr('festival_wish'),
            textAlign: TextAlign.center,
            style: Styles.style16Medium().copyWith(color: ColorsManager.black),
          ),
        ],
      ),
    );
  }
}

class ShimmerText extends StatefulWidget {
  final String text;
  final Color baseColor;
  final Color highlightColor;
  final double fontSize;
  final FontWeight fontWeight;

  const ShimmerText(
    this.text, {
    required this.baseColor,
    required this.highlightColor,
    required this.fontSize,
    required this.fontWeight,
    super.key,
  });

  @override
  State<ShimmerText> createState() => _ShimmerTextState();
}

class _ShimmerTextState extends State<ShimmerText>
    with SingleTickerProviderStateMixin {
  late AnimationController _shimmerController;

  @override
  void initState() {
    super.initState();
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shimmerController,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) {
            return LinearGradient(
              colors: [
                widget.baseColor,
                widget.highlightColor,
                widget.baseColor,
              ],
              stops: const [0.0, 0.5, 1.0],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: _SlidingGradientTransform(
                slidePercent: _shimmerController.value,
              ),
            ).createShader(bounds);
          },
          child: Text(
            widget.text,
            style: TextStyle(
              fontSize: widget.fontSize,
              fontWeight: widget.fontWeight,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: widget.baseColor.withValues(alpha: 0.5),
                  offset: const Offset(2.0, 2.0),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SlidingGradientTransform extends GradientTransform {
  final double slidePercent;

  const _SlidingGradientTransform({required this.slidePercent});

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    return Matrix4.translationValues(
      bounds.width * 2 * (slidePercent - 0.5),
      0.0,
      0.0,
    );
  }
}

// class SplashEffect extends StatefulWidget {
//   final Color color;
//   final double size;

//   const SplashEffect({required this.color, required this.size, super.key});

//   @override
//   State<SplashEffect> createState() => _SplashEffectState();
// }

// class _SplashEffectState extends State<SplashEffect>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _sizeAnimation;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(milliseconds: 600),
//       vsync: this,
//     )..forward();

//     _sizeAnimation = Tween<double>(
//       begin: 0.5,
//       end: 2.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

//     _opacityAnimation = Tween<double>(
//       begin: 0.7,
//       end: 0.0,
//     ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

//     _controller.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         if (mounted) {
//           setState(() {});
//         }
//       }
//     });
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _controller,
//       builder: (context, child) {
//         return Opacity(
//           opacity: _opacityAnimation.value,
//           child: Transform.scale(
//             scale: _sizeAnimation.value,
//             child: Container(
//               width: widget.size * 2,
//               height: widget.size,
//               decoration: BoxDecoration(
//                 color: widget.color,
//                 borderRadius: BorderRadius.circular(widget.size),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// extension RandomElement<T> on List<T> {
//   T randomElement() {
//     final random = math.Random();
//     return this[random.nextInt(length)];
//   }
// }
