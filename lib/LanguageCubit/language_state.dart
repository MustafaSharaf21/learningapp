part of 'language_cubit.dart';

@immutable
sealed class LanguageState {}

final class LanguageInitial extends LanguageState {}

final class LanguageSuccess extends LanguageState {
  final String language;

  LanguageSuccess({required this.language});
}