import 'package:finalproject/login%20page/login.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: AssetImage('assets/images/profile_image.jpg'),
            ),
            SizedBox(height: 20),
            Text(
              'Nizar Guerrabi',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Age: 21',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Address: 33 , City',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _handleLogout(context);
                // Implement logout or any other action
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleLogout(BuildContext context) {
    // Add your logout logic here
    // For example, clear user authentication, remove tokens, etc.

    // Navigate back to the login page
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
      (Route<dynamic> route) => false, // Pop all routes from the stack
    );
  }
}
