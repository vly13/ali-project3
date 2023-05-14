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
      body: Column(
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
          ElevatedButton(
            onPressed: () {},
            child: Text('ارسال'),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blueGrey),
            ),
          )
        ],
      ),
    );
  }
}
