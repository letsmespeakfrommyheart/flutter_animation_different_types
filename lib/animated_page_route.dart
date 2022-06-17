import 'package:flutter/material.dart';

class AnimatedPage extends StatelessWidget {
  const AnimatedPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo gallery'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(children: [
            Card(
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/images/01.jpg'),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/images/02.jpg'),
              ),
            ),
            Card(
              child: SizedBox(
                height: 200,
                child: Image.asset('assets/images/03.jpg'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
