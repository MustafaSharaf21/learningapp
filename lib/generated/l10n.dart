// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Learning`
  String get name {
    return Intl.message(
      'Learning',
      name: 'name',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get titleLogin {
    return Intl.message(
      'Login',
      name: 'titleLogin',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get email {
    return Intl.message(
      'Email',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `Enter an email`
  String get enter_an_email {
    return Intl.message(
      'Enter an email',
      name: 'enter_an_email',
      desc: '',
      args: [],
    );
  }

  /// `Enter a valid Email`
  String get enter_a_valid_Email {
    return Intl.message(
      'Enter a valid Email',
      name: 'enter_a_valid_Email',
      desc: '',
      args: [],
    );
  }

  /// `password`
  String get password {
    return Intl.message(
      'password',
      name: 'password',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Password`
  String get enter_a_password {
    return Intl.message(
      'Enter a Password',
      name: 'enter_a_password',
      desc: '',
      args: [],
    );
  }

  /// `Password must be greater than six characters`
  String get Password_characters {
    return Intl.message(
      'Password must be greater than six characters',
      name: 'Password_characters',
      desc: '',
      args: [],
    );
  }

  /// `Login with Facebook or Google`
  String get Login_with_Facebook_or_Google {
    return Intl.message(
      'Login with Facebook or Google',
      name: 'Login_with_Facebook_or_Google',
      desc: '',
      args: [],
    );
  }

  /// `If you don't have an account`
  String get If_you_dont_have_an_account {
    return Intl.message(
      'If you don\'t have an account',
      name: 'If_you_dont_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Register`
  String get titleRegister {
    return Intl.message(
      'Register',
      name: 'titleRegister',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to Register as Teacher or Student ?`
  String get Teacher_or_Student {
    return Intl.message(
      'Do you want to Register as Teacher or Student ?',
      name: 'Teacher_or_Student',
      desc: '',
      args: [],
    );
  }

  /// `Choose Teacher or Student`
  String get Choose_Teacher_or_Student {
    return Intl.message(
      'Choose Teacher or Student',
      name: 'Choose_Teacher_or_Student',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get Full_Name {
    return Intl.message(
      'Full Name',
      name: 'Full_Name',
      desc: '',
      args: [],
    );
  }

  /// `Enter a name`
  String get Enter_a_name {
    return Intl.message(
      'Enter a name',
      name: 'Enter_a_name',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get Confirm_Password {
    return Intl.message(
      'Confirm Password',
      name: 'Confirm_Password',
      desc: '',
      args: [],
    );
  }

  /// `Re-enter Password`
  String get Reenter_Password {
    return Intl.message(
      'Re-enter Password',
      name: 'Reenter_Password',
      desc: '',
      args: [],
    );
  }

  /// `Enter the Password Correctly`
  String get Enter_the_Password_Correctly {
    return Intl.message(
      'Enter the Password Correctly',
      name: 'Enter_the_Password_Correctly',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number`
  String get Phone_Number {
    return Intl.message(
      'Phone Number',
      name: 'Phone_Number',
      desc: '',
      args: [],
    );
  }

  /// `Country                                            `
  String get Country {
    return Intl.message(
      'Country                                            ',
      name: 'Country',
      desc: '',
      args: [],
    );
  }

  /// `specialization`
  String get specialization {
    return Intl.message(
      'specialization',
      name: 'specialization',
      desc: '',
      args: [],
    );
  }

  /// `Favorite specialization `
  String get Favorite_specialization {
    return Intl.message(
      'Favorite specialization ',
      name: 'Favorite_specialization',
      desc: '',
      args: [],
    );
  }

  /// `Date of birth`
  String get Date_of_birth {
    return Intl.message(
      'Date of birth',
      name: 'Date_of_birth',
      desc: '',
      args: [],
    );
  }

  /// `Gender`
  String get Gender {
    return Intl.message(
      'Gender',
      name: 'Gender',
      desc: '',
      args: [],
    );
  }

  /// `I'm already a member`
  String get already_a_member {
    return Intl.message(
      'I\'m already a member',
      name: 'already_a_member',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
