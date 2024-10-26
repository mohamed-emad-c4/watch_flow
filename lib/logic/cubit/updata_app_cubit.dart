import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../shared_preferences.dart';

part 'updata_app_state.dart ';


class UpdataAppCubit extends Cubit<UpdataAppState> {
  late String languageCode ;
late bool isDarkMode;
  UpdataAppCubit() : super(UpdataAppInitial());

  Future<void> updataApp() async {
     languageCode = await SharePrefrenceClass()
        .getVlue(key: 'language', defaultValue: 'en');
     isDarkMode = await SharePrefrenceClass()
        .getVlue(key: 'themeMode', defaultValue: false);
    emit(UpdataApp());
  }
}
