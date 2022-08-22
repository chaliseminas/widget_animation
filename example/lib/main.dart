import 'package:flutter/material.dart';
import 'package:widget_animation/widget_animation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Widget Animation Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final TextStyle style = const TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SingleWidgetAnimation(
              child: Text(
                'Show up Animation',
                key: const Key("Show up Animation"),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              delayStart: const Duration(seconds: 1),
              child: Text(
                'Show up Animation with delay',
                key: const Key("Show up Animation with delay"),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              delayStart: const Duration(seconds: 2),
              direction: Direction.horizontal,
              child: Text(
                'Direction horizontal',
                key: const Key("Direction horizontal"),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              offset: 5,
              delayStart: const Duration(seconds: 3),
              child: Text(
                'Large offset',
                key: const Key('Large offset'),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              offset: 5,
              delayStart: const Duration(seconds: 4),
              direction: Direction.horizontal,
              child: Text(
                'Large horizontal offset',
                key: const Key('Large horizontal offset'),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              delayStart: const Duration(seconds: 5),
              curve: Curves.bounceIn,
              direction: Direction.horizontal,
              offset: -0.2,
              child: Text(
                'Curve bounceIn',
                key: const Key('Curve bounceIn'),
                style: style,
              ),
            ),
            const SizedBox(height: 10),
            SingleWidgetAnimation(
              animationDuration: const Duration(seconds: 2),
              delayStart: const Duration(seconds: 6),
              child: Text(
                'Slow Motion',
                key: const Key('Slow motion'),
                style: style,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
