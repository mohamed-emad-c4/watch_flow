import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:watch_flow/logic/cubit/updata_app_cubit.dart';
import 'package:watch_flow/logic/cubit/update_home_cubit.dart';
import 'package:watch_flow/logic/globalVaribul.dart';
import 'package:watch_flow/logic/shared_preferences.dart';

import 'generated/l10n.dart';
import 'logic/cubit/updata_app_state.dart';
import 'view/screens/intail/home.dart';

void main() async {
    if (!kIsWeb && (Platform.isWindows || Platform.isLinux || Platform.isMacOS)) {
    // Initialize sqflite_common_ffi for desktop platforms
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }

  WidgetsFlutterBinding.ensureInitialized();

  final sharedPref = SharePrefrenceClass();
  bool isInitialized =
      await sharedPref.getVlue(key: "isInitialized", defaultValue: false);
 
  languageCode = await sharedPref.getVlue(
      key: 'language', defaultValue: 'en'); // Default value
  isDarkMode = await sharedPref.getVlue(key: 'themeMode', defaultValue: false);
  runApp(MyApp(
    isInitialized: isInitialized,
  ));
}

class MyApp extends StatelessWidget {
  final bool isInitialized;

  const MyApp({
    super.key,
    required this.isInitialized,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => UpdateHomeCubit()),
        BlocProvider(create: (context) => UpdataAppCubit()),
      ],
      child: BlocBuilder<UpdataAppCubit, UpdataAppState>(
        builder: (context, state) {
          if (state is UpdataAppInitial) {
            return const matrial();
          } else {
            return const matrial();
          }
        },
      ),
    );
  }
}

class matrial extends StatelessWidget {
  const matrial({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
      locale: Locale(languageCode),
      title: 'Watch Flow',
      localizationsDelegates: const [
        S.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      home: const Home(),
    );
  }
}
