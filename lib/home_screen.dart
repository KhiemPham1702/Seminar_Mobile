import 'package:flutter/material.dart';
import 'package:test_plugin/cccd_screen.dart';
import 'package:test_plugin/services/nfc_services.dart';
import 'package:test_plugin/write_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listItem = [
      {
        'text': '(Đặc biệt) Đọc NFC CCCD',
        'icon': Icons.credit_card,
        'onPress': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const CCCDScreen()));
        }
      },
      {
        'text': 'Đọc NFC ',
        'icon': Icons.remove_red_eye_rounded,
        'onPress': () {
          NFCServices.instance.readFromNFC();
        }
      },
      {
        'text': 'Ghi NFC ',
        'icon': Icons.read_more,
        'onPress': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => WriteScreen()));
        }
      }
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Demo NFC'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ...listItem
                .map((e) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: e['onPress'] as Function(),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          elevation: 7,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 20
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  e['text'] as String,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 15,
                                  ),
                                ),
                                Icon(e['icon'] as IconData , color: Colors.black,)
                              ],
                            ),
                          ),
                        ),
                      ),
                    ))
                .toList()
          ],
        ),
      ),
    );
  }
}
