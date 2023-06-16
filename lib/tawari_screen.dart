import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project2/address_model,.dart';
import 'package:project2/location_service.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:android_intent_plus/flag.dart';

class TawariScreen extends StatefulWidget {
  final String title;

  const TawariScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TawariScreen> createState() => _TawariScreenState();
}

class _TawariScreenState extends State<TawariScreen> {
  String image = '';
  final imagepicker = ImagePicker();
  final problemController = TextEditingController();
  bool isLoading = false;
  Position? currentLocation;
  AddressModel emptyLocation =
      const AddressModel(country: '', name: '', postalCode: '');

  Future<void> uploadimage(ImageSource source) async {
    final img = await imagepicker.pickImage(source: source);
    if (img != null) {
      image = img.path;
      print(img.path);
    } else {
      image = '';
    }
  }

  @override
  void initState() {
    Permission.location.request().then((value) {
      if (value.isDenied) {
        Permission.location.request();
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style:
              const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.cyan,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(15),
              child: TextFormField(
                controller: problemController,
                textAlign: TextAlign.right,
                maxLines: 10,
                decoration: InputDecoration(
                    hintText: "كتابة المشكلة",
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20))),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            TextButton.icon(
              onPressed: () async => await uploadimage(ImageSource.camera),
              icon: const Icon(Icons.add_a_photo),
              label: const Text(
                'الكاميرا',
                style: TextStyle(fontSize: 17),
              ),
            ),
            TextButton.icon(
              onPressed: () async {
                if (await Permission
                    .locationWhenInUse.serviceStatus.isEnabled) {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      });
                  currentLocation = await LocationService()
                      .getCurrentLocation()
                      .then((value) {
                    Navigator.pop(context);
                  });
                } else {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text("Can't get gurrent location"),
                        content: const Text(
                            'Please make sure you enable GPS and try again'),
                        actions: <Widget>[
                        ElevatedButton( onPressed: () {
                        final AndroidIntent intent = AndroidIntent(
                            action: 'android.settings.LOCATION_SOURCE_SETTINGS');
                        intent.launch();
                        Navigator.of(context, rootNavigator: true).pop();

                      },child: Text('Ok'),)

                        ],
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.location_on_outlined),
              label: const Text(
                'تحديد موقعي الحالي',
                style: TextStyle(fontSize: 17),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(45)),
              width: MediaQuery.of(context).size.width * 0.5,
              height: 33,
              child: ElevatedButton(
                onPressed: () {
                  CoolAlert.show(
                      barrierDismissible: false,
                      context: context,
                      type: CoolAlertType.loading);
                  if (problemController.text.isNotEmpty) {
                    _uploadUserData();
                  }
                },
                child: const Text(
                  'ارسال البلاغ ',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadImage() async {
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('images/${DateTime.now().millisecondsSinceEpoch}');

    final snanpshot = await storageRef.putFile(File(image));

    if (snanpshot.state == TaskState.running) {
      isLoading = true;
      setState(() {});
      return '';
    } else if (snanpshot.state == TaskState.success) {
      return await storageRef.getDownloadURL();
    }
    return '';
  }

  void _uploadUserData() async {
    final url = await uploadImage();
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final userName = (await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get())['Full Name'] as String;

    final NationalID = (await FirebaseFirestore.instance
        .collection('Users')
        .doc(uid)
        .get())['National ID'] as dynamic;

    final Uid = (await FirebaseFirestore.instance
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid));

    if (userName.isNotEmpty && currentLocation != null) {
      if (url.isNotEmpty) {
        await FirebaseFirestore.instance.collection('requests').doc().set(
          {
            'location':
                'https://www.google.com/maps/@${currentLocation!.latitude},${currentLocation!.longitude},16z',
            'userName': userName,
            'problem_desc': problemController.text,
            'problem_img': url,
            'Nationa ID': NationalID,
            'Uid': Uid,
            'author': widget.title,
          },
          SetOptions(merge: true),
        ).then((value) async {
          await CoolAlert.show(
              context: context,
              barrierDismissible: false,
              type: CoolAlertType.success,
              onConfirmBtnTap: () {
                Navigator.pop(context);
              },
              onCancelBtnTap: () {
                Navigator.pop(context);
              }).then((value) => Navigator.pop(context));
        });
      }

      isLoading = false;
      setState(() {});
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }
}
