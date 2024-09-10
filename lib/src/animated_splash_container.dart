import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedSplashContainer extends StatefulWidget {
  const AnimatedSplashContainer(
      {super.key,
      this.color1 = const Color(0xFFDD9AC1),
      this.color2 = const Color.fromARGB(
        255,
        91,
        232,
        235,
      ),
      this.containerType = ContainerType.parallelogram});
  final Color color1;
  final Color? color2;
  final ContainerType containerType;
  @override
  State<AnimatedSplashContainer> createState() =>
      __AnimatedSplashContainerState();
}

class __AnimatedSplashContainerState extends State<AnimatedSplashContainer>
    with SingleTickerProviderStateMixin {
  bool play = false;
  late AnimationController _controller;
  late bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
        vsync: this,
        duration: const Duration(
          milliseconds: 400,
        ));
    _controller.addListener(() {
      setState(() {});
    });

    Future.delayed(const Duration(milliseconds: 200)).then((value) {
      setState(() {
        play = true;
        _controller.forward();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double opacity = _controller.value;

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Scaffold(
          body: Center(
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: _controller.duration!,
                  curve: Curves.easeInOut,
                  height: play ? 200.h : 100.h,
                  bottom: play ? 260.h : 0,
                  left: play ? 140.w : 100.w,
                  child: Opacity(
                      opacity: opacity,
                      child: widget.containerType == ContainerType.parallelogram
                          ? ParallelogramContainer(
                              color: widget.color1,
                            )
                          : CircleContainer(color: widget.color1)),
                ),
                AnimatedPositioned(
                  duration: _controller.duration!,
                  curve: Curves.easeInOut,
                  height: play ? 100.h : 100.h,
                  top: play ? 310.h : 0,
                  right: play ? 130.w : 0,
                  child: Opacity(
                      opacity: opacity,
                      child: widget.containerType == ContainerType.parallelogram
                          ? ParallelogramContainer(
                              color: widget.color2,
                            )
                          : CircleContainer(color: widget.color2)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class ParallelogramContainer extends StatelessWidget {
  const ParallelogramContainer({super.key, required this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Transform(
      transform: Matrix4.skewY(-0.5),
      child: Container(
        width: 40.w,
        color: color,
        alignment: Alignment.center,
      ),
    );
  }
}

class CircleContainer extends StatelessWidget {
  const CircleContainer({super.key, required this.color});
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50.r,
      backgroundColor: color,
    );
  }
}

enum ContainerType { circle, parallelogram }
