// home.dart

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
//import 'camera.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

import 'addprofil.dart';
import 'profil.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  List<BoxData> boxDataList = [];
  void _openModifyPage(BoxData boxData) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ModifyPage(
          boxData: boxData,
          fullName: boxData.fullName,
          age: boxData.age,
          address: boxData.address,
          type: boxData.type,
        ),
      ),
    );

    if (result != null) {
      setState(() {
        boxData.fullName = result['fullName'];
        boxData.age = result['age'];
        boxData.address = result['address'];
        boxData.type = result['type'];
        boxData.imageBytes = result['imageBytes'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color.fromRGBO(1, 64, 92, 1.0);
    Color boxColor = const Color(0xffD4D4D4);

    return Scaffold(
      appBar: appBar(),
      drawer: createDrawer(),
      bottomNavigationBar: Container(
        height: 67,
        child: BottomNavigationBar(
          backgroundColor: myColor,
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/home-1-svgrepo-com.svg',
                height: 32,
                width: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/camera-svgrepo-com.svg',
                height: 32,
                width: 32,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/images/profile-circle-svgrepo-com.svg',
                width: 32,
                height: 32,
              ),
              label: '',
            ),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black,
                width: 1.0,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _openRechercheeView(context);
                      // Handle click for "Search"
                      // You can replace this with your navigation logic or any other action
                      print('Search clicked');
                    },
                    child: Container(
                      color: boxColor,
                      height: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/search-alt-2-svgrepo-com.svg',
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Searched',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 2.0,
                  color: Colors.black,
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _opendisparuView(context);
                      // Handle click for "Missing"
                      // You can replace this with your navigation logic or any other action
                      print('Missing clicked');
                    },
                    child: Container(
                      color: boxColor,
                      height: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/missing-svgrepo-com.svg',
                              height: 21,
                              width: 21,
                            ),
                            SizedBox(width: 8.0),
                            Text(
                              'Missing',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 20, left: 25, right: 25),
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0xff1D1617).withOpacity(0.11),
                  blurRadius: 40,
                  spreadRadius: 0.0)
            ]),
            child: TextField(
              decoration: InputDecoration(
                  filled: true,
                  fillColor: boxColor,
                  contentPadding: EdgeInsets.all(6),
                  hintText: 'Search a Person',
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(10),
                    child: SvgPicture.asset(
                      'assets/images/search-alt-2-svgrepo-com.svg',
                      width: 10,
                      height: 10,
                    ),
                  ),
                  suffixIcon: Container(
                    width: 100,
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          VerticalDivider(
                            color: Colors.black,
                            indent: 10,
                            endIndent: 10,
                            thickness: 0.1,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(2),
                            child: SvgPicture.asset(
                              'assets/images/filter-ascending-svgrepo-com.svg',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide.none)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10, left: 25, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(width: 8.0),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => AddPage()),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xffD4D4D4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SvgPicture.asset(
                      'assets/images/add-circle-svgrepo-com (1).svg',
                      width: 35,
                      height: 35,
                    ),
                  ),
                ),
              ],
            ),
          ),
          /////////
          /////////
          /////////
          /////////                       //////////////////
          ////////////////////////////////////////////////
          /////////              /////////////
          ///////////         ////////////////////
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          _openHomePage();
          break;
        case 1:
          _openCameraPage();
          break;
        case 2:
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProfilePage()),
          );
          break;

          break;
      }
    });
  }

  void _openHomePage() {
    // Implement navigation to home page
    // You can replace this with your navigation logic
  }

  void _openCameraPage() async {
    final XFile? image = await ImagePicker().pickImage(
      source: ImageSource.camera,
      maxWidth: 800, // Adjust the maximum width if needed
      maxHeight: 600, // Adjust the maximum height if needed
    );

    if (image != null) {
      // Process the captured image as needed
      // You can display the image or save it to Firebase Storage, for example
      print('Image path: ${image.path}');
    }
  }

  // void _openProfilePage() {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(builder: (context) => ProfilePage()),
  //   );
  // }

  void _onDeleteBox(int id) {
    setState(() {
      boxDataList.removeWhere((boxData) => boxData.id == id);
    });
  }

  void _openSettingsPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SettingsPage()),
    );
  }

  Drawer createDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(1, 64, 92, 1.0),
            ),
            child: Text(
              'CHORTA',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Settings'),
            onTap: () {
              _openSettingsPage();
            },
          ),
          ListTile(
              title: Text('Camera'),
              onTap: () {
                _openCameraPage();
              }),
          ListTile(
            title: Text('Profile'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfilePage()),
              );
            },
          )
        ],
      ),
    );
  }

  AppBar appBar() {
    Color myColor = const Color.fromRGBO(1, 64, 92, 1.0);
    return AppBar(
      backgroundColor: myColor,
      elevation: 0.0,
      leading: Builder(
        builder: (context) => GestureDetector(
          onTap: () {
            Scaffold.of(context).openDrawer();
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
      ),
      actions: [
        GestureDetector(
          onTap: () {
            _openSettingsPage();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff01405C),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.all(10),
            alignment: Alignment.center,
            width: 37,
            child: SvgPicture.asset(
              'assets/images/settings-svgrepo-com.svg',
              height: 28,
              width: 28,
            ),
          ),
        ),
      ],
      centerTitle: true,
    );
  }

  void _opendisparuView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // Replace 'your_collection' with the actual name of your Firestore collection
          future: FirebaseFirestore.instance.collection('/disparu').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error fetching data: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No documents found.'));
            } else {
              var documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var document = documents[index].data()!;
                  return Card(
                    child: ListTile(
                      title: Text('FullName: ${document['fullName']}'),
                      subtitle: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.network(
                              '${document['image']}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Age: ${document['age']}'),
                              Text('Adresse: ${document['address']}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteItem2(documents[index].id);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  void _openRechercheeView(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          // Replace 'your_collection' with the actual name of your Firestore collection
          future: FirebaseFirestore.instance.collection('/recherchee').get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(
                  child: Text('Error fetching data: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('No documents found.'));
            } else {
              var documents = snapshot.data!.docs;
              return ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  var document = documents[index].data()!;
                  return Card(
                    child: ListTile(
                      title: Text('FullName: ${document['fullName']}'),
                      subtitle: Row(
                        children: [
                          Container(
                            width: 50,
                            height: 50,
                            margin: EdgeInsets.only(right: 10),
                            child: Image.network(
                              '${document['image']}',
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Age: ${document['age']}'),
                              Text('Adresse: ${document['address']}'),
                            ],
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          _deleteItem(documents[index].id);
                        },
                      ),
                    ),
                  );
                },
              );
            }
          },
        );
      },
    );
  }

  Future<void> _deleteItem(String documentId) async {
    try {
      // Replace 'your_collection' with the actual name of your Firestore collection
      await FirebaseFirestore.instance
          .collection('/recherchee')
          .doc(documentId)
          .delete();
      // Add any additional logic or UI updates after deletion if needed
    } catch (e) {
      print('Error deleting document: $e');
      // Handle errors or show an error message to the user
    }
  }

  Future<void> _deleteItem2(String documentId) async {
    try {
      // Replace 'your_collection' with the actual name of your Firestore collection
      await FirebaseFirestore.instance
          .collection('/disparu')
          .doc(documentId)
          .delete();
      // Add any additional logic or UI updates after deletion if needed
    } catch (e) {
      print('Error deleting document: $e');
      // Handle errors or show an error message to the user
    }
  }
}

