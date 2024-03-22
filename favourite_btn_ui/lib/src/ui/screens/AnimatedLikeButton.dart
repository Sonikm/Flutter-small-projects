import 'package:flutter/material.dart';

class LikeButton extends StatefulWidget {
  final VoidCallback onTap;
  final bool isLiked;

  const LikeButton({
    Key? key,
    required this.onTap,
    required this.isLiked,
  }) : super(key: key);

  @override
  _LikeButtonState createState() => _LikeButtonState();
}

class _LikeButtonState extends State<LikeButton> with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _colorController;

  late Animation<double> _sizeAnimation;
  late Animation<Color?> _colorAnimation;

  @override
  void initState() {
    super.initState();
    _sizeController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
      value: 1.0,
      upperBound: 1.5,
      lowerBound: 1.0,
    );
    _colorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _sizeAnimation = Tween<double>(
      begin: 1.0,
      end: 1.5,
    ).animate(_sizeController);

    _colorAnimation = ColorTween(
      begin: Colors.grey,
      end: Colors.red,
    ).animate(_colorController);
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onTap();
        _sizeController.forward().then((_) {
          if (widget.isLiked) {
            _colorController.forward();
          } else {
            _colorController.reverse();
          }
          _sizeController.reverse();
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
          scale: _sizeAnimation,
          child: AnimatedBuilder(
            animation: _colorController,
            builder: (context, child) => Icon(
              Icons.favorite,
              color: _colorAnimation.value,
              size: 24,
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({Key? key}) : super(key: key);

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with TickerProviderStateMixin {
  bool _isLiked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text("Animated Icon"),
      ),
      drawer: const Drawer(),
      body: Center(
        child: LikeButton(
          isLiked: _isLiked,
          onTap: () {
            setState(() {
              _isLiked = !_isLiked;
            });
          },
        ),
      ),
    );
  }
}


/**
 
import 'package:flutter/material.dart';

class AnimatedLikeButton extends StatefulWidget {
  const AnimatedLikeButton({Key? key}) : super(key: key);

  @override
  State<AnimatedLikeButton> createState() => _AnimatedLikeButtonState();
}

class _AnimatedLikeButtonState extends State<AnimatedLikeButton>
    with TickerProviderStateMixin {
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

    return Scaffold(
      backgroundColor: Colors.purple[200],
      appBar: AppBar(
        title: Text(
          "Animated Icon",
        ),
      ),
      drawer: const Drawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
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
          )
        ],
      ),
    );
  }
}




 */