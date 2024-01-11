import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Selection Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> messages = [];

  var reversed = false;

  final controller = TextEditingController();

  @override
  void initState() {
    // Add initial messages with lorem ipsum text.
    for (int i = 0; i < 10; i++) {
      _addMessage();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(widget.title),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Normal'),
                  Switch(
                    value: reversed,
                    onChanged: (value) => setState(() => reversed = value),
                  ),
                  const Text('Reverse'),
                ],
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(child: _buildContentContainer()),
              _buildInputWidget(),
            ],
          ),
        ),
      );

  void _addMessage([String? message]) =>
      messages.add(message ?? lorem(paragraphs: 1, words: 25));

  Widget _buildContentContainer() => SelectionArea(
        child: ListView.builder(
          reverse: reversed,
          itemCount: messages.length,
          itemBuilder: (context, index) => Message(message: messages[index]),
        ),
      );

  Widget _buildInputWidget() => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Message',
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  _addMessage(controller.text);
                  controller.clear();
                },
                icon: const Icon(Icons.send),
              ),
            ],
          ),
        ),
      );
}

class Message extends StatelessWidget {
  const Message({
    super.key,
    required this.message,
  });

  final String message;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      );
}
