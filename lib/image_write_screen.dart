// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:test_plugin/services/nfc_services.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:test_plugin/utils/dialogs.dart';
// class ImageWriteScreen extends StatelessWidget {
//   ImageWriteScreen({super.key});
//   final controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Ghi NFC'),
//       ),
//       body: BlocProvider(
//   create: (context) => ImageCubit(),
//   child: BlocBuilder<ImageCubit, int>(
//   builder: (context, state) {
//     final cubit = context.read<ImageCubit>();
//     return SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               width: double.infinity,
//               color: Colors.black,
//               height: 60,
//               child: const Row(
//                 children: [
//                   SizedBox(width: 20,),
//                   Icon(Icons.image , color: Colors.white, size: 40,),
//                   SizedBox(width: 20,),
//                   Text('ẢNH' , style: TextStyle(
//                       color: Colors.white
//                   ),)
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20,),
//             const Text('Thêm ảnh của bạn'),
//             const SizedBox(height: 10,),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Column(
//                   children: [
//                     IconButton(onPressed: () async {
//                       final XFile? image = await cubit.picker.pickImage(source: ImageSource.gallery);
//                       if(image != null) {
//                         cubit.updateImage(image);
//                       }
//                     }, iconSize: 50,icon: const Center(child: Icon(Icons.image_sharp,))),
//                     Text('Từ thư viện')
//                   ],
//                 ),
//                 const SizedBox(width: 50,),
//                 Column(
//                   children: [
//                     IconButton(onPressed: () async {
//                       final XFile? image = await cubit.picker.pickImage(source: ImageSource.camera);
//                       if(image != null) {
//                         cubit.updateImage(image);
//                       }
//                     }, iconSize: 50,icon: const Center(child: Icon(Icons.camera,))),
//                     Text('Từ camera')
//                   ],
//                 )
//               ],
//             ),
//             const SizedBox(height: 20,),
//             if(cubit.image != null)
//               Image.file(File(cubit.image!.path ,) ,height: 200, width: 200,),
//             ElevatedButton(
//                 onPressed: () async {
//                   try {
//                     Dialogs.showNFCAction(context , 'Ghi');
//                     NFCServices.instance.writeToNFC(2, '' , context , cubit.imageRaw);
//                   }
//                   catch (e) {
//                     Fluttertoast.showToast(
//                         msg: "Lỗi ghi thẻ",
//                         toastLength: Toast.LENGTH_SHORT,
//                         gravity: ToastGravity.BOTTOM,
//                         timeInSecForIosWeb: 1,
//                         backgroundColor: Colors.red,
//                         textColor: Colors.white,
//                         fontSize: 16.0
//                     );
//                   }
//                 },
//                 child: const Text('Ghi')),
//           ],
//         ),
//       );
//   },
// ),
// ),
//     );
//   }
// }
//
// class ImageCubit extends Cubit<int> {
//   ImageCubit() : super(0);
//   XFile? image;
//   Uint8List? imageRaw;
//   final ImagePicker picker = ImagePicker();
//   updateImage( XFile s)  async {
//     image = s;
//     File imageFile = File(s.path);
//     imageRaw = await imageFile.readAsBytes();
//     emit(state+1);
//   }
// }