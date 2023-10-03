import 'package:flutter/material.dart';
import 'package:test_plugin/services/nfc_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
class WriteScreen extends StatelessWidget {
  WriteScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi NFC'),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.8,
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
                        NFCServices.instance.writeToNFC(controller.text);
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
      ),
    );
  }
}
