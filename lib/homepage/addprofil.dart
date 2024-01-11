//addpage.dart
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Color appBarColor = const Color.fromRGBO(1, 64, 92, 1.0);
  Color myColor = const Color.fromRGBO(212, 212, 212, 1.0);
  Uint8List? _pickedImageBytes;
  final ImagePicker _picker = ImagePicker();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _addressController = TextEditingController();
  TextEditingController _selectedTypeController = TextEditingController();
  String _selectedType = 'Searched'; // Default value

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 40, left: 20, right: 20),
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.11),
                    blurRadius: 40,
                    spreadRadius: 0.0,
                  ),
                ],
              ),
              child: TextField(
                decoration: InputDecoration(
                    filled: true,
                    fillColor: myColor,
                    hintText: "Add a Person",
                    contentPadding: EdgeInsets.all(9),
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SvgPicture.asset(
                          'assets/images/add-circle-svgrepo-com (1).svg'),
                    ),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none)),
              ),
            ),
            SizedBox(height: 50),
            buildInputField("Full Name :", _fullNameController),
            buildInputField("Age           :", _ageController),
            buildInputField("Address    :", _addressController),
            buildInputField("Type :", _selectedTypeController),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(left: 20),
                  child: Text(
                    "Import Image",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: ElevatedButton(
                      onPressed: _pickImage,
                      child: Text("Pick Image"),
                      style: ElevatedButton.styleFrom(
                        primary: appBarColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_pickedImageBytes != null)
              Image.memory(
                _pickedImageBytes!,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, bottom: 20),
              child: ElevatedButton(
                onPressed: () {
                  // Handle Confirm button press
                  _navigateBackWithData();
                },
                style: ElevatedButton.styleFrom(
                  primary: appBarColor,
                ),
                child: Text(
                  "Confirm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInputField(String labelText, TextEditingController controller,
      [String? iconPath]) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.11),
            blurRadius: 40,
            spreadRadius: 0.0,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              labelText,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: labelText == "Type :"
                  ? DropdownButton<String>(
                      value: _selectedType,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedType = newValue!;
                        });
                      },
                      items: <String>['Searched', 'Missing']
                          .map<DropdownMenuItem<String>>(
                        (String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                      ).toList(),
                    )
                  : TextField(
                      controller: controller,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: myColor,
                          contentPadding: EdgeInsets.all(9),
                          prefixIcon: iconPath != null
                              ? Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SvgPicture.asset(iconPath),
                                )
                              : null,
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none)),
                    ),
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget appBar() {
    return PreferredSize(
      preferredSize: Size.fromHeight(60.0),
      child: AppBar(
        backgroundColor: appBarColor,
        elevation: 0.0,
        leading: GestureDetector(
          onTap: () {
            // Handle the lines button tap
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff01405C),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/images/lines-svgrepo-com.svg',
              height: 28,
              width: 28,
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff01405C),
                borderRadius: BorderRadius.circular(10),
              ),
              margin: const EdgeInsets.all(10),
              alignment: Alignment.center,
              width: 37,
            ),
          ),
        ],
        centerTitle: true,
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final pickedBytes = await pickedFile.readAsBytes();
      setState(() {
        _pickedImageBytes = pickedBytes;
      });
    }
  }

  // void _navigateBackWithData() {
  //   Navigator.pop(context, {
  //     'fullName': _fullNameController.text,
  //     'age': _ageController.text,
  //     'address': _addressController.text,
  //     'type': _selectedType,
  //     'imageBytes': _pickedImageBytes,
  //   });
  // }

  void _navigateBackWithData() async {
    String collectionName =
        _selectedType == 'Searched' ? 'recherchee' : 'disparu';

    // Get a reference to the Firestore collection
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection(collectionName);

    // Prepare data to be added to Firestore
    Map<String, dynamic> data = {
      'fullName': _fullNameController.text,
      'age': _ageController.text,
      'address': _addressController.text,
      'type': _selectedType,
      // Add other fields as needed
    };

    // Check if an image is selected
    if (_pickedImageBytes != null) {
      // Upload image to Firebase Storage
      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('images/${DateTime.now().millisecondsSinceEpoch}.jpg');

      UploadTask uploadTask = storageReference.putData(_pickedImageBytes!);
      TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() {});

      // Get the image URL
      String imageUrl = await taskSnapshot.ref.getDownloadURL();

      data['image'] = imageUrl;
    }

    // Add the data to Firestore
    await collectionReference.add(data);

    // Navigate back
    Navigator.pop(context);
  }
}
