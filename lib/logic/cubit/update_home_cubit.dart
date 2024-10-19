
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'update_home_state.dart';
class UpdateHomeCubit extends Cubit<UpdateHomeState> {
  UpdateHomeCubit() : super(UpdateHomeInitial());

  Future<void> updateHome() async {
    try {
      emit(UpdateHomeLoading());
      
      // Fetch the updated playlists from your database
      await Future.delayed(const Duration(seconds: 1)); // Simulate a network/db call
      
      // After fetching data, emit UpdateHomeLoaded
      emit(UpdateHomeLoaded());
    } catch (e) {
      emit(UpdateHomeError());
    }
  }
}
