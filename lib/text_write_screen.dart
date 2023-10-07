import 'package:flutter/material.dart';
import 'package:test_plugin/services/nfc_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_plugin/utils/dialogs.dart';
class TextWriteScreen extends StatelessWidget {
  TextWriteScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi NFC'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: double.infinity,
              color: Colors.black,
              height: 60,
              child: const Row(
                children: [
                  SizedBox(width: 20,),
                  Icon(Icons.text_snippet , color: Colors.white, size: 40,),
                  SizedBox(width: 20,),
                  Text('Text' , style: TextStyle(
                      color: Colors.white
                  ),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Nhập text của bạn'),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: 150,
              child: TextField(

                controller: controller,

                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Hello!!!',

                ),
                maxLines: null,
                expands: true,

                keyboardType: TextInputType.multiline,
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  try {
                    Dialogs.showNFCAction(context , 'Ghi');
                    NFCServices.instance.writeToNFC( 0, controller.text, context);
                  }
                  catch (e) {
                    Fluttertoast.showToast(
                        msg: "Lỗi ghi thẻ",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }
                },
                child: const Text('Ghi')),
          ],
        ),
      ),
    );
  }
}
