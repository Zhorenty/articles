import 'package:flutter/material.dart';

import '../widgets/a_container.dart';

class AnimationPage extends StatelessWidget {
  const AnimationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Animation'),
      ),
      body: const Center(
        child: AnimationWidget(),
      ),
    );
  }
}
