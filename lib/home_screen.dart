import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;

  void setDataCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('counter', ++counter);
    getDataCount();

    List<String> names = ['A', 'B', 'C'] + ['D', 'E']; // data getFrom 'names'
    await prefs.setStringList('names', names);
  }

  void getDataCount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataCount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //setDataCount();
          openCamera();
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void openCamera() async {
    await ImagePicker().pickImage(source: ImageSource.camera);
  }
}
