import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final bool? like;
  const Button({super.key, this.like = false});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> with TickerProviderStateMixin {
  late AnimationController? sizeAnimationController;
  late AnimationController? colorAnimationController;
  late Animation? changeColor;
  bool _like = false;

  @override
  void initState() {
    sizeAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      value: 1.0,
      upperBound: 1.5,
      lowerBound: 1.0,
    );

    colorAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    changeColor = ColorTween(begin: Colors.grey, end: Colors.red)
        .animate(colorAnimationController!);

    super.initState();
  }

  @override
  void dispose() {
    sizeAnimationController?.dispose();
    colorAnimationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print(_like);

    return Center(
      child: GestureDetector(
        onTap: () {
          sizeAnimationController!.forward().then((value) {
            if (_like) {
              colorAnimationController!.forward();
            } else {
              colorAnimationController!.reverse();
            }
            sizeAnimationController!.reverse();
          });
          setState(() {
            _like = !_like;
          });
        },
        child: Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white,
          ),
          child: ScaleTransition(
            scale: sizeAnimationController!,
            child: AnimatedBuilder(
              animation: colorAnimationController!,
              builder: (context, child) => Icon(
                Icons.favorite,
                color: changeColor!.value,
                size: 30,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
