//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_core/firebase_core.dart';
// ignore_for_file: duplicate_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'signuppage/classfullname.dart';
import 'firebase_options.dart';
import 'signuppage/page2-NOM ET mdp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
//   // that it has a State object (defined below) that contains fields that affect
//   // how it looks.

//   // This class is the configuration for the state. It holds the values (in this
//   // case the title) provided by the parent (in this case the App widget) and
//   // used by the build method of the State. Fields in a Widget subclass are
//   // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController fullnameController = TextEditingController();
  TextEditingController cinController = TextEditingController();
  TextEditingController badgeController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  String getFullname() {
    return UserUtil.getFullname(badgeController.text);
  }

  @override
  Widget build(BuildContext context) {
    const IconData login = IconData(0xe3b2, fontFamily: 'MaterialIcons');

    Color textFieldColor = Color.fromARGB(255, 231, 231, 231);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 1, 64, 92),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100 * 0.7, // La largeur initiale multipliée par 0.8
              height: 100 * 0.7, // La hauteur initiale multipliée par 0.8
              child:
                  Image.network('C:/Users/nguer/OneDrive/Images/policeM.svg'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign In",
                  style: TextStyle(fontSize: 22),
                ),
                Icon(
                  login, // Using the custom login icon
                  size: 30,
                ),
                SizedBox(width: 35),
              ], // <-- Remove the extra parenthesis here
            ),
            SizedBox(height: 20),
            MyTextFieldContainer(
              title: 'Fullname',
              hintText: 'Enter your fullname',
              icon: Icons.person,
              controller: fullnameController,
            ),
            SizedBox(height: 20),
            MyTextFieldContainer(
              title: 'CIN',
              hintText: 'Enter your CIN',
              icon: Icons.credit_card,
              controller: cinController,
            ),
            SizedBox(height: 20),
            MyTextFieldContainer(
              title: 'Badge Number',
              hintText: 'Enter your badge number',
              icon: Icons.badge,
              controller: badgeController,
            ),
            SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  // Get input values
                  String fullname = fullnameController.text;
                  String cin = cinController.text;
                  String badge = badgeController.text;

                  print('Fullname:$fullname');
                  print('CIN: $cin');
                  print('Badge: $badge');

                  try {
                    UserCredential userCredential =
                        await _auth.signInWithEmailAndPassword(
                      email:
                          'test@gmail.com', // Remplacez par l'e-mail de l'utilisateur
                      password:
                          'password123', // Remplacez par le mot de passe de l'utilisateur
                    );

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SecondPage(
                          fullname: getFullname(),
                          generatedPassword: '',
                        ),
                      ),
                    );
                  } catch (e) {
                    // Gérez les erreurs d'authentification (affichez un message d'erreur, par exemple).
                    print('Erreur de connexion: $e');
                  }
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(1, 64, 92, 1.0),
                ),
                child: Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class MyTextFieldContainer extends StatelessWidget {
  final String title;
  final String hintText;
  final IconData icon;
  final TextEditingController? controller;

  const MyTextFieldContainer({
    Key? key,
    required this.title,
    required this.hintText,
    required this.icon,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(1, 64, 92, 1.0);
    Color containerColor = Colors.grey[300] ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: myColor,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 8),
        Container(
          width: 300,
          height: 60,
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(25),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  icon: Icon(icon, color: myColor),
                  hintText: hintText,
                  border: InputBorder.none,
                ),
                controller: controller,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
