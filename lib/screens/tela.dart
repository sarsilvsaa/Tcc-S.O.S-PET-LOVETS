import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: OrientationLayout(),
    );
  }
}

class OrientationLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return PortraitScreen(); // Widget para orientação retrato
        } else {
          return LandscapeScreen(); // Widget para orientação paisagem
        }
      },
    );
  }
}

class PortraitScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Portrait Screen'),
      ),
      body: Center(
        child: Text('This is the portrait layout'),
      ),
    );
  }
}

class LandscapeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Landscape Screen'),
      ),
      body: Center(
        child: Text('This is the landscape layout'),
      ),
    );
  }
}
