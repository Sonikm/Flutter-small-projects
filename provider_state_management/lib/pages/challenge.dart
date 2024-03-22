import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_tutorial/providers/user_provider.dart';

class Challenge extends StatefulWidget {
  const Challenge({super.key});

  @override
  State<Challenge> createState() => _ChallengeState();
}

class _ChallengeState extends State<Challenge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple[200],
        centerTitle: true,
        title: Text("Challenge"),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - 150,
        child: Stack(
          children: [
            Center(
              child: Text(
                "${context.watch<UserProvider>().num}",
                style: TextStyle(fontSize: 30),
              ),
            ),
            Positioned(
              bottom: 70,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  context.read<UserProvider>().increment();
                },
                child: const Text(
                  "+",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 20,
              child: FloatingActionButton(
                onPressed: () {
                  context.read<UserProvider>().decrement();
                },
                child: const Text(
                  "-",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