ModifyPage(
    {required BoxData boxData,
    required String fullName,
    required String age,
    required String address,
    required String type}) {}

SettingsPage() {}

class BoxData {
  final int id;
  late final String fullName;
  late final String age;
  late final String address;
  late final String type;
  late final Uint8List? imageBytes;

  BoxData({
    required this.id,
    required this.fullName,
    required this.age,
    required this.address,
    required this.type,
    this.imageBytes,
  });
}

class BoxSlider extends StatefulWidget {
  final List<BoxData> boxDataList;
  final Function(int) onDelete;
  final Function(BoxData) onModify; // Add the onModify callback

  const BoxSlider({
    Key? key,
    required this.boxDataList,
    required this.onDelete,
    required this.onModify,
  }) : super(key: key);

  @override
  _BoxSliderState createState() => _BoxSliderState();
}

class _BoxSliderState extends State<BoxSlider> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 440,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: widget.boxDataList.length,
        itemBuilder: (context, index) {
          BoxData boxData = widget.boxDataList[index];

          return Dismissible(
            key: Key(boxData.id.toString()),
            onDismissed: (direction) {
              widget.onDelete(boxData.id);
            },
            background: Container(color: Colors.red),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 4, horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xffD4D4D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: boxData.imageBytes != null
                          ? Image.memory(
                              boxData.imageBytes!,
                              height: 100,
                              width: 80,
                              fit: BoxFit.cover,
                            )
                          : Container(),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xffD4D4D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: EdgeInsets.all(8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            boxData.fullName,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            boxData.address,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                          Text(
                            'Age: ${boxData.age}',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      widget.onModify(boxData); // Pass the boxData to onModify
                    },
                    child: Container(
                      width: 29,
                      height: 100,
                      decoration: BoxDecoration(
                        color: const Color(0xffD4D4D4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/images/pencil-svgrepo-com.svg',
                            height: 22,
                            width: 22,
                            color: Colors.black,
                          ),
                          SizedBox(height: 20),
                          SvgPicture.asset(
                            'assets/images/delete-svgrepo-com.svg',
                            height: 27,
                            width: 25,
                            color: Colors.black,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomePage(),
  ));
}
