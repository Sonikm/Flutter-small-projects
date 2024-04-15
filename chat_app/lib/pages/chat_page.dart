import 'dart:convert';

import 'package:chat_app/consts.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final ChatUser _currentUser =
      ChatUser(id: '1', firstName: "Soni", lastName: "Kumari");

  final ChatUser _chatBot =
      ChatUser(id: '2', firstName: "Chat", lastName: "Bot");

  final ourUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent?key=${API_KEY}';

  final header = {'Content-Type': 'application/json'};

  List<ChatMessage> _messages = [];
  List<ChatUser> typing = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(0, 166, 126, 1),
        title: const Text(
          "Chat Bot",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        typingUsers: typing,
        currentUser: _currentUser,
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
        messageOptions: const MessageOptions(
          showCurrentUserAvatar: true,
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromARGB(255, 93, 130, 231),
          textColor: Colors.white,
        ),
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    typing.add(_chatBot);
    setState(() {
      _messages.insert(0, m);
    });

    var data = {
      "contents": [
        {
          "parts": [
            {"text": m.text}
          ]
        }
      ]
    };

    await http
        .post(Uri.parse(ourUrl), headers: header, body: jsonEncode(data))
        .then((value) {
      if (value.statusCode == 200) {
        var result = jsonDecode(value.body);
        // print();
        ChatMessage m1 = ChatMessage(
          user: _chatBot,
          createdAt: DateTime.now(),
          text: result['candidates'][0]['content']['parts'][0]['text'],
        );

        _messages.insert(0, m1);
        setState(() {});
      } else {
        print("Error occured");
      }
    }).catchError((e) {});
    typing.remove(_chatBot);
    setState(() {});
  }
}
