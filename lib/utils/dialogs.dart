import 'dart:convert';

import 'package:epassportnfc/epassportnfc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_plugin/blocs/loading_cubit.dart';
import 'package:test_plugin/input_view.dart';

class Dialogs {
  static void showNFCAction(BuildContext context, String type) {
    final cubit = context.read<LoadingCubit>();
    cubit.update(0);
    showModalBottomSheet(
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
        context: context,
        builder: (context) {
          return BlocConsumer<LoadingCubit, int>(
            bloc: cubit,
            builder: (context, state) {
              return SizedBox(
                height: MediaQuery.of(context).size.height * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    state == 0
                        ? Image.asset('assets/icons/ic_nfc.png', height: 100)
                        : state == 1
                            ? Image.asset(
                                'assets/icons/ic_check.png',
                                height: 100,
                              )
                            : Image.asset(
                                'assets/icons/ic_time.png',
                                height: 100,
                                color: Colors.red,
                              ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      state == 0
                          ? 'Đặt thẻ của bạn vào ...'
                          : state == 1
                              ? '$type thành công!!!'
                              : 'Hết thời gian đọc thẻ',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              );
            },
            listener: (BuildContext context, int state) async {
              if (state == 1 || state == 2) {
                await Future.delayed(const Duration(seconds: 1));
                Navigator.pop(context);
              }
            },
          );
        });
  }

  static void showCCCD(BuildContext context, NFCResponse? dataNfc) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        var size = MediaQuery.of(context).size;
        return Container(
          height: size.height * 0.8,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(50)),
                child: const Center(
                  child: Text(
                    'Thông tin cá nhân',
                    style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.w800,
                        fontSize: 16),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Image.memory(
                base64Decode(dataNfc!.imageData ?? ''),
                height: 120,
              ),
              const SizedBox(
                height: 10,
              ),
              InputView(
                  text: '${dataNfc.firstName} ${dataNfc.lastName}' ?? '',
                  title: 'Họ và tên'),
              InputView(
                text: '${dataNfc.personalNumber?.substring(0, 8)}****' ?? '',
                title: 'CCCD',
              ),
              InputView(
                text: dataNfc.dateOfBirth ?? '',
                title: 'Ngày sinh',
              ),
              InputView(
                text: dataNfc.gender == '1' ? 'Nam' : 'Nữ',
                title: "Giới tính",
              ),
              InputView(
                text: dataNfc.nationality ?? '',
                title: 'Quốc tịch',
              ),
            ],
          ),
          // actions: [
          //   TextButton(
          //     onPressed: () {
          //       Navigator.of(context).pop(); // Đóng dialog khi nhấn nút
          //     },
          //     child: Text('Đóng'),
          //   ),
          // ],
        );
      },
    );
  }
}
