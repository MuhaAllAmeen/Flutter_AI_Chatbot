import 'package:flutter/material.dart';
import 'package:recipe_ai/views/chat_AI.dart';
import 'package:recipe_ai/views/image_AI.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final PageController pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      children: const [
        ChatAI(),
        ImageAI()
      ],
    );
  }
}
