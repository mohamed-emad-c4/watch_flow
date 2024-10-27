import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_flow/logic/globalVaribul.dart';
import '../shared_preferences.dart';
import 'updata_app_state.dart';

class UpdataAppCubit extends Cubit<UpdataAppState> {
  // Default value

  UpdataAppCubit() : super(UpdataAppInitial()) {
    _initializeSettings();
  }

  Future<void> updateTheme(bool isDark) async {
    _initializeSettings();
    final prefs = SharePrefrenceClass();
    await prefs.saveValuebool(key: 'themeMode', value: isDark);
    isDarkMode = isDark;
    emit(UpdataApp()); // Emit a state if needed
  }

  Future<void> updateLanguage(String newLanguage) async {
    final prefs = SharePrefrenceClass();
    await prefs.saveValueString(key: 'language', value: newLanguage);
    languageCode = newLanguage;
    emit(UpdataApp()); // إعادة بناء التطبيق بعد تحديث اللغة
  }

  Future<void> _initializeSettings() async {
    final prefs = SharePrefrenceClass();
    languageCode = await prefs.getVlue(key: 'language', defaultValue: 'en');
    isDarkMode = await prefs.getVlue(key: 'themeMode', defaultValue: false);

    emit(UpdataApp()); // Emit a state if needed
  }

  Future<void> updateApp() async {
    emit(UpdataApp());
  }
}
