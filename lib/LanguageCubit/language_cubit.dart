import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../screen/shared/shared.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() : super(LanguageInitial());
  String _language = "en";

  String get language => _language;

  setLanguage(String ln) {
    _language = ln;
    CacheNetwork.insertToCache(key: 'language', value: ln);
    emit(LanguageSuccess(language: ln));
  }

  Future<void> loadLanguage() async {
    String? savedLanguage = await CacheNetwork.getCacheData(key: 'language');
    if (savedLanguage != null) {
      _language = savedLanguage;
      emit(LanguageSuccess(language: savedLanguage));
    }
  }
}
