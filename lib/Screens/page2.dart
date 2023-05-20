import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

class porposal extends StatelessWidget {
   porposal({Key? key}) : super(key: key);

  final _porposalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.edit_note),
        title: Text('اقترحات'),
        backgroundColor: Colors.blueGrey,
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.all(28),
            child: TextFormField(
              controller: _porposalController,
              textAlign: TextAlign.right,
              maxLines: 15,
              decoration: InputDecoration(
                hintText: 'قم بكتابة مقترحك واسم الهيئة',
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     void _uploadUserData() async {
          //       // final url = await uploadImage();
          //       final uid = FirebaseAuth.instance.currentUser!.uid;
          //
          //       final userName = (await FirebaseFirestore.instance
          //           .collection('Users')
          //           .doc(uid)
          //           .get())['Full Name'] as String;
          //
          //       final NationalID = (await FirebaseFirestore.instance
          //           .collection('Users')
          //           .doc(uid)
          //           .get())['National ID'] as dynamic;
          //
          //       // final Uid = (await FirebaseFirestore.instance
          //       //     .collection('Users')
          //       //     .doc(FirebaseAuth.instance.currentUser!.uid));
          //
          //       // if ( _porposalController != null) {
          //       //   {
          //       //     await FirebaseFirestore.instance.collection('porposal').doc().set(
          //       //       {
          //       //         // 'location':
          //       //         // 'https://www.google.com/maps/@${currentLocation!.latitude},${currentLocation!.longitude},16z',
          //       //         'userName': userName,
          //       //         'porposal_desc': _porposalController.text,
          //       //         // 'problem_img': url,
          //       //         'Nationa ID': NationalID,
          //       //         // 'Uid': Uid,
          //       //       },
          //       //       SetOptions(merge: true),
          //       //     ).then((value) async {
          //       //       await CoolAlert.show(
          //       //           context: context,
          //       //           barrierDismissible: false,
          //       //           type: CoolAlertType.success,
          //       //           onConfirmBtnTap: () {
          //       //             Navigator.pop(context);
          //       //           },
          //       //           onCancelBtnTap: () {
          //       //             Navigator.pop(context);
          //       //           }).then((value) => Navigator.pop(context));
          //       //     });
          //       //   }
          //       //   // isLoading = false;
          //       //   // setState(() {});
          //       // }
          //     }
          //
          //   },
          //   child: Text('ارسال'),
          //   style: ButtonStyle(
          //     backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
          //   ),
          // )
        ],
      ),
    );
  }
}
