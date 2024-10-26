import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import 'package:watch_flow/logic/cubit/updata_app_cubit.dart';
import 'package:watch_flow/logic/cubit/update_home_cubit.dart';
import 'package:watch_flow/logic/shared_preferences.dart';
import 'package:watch_flow/view/screens/intail/home.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  bool isIntialized = await SharePrefrenceClass()
      .getVlue(key: "isInitialized", defaultValue: false);
  String languageCode =
      await SharePrefrenceClass().getVlue(key: 'language', defaultValue: 'en');
  bool isDarkMode = await SharePrefrenceClass()
      .getVlue(key: 'themeMode', defaultValue: false);
  runApp(MyApp(
      isIntialized: isIntialized,
      languageCode: languageCode,
      isDarkMode: isDarkMode));
}

class MyApp extends StatelessWidget {
  MyApp(
      {super.key,
      required this.isIntialized,
      required this.languageCode,
      required this.isDarkMode});
  final bool isIntialized;
   String languageCode;
   bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => UpdateHomeCubit(),
        ),
        BlocProvider(
          create: (context) => UpdataAppCubit(),
        ),
      ],
      child: BlocBuilder<UpdataAppCubit, UpdataAppState>(
        builder: (context, state) {
          if ( state is UpdataAppInitial)  {
            languageCode = BlocProvider.of<UpdataAppCubit>(context).languageCode;
            isDarkMode = BlocProvider.of<UpdataAppCubit>(context).isDarkMode;
             return GetMaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Locale(languageCode),
            title: 'YT to Todo',
            theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: Home(isIntialized: isIntialized),
          );
          }else{ return GetMaterialApp(
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            debugShowCheckedModeBanner: false,
            locale: Locale(languageCode),
            title: 'YT to Todo',
            theme: isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: Home(isIntialized: isIntialized),
          );}
        },
      ),
    );
  }
}

class FeaturesScreen extends StatelessWidget {
  const FeaturesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "الميزات الرئيسية",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Image.asset("assets/images/feture.png"),
              const SizedBox(height: 20),
              const Column(
                children: [
                  Text("• الحصول على روابط من يوتيوب."),
                  Text("• إضافة ملاحظات لكل فيديو."),
                  Text("• تصنيف مقاطع الفيديو."),
                ],
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  // Navigate to the next screen within the PageView
                  final pageController = PageController();
                  pageController.animateToPage(
                    2,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
