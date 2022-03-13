import 'package:flutter/material.dart';
import 'package:login_reg_project/shared/custom_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('This is Home Page'),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: const Center(
        child: CustomText(
          text: 'This is Home Page',
          fontSize: 40,
          fontWeight: FontWeight.w600,
          color: Colors.teal,
        ),
      ),
    );
  }
}
