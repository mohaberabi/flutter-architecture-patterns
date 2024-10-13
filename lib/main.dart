import 'package:flutter/material.dart';
import 'package:flutter_architecture_patterns_manual/hybird/mvvm/view/counter_view.dart';
import 'package:flutter_architecture_patterns_manual/plain/mvvm/view/quote_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                color: Colors.blue,
                child: const Text("Plain viewmodel"),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const QuoteViewRoot())),
              ),
              MaterialButton(
                color: Colors.blue,
                child: const Text("counter viewmodel"),
                onPressed: () => Navigator.of(context).push(
                    MaterialPageRoute(builder: (_) => const CounterViewRoot())),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
