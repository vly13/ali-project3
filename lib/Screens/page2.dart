import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';

class porposal extends StatelessWidget {
  porposal({Key? key}) : super(key: key);

  final _porposalController = TextEditingController();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.edit_note),
          title: Text('اقترحات'),
          backgroundColor: Colors.blueGrey,
        ),
        body: Form(
          key: _formkey,
          child: ListView(
            children: [
              Container(
                margin: EdgeInsets.all(28),
                child: TextFormField(
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return "";
                    }
                    return null;
                  },
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
              SizedBox(height: 12),
              Container(
                height: 33,
                width: MediaQuery.of(context).size.width * 0.5,
                child: ElevatedButton(
                  onPressed: () async {
                    if (_formkey.currentState!.validate()) {
                      final uid = FirebaseAuth.instance.currentUser!.uid;
                      FirebaseFirestore.instance
                          .collection("porposal")
                          .doc()
                          .set({
                        "porposal": _porposalController,
                        "userName": (await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(uid)
                            .get())['Full Name'] as String,
                        "National ID": (await FirebaseFirestore.instance
                            .collection('Users')
                            .doc(uid)
                            .get())['National ID'] as dynamic
                      });
                    }
                  },
                  child: Text(
                    ' ارسال الأقتراح',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
