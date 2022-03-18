import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2050),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: MaterialButton(
          onPressed: () {
            _showDatePicker();
          },
          // ignore: prefer_const_constructors
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            // ignore: prefer_const_constructors
            child: Text('Choose Date'),
          ),
          color: Colors.blue,
        ),
      ),
    );
  }
}
