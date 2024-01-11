import 'dart:math';
import 'package:flutter/material.dart';

import 'classfullname.dart';
import 'signup.dart';

class SecondPage extends StatelessWidget {
  final String fullname;
  final String generatedPassword;

  const SecondPage({
    Key? key,
    required this.fullname,
    required this.generatedPassword,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 64, 92),
        elevation: 6,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Informations Personnel',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset("assets/images/police.png"),
            ),
            SizedBox(height: 16),
            Text(
              'Pseudo: ${UserUtil.getFullname(fullname)}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              'Generated Password: $generatedPassword',
              style: TextStyle(fontSize: 16),
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Add any other logic you need after confirming

                  //this is what to add while pressing CONFIRM ...
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(1, 64, 92, 1.0),
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Color.fromARGB(255, 1, 64, 92),
        elevation: 6,
      ),
    );
  }
}
