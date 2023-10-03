import 'package:flutter/material.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ndef/ndef.dart' as ndef;

class NFCServices {
  NFCServices._privateConstructor();

  static final NFCServices _instance = NFCServices._privateConstructor();

  static NFCServices get instance => _instance;

  void readFromNFC() async {

    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      return;
    }
    var tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 5),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");
    if (tag.ndefAvailable!) {
      for (var record in await FlutterNfcKit.readNDEFRecords(cached: false)) {
        if (record is ndef.UriRecord) {
          debugPrint('+>>>>>>>>${record.content}');
          final Uri _url = Uri.parse('${record.content?.substring(1)}');
          await launchUrl(_url);
        }
      }
    }
  }

  void writeToNFC(String url) async {
    var availability = await FlutterNfcKit.nfcAvailability;
    if (availability != NFCAvailability.available) {
      return;
    }
    var tag = await FlutterNfcKit.poll(
        timeout: const Duration(seconds: 5),
        iosMultipleTagMessage: "Multiple tags found!",
        iosAlertMessage: "Scan your tag");
    if (tag.ndefAvailable!) {
      if (tag.ndefWritable!) {
        await FlutterNfcKit.writeNDEFRecords([
          ndef.UriRecord.fromString('0'+ url)
        ]);
        Fluttertoast.showToast(msg: 'Ghi thành công');
      }
    }
    await FlutterNfcKit.finish();
  }
}
