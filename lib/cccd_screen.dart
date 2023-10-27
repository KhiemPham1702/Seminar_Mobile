import 'dart:convert';

import 'package:epassportnfc/epassportnfc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_plugin/utils/dialogs.dart';

class CCCDScreen extends StatefulWidget {
  const CCCDScreen({Key? key}) : super(key: key);

  @override
  State<CCCDScreen> createState() => _CCCDScreenState();
}

class _CCCDScreenState extends State<CCCDScreen> {
  String _platformVersion = 'Unknown';
  NFCResponse? datanfc;
  String state = '';
  bool isScanning = false;

  @override
  void initState() {
    super.initState();
    test();
  }

  void test() {
    Epassportnfc.nfcStream.listen((NFCResponse event) {
      print("=================1111111========================");
      print(event);
      datanfc = event;
      state = "Đặt thẻ vào vị trí quét để tiến hành quét";
      setState(() {
        if (event.status == 'READING') {
          isScanning = true;
          state = "Đang đọc thẻ...";
        }
        if (event.status == 'ERROR') {
          isScanning = false;
          state = "Lỗi đọc thẻ";
        }
      });
      if (event.status == 'SUCCESS') {
        isScanning = false;
        state = "Đọc thẻ thành công";
        // showNFCDataDialog(context, datanfc);
        Future.delayed(const Duration(seconds: 1), () {
          // showNFCDataDialog(context, datanfc);
          Dialogs.showCCCD(context, datanfc);
        });
      }
    });
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Epassportnfc.nfc(passportNumberController.text,
              birthDayNumberController.text, expireNumberController.text) ??
          'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });

    debugPrint('=>>>>$_platformVersion');
  }

  TextEditingController passportNumberController = TextEditingController()
    ..text = '051202003951';
  TextEditingController birthDayNumberController = TextEditingController()
    ..text = '020205';
  TextEditingController expireNumberController = TextEditingController()
    ..text = '270205';

  void showWaiting(BuildContext context) {
    var alert = const AlertDialog(
      title: Text("NFC tag reader"),
      content: Text("Hold your Phone near an NFC enabled passport."),
    );

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        });
  }

  void showNFCDataDialog(BuildContext context, NFCResponse? datanfc) {
    setState(() {
      isScanning = false;
      state = "";
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Thông tin từ NFC"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.memory(base64Decode(datanfc?.imageData ?? '')),
              SizedBox(height: 10),
              Text('Họ và tên: ${datanfc?.firstName ?? ''}'),
              Text('Số CCCD: ${datanfc?.personalNumber ?? ''}'),
              Text('Ngày sinh: ${datanfc?.dateOfBirth ?? ''}'),
              Text('Giới tính: ${datanfc?.gender == '1' ? 'Nam' : 'Nữ'}'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog khi nhấn nút
              },
              child: Text('Đóng'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan CCCD NFC'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: passportNumberController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 50),
                  labelText: 'CCCD',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1)),
                ),
              )),
          Padding(
            padding: const EdgeInsets.all(10),
            child: TextFormField(
                controller: birthDayNumberController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 50),
                  labelText: 'Ngày sinh (yy/MM/dd)',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1)),
                )),
          ),
          Padding(
              padding: const EdgeInsets.all(10),
              child: TextFormField(
                controller: expireNumberController,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  constraints: const BoxConstraints(maxHeight: 50),
                  labelText: 'Ngày hết hạn (yy/MM/dd)',
                  labelStyle: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 1)),
                ),
              )),
          ElevatedButton(
              onPressed: () {
                initPlatformState();
              },
              child: const Text('Read NFC')),
          const SizedBox(height: 50),
          Text(state),
          const SizedBox(height: 15),
          if (isScanning)
            const LinearProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
              value: null,
            ),
          if (datanfc?.status == 'SUCCESS' &&
              datanfc != null &&
              datanfc?.imageData != null)
            const Column(
              children: [],
            )
        ],
      ),
    );
  }
}
