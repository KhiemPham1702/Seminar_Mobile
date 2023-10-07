import 'package:flutter/material.dart';
import 'package:test_plugin/services/nfc_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_plugin/utils/dialogs.dart';
class UrlWriteScreen extends StatelessWidget {
  UrlWriteScreen({super.key});
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
                  Icon(Icons.link , color: Colors.white, size: 40,),
                  SizedBox(width: 20,),
                  Text('URL' , style: TextStyle(
                    color: Colors.white
                  ),)
                ],
              ),
            ),
            const SizedBox(height: 20,),
            const Text('Nhập url của bạn'),
            const SizedBox(height: 10,),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'https://'
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () async {
                  try {
                    Dialogs.showNFCAction(context , 'Ghi');
                    NFCServices.instance.writeToNFC(1, controller.text, context);
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
