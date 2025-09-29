import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Практика №4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyCounterState();
}

class _MyCounterState extends State<MyHomePage> {
  int counter = 0;

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void restartCounter() {
    setState(() {
      counter = 0;
    });
  }

  void longCounter() {
    setState(() {
      counter += 10;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Текст счетчика без рамок
            Text(
              "Значение счётчика: $counter",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 30.0),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                color: const Color.fromARGB(255, 132, 223, 135),
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: incrementCounter,
                  onLongPress: longCounter,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[500],
                    foregroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Увеличить",
                    style: TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10.0),
            Container(
              color: const Color.fromARGB(255, 229, 102, 102),
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: restartCounter,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                child: const Text("Сбросить", style: TextStyle(fontSize: 18.0)),
              ),
            ),
            const SizedBox(height: 30.0),
          ],
        ),
      ),
    );
  }
}
