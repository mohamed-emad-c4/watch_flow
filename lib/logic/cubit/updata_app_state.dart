import 'package:meta/meta.dart';
@immutable
sealed class UpdataAppState {}

final class UpdataAppInitial extends UpdataAppState {}
final class UpdataApp extends UpdataAppState {}

