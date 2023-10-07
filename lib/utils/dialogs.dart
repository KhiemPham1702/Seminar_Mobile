import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_plugin/blocs/loading_cubit.dart';

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
                        ? Image.asset('assets/icons/ic_nfc.png' , height: 100)
                        : state == 1
                        ? Image.asset('assets/icons/ic_check.png' , height: 100,)
                        : Image.asset('assets/icons/ic_time.png', height: 100, color: Colors.red,),
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
}
