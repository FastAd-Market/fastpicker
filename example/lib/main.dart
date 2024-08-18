import 'package:fastpicker/fast_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FastPicker Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.pink,
          brightness: Brightness.light,
        ),
      ),
      home: const RootWidget(),
    );
  }
}

class RootWidget extends StatelessWidget {
  const RootWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return FastPicker(
                    theme: Theme.of(context),
                    onComplete: (assets) {
                      final text = 'Selected Media count: ${assets.length}\n${assets.map((e) => e.id)}';
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
                    },
                  );
                },
              ),
            );
          },
          child: const Text('Show FastPicker'),
        ),
      ),
    );
  }
}
