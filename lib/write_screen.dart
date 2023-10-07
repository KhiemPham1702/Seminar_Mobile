import 'package:flutter/material.dart';
import 'package:test_plugin/services/nfc_services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:test_plugin/text_write_screen.dart';
import 'package:test_plugin/url_write_screen.dart';
import 'package:test_plugin/utils/dialogs.dart';

import 'cccd_screen.dart';
class WriteScreen extends StatelessWidget {
  WriteScreen({super.key});
  final controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final listItem = [
      {
        'text': 'Text',
        'title': 'Thêm text record',
        'icon': Icons.text_snippet,
        'onPress': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  TextWriteScreen()));
        }
      },
      {
        'text': 'URL',
        'title': 'Thêm Url record',
        'icon': Icons.link,
        'onPress': () {
          Navigator.push(context, MaterialPageRoute(builder: (context) =>  UrlWriteScreen()));
        }
      },
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thêm record'),
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
                        Icon(e['icon'] as IconData , color: Colors.black, size: 40,),
                        const SizedBox(width: 10,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              e['text'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                              ),
                            ),
                            const SizedBox(height: 10,),
                            Text(
                              e['title'] as String,
                              style: const TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Icon(Icons.keyboard_arrow_right_outlined , color: Colors.black,)
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
