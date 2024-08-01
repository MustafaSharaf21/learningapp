part of 'language_cubit.dart';

sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageSuccess extends LanguageState {
  final String language;

  //jij
  LanguageSuccess({required this.language});
}
