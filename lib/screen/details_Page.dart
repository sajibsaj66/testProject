import 'package:flutter/material.dart';
import 'package:flutter_test_project/widgets/custom_text.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Details Page'),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: widget.text,
              textColor: Colors.teal,
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
