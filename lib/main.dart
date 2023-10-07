import 'dart:async';
import 'dart:convert';

import 'package:epassportnfc/epassportnfc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_nfc_kit/flutter_nfc_kit.dart';
import 'package:ndef/ndef.dart' as ndef;
import 'package:test_plugin/blocs/loading_cubit.dart';
import 'package:test_plugin/home_screen.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(
    BlocProvider(
      create: (context) => LoadingCubit(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    ),
  );
}

