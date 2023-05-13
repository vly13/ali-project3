import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:geolocator/geolocator.dart';

class TawariScreen extends StatefulWidget {
  final String title;

  const TawariScreen({Key? key, required this.title}) : super(key: key);

  @override
  State<TawariScreen> createState() => _TawariScreenState();
}

class _TawariScreenState extends State<TawariScreen> {
  File? image;
  final imagepicker = ImagePicker();

  uploadimage() async {
    var Pickerimage = await imagepicker.getImage(source: ImageSource.camera);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.cyan,
          ),
        ),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(15),
            child: TextFormField(
              textAlign: TextAlign.right,
              maxLines: 15,
              decoration: InputDecoration(
                  hintText: "كتابة المشكلة",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          SizedBox(
            height: 12,
          ),
          TextButton.icon(
              onPressed: uploadimage,
              icon: Icon(Icons.add_a_photo),
              label: Text('الكاميرا')),
          SizedBox(
            height: 12,
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: ElevatedButton(
              onPressed: () async {
                final position = await _determinePosition();
                position.latitude;
                position.longitude;
              },
              child: Text('Send My Location'),
              style: ElevatedButton.styleFrom(
                primary: Color(0xFF00B8D4),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}
