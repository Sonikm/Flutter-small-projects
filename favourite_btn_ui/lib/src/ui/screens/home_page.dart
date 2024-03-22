import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  bool _like = false;
  bool _loading = false;

  void _handleLikeButtonPressed() {
    setState(() {
      _like = !_like;
      _loading = true;
      Future.delayed(Duration(seconds: 2), () {
        setState(() {
          _loading = false; // Hide the loading after 2s
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300],
      appBar: AppBar(
        centerTitle: true,
        title: Text("Home Page"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: _handleLikeButtonPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                  color: Colors.white,
                ),
              ),
              _loading
                  ? const SizedBox(
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        color: Colors.red,
                      ),
                    )
                  : Icon(
                      _like ? Icons.favorite : Icons.favorite_border,
                      size: 30,
                      color: _like ? Colors.red : null,
                    )
            ],
          ),
        ),
      ),
    );
  }
}
