import 'dart:convert';

import 'package:epassportnfc/epassportnfc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      print(event.status);
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
          showNFCDataDialog(context, datanfc);
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
  }

  TextEditingController passportNumberController = TextEditingController()
    ..text = '';
  TextEditingController birthDayNumberController = TextEditingController()
    ..text = '';
  TextEditingController expireNumberController = TextEditingController()
    ..text = '';

  void showWaiting(BuildContext context) {
    var alert = AlertDialog(
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
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 180),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: passportNumberController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CCCD',
                    hintText: 'CCCD'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: TextField(
                controller: birthDayNumberController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ngày sinh (yy/MM/dd)',
                    hintText: 'Ngày sinh'),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: expireNumberController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Ngày hết hạn (yy/MM/dd)',
                    hintText: 'Ngày hết hạn'),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  initPlatformState();
                },
                child: Text('Read NFC')),

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
      ),
    );
  }
}

