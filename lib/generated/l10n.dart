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

  /// `EDUspark`
  String get name {
    return Intl.message(
      'EDUspark',
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

  /// `ForgetPassword?`
  String get ForgetPassword {
    return Intl.message(
      'ForgetPassword?',
      name: 'ForgetPassword',
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

  /// `Choose Teacher or Student             `
  String get Choose_Teacher_or_Student {
    return Intl.message(
      'Choose Teacher or Student             ',
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

  /// `Country                                                `
  String get Country {
    return Intl.message(
      'Country                                                ',
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

  /// `Favorite specialization                `
  String get Favorite_specialization {
    return Intl.message(
      'Favorite specialization                ',
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

  /// `All`
  String get All {
    return Intl.message(
      'All',
      name: 'All',
      desc: '',
      args: [],
    );
  }

  /// `courses`
  String get courses {
    return Intl.message(
      'courses',
      name: 'courses',
      desc: '',
      args: [],
    );
  }

  /// `video`
  String get video {
    return Intl.message(
      'video',
      name: 'video',
      desc: '',
      args: [],
    );
  }

  /// `pdf`
  String get Pdf {
    return Intl.message(
      'pdf',
      name: 'Pdf',
      desc: '',
      args: [],
    );
  }

  /// `home`
  String get Home {
    return Intl.message(
      'home',
      name: 'Home',
      desc: '',
      args: [],
    );
  }

  /// `favorite`
  String get Favorite {
    return Intl.message(
      'favorite',
      name: 'Favorite',
      desc: '',
      args: [],
    );
  }

  /// `library`
  String get Library {
    return Intl.message(
      'library',
      name: 'Library',
      desc: '',
      args: [],
    );
  }

  /// `Testting`
  String get Testting {
    return Intl.message(
      'Testting',
      name: 'Testting',
      desc: '',
      args: [],
    );
  }

  /// `Live`
  String get Live {
    return Intl.message(
      'Live',
      name: 'Live',
      desc: '',
      args: [],
    );
  }

  /// `Chatting`
  String get Chatting {
    return Intl.message(
      'Chatting',
      name: 'Chatting',
      desc: '',
      args: [],
    );
  }

  /// `Link copied to clipboard`
  String get Link_copied_to_clipboard {
    return Intl.message(
      'Link copied to clipboard',
      name: 'Link_copied_to_clipboard',
      desc: '',
      args: [],
    );
  }

  /// `Copy The Live Link`
  String get Copy_The_Live_Link {
    return Intl.message(
      'Copy The Live Link',
      name: 'Copy_The_Live_Link',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get Edit_Profile {
    return Intl.message(
      'Edit Profile',
      name: 'Edit_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Interests`
  String get Interests {
    return Intl.message(
      'Interests',
      name: 'Interests',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Select Image Source`
  String get Select_Image_Source {
    return Intl.message(
      'Select Image Source',
      name: 'Select_Image_Source',
      desc: '',
      args: [],
    );
  }

  /// `Gallery`
  String get Gallery {
    return Intl.message(
      'Gallery',
      name: 'Gallery',
      desc: '',
      args: [],
    );
  }

  /// `Camera`
  String get Camera {
    return Intl.message(
      'Camera',
      name: 'Camera',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get Skip {
    return Intl.message(
      'Skip',
      name: 'Skip',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get Get_Started {
    return Intl.message(
      'Get Started',
      name: 'Get_Started',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get Next {
    return Intl.message(
      'Next',
      name: 'Next',
      desc: '',
      args: [],
    );
  }

  /// `The most`
  String get The_most {
    return Intl.message(
      'The most',
      name: 'The_most',
      desc: '',
      args: [],
    );
  }

  /// `author`
  String get author {
    return Intl.message(
      'author',
      name: 'author',
      desc: '',
      args: [],
    );
  }

  /// `Create Live`
  String get Create_Live {
    return Intl.message(
      'Create Live',
      name: 'Create_Live',
      desc: '',
      args: [],
    );
  }

  /// `Welcome Teacher`
  String get Welcome_Teacher {
    return Intl.message(
      'Welcome Teacher',
      name: 'Welcome_Teacher',
      desc: '',
      args: [],
    );
  }

  /// `You can create Live here`
  String get You_can_create_Live_here {
    return Intl.message(
      'You can create Live here',
      name: 'You_can_create_Live_here',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Title`
  String get Enter_a_Title {
    return Intl.message(
      'Enter a Title',
      name: 'Enter_a_Title',
      desc: '',
      args: [],
    );
  }

  /// `Title`
  String get Title {
    return Intl.message(
      'Title',
      name: 'Title',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Time`
  String get Enter_a_Time {
    return Intl.message(
      'Enter a Time',
      name: 'Enter_a_Time',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Time Format (hh:mm)`
  String get Invalid_Time_Format {
    return Intl.message(
      'Invalid Time Format (hh:mm)',
      name: 'Invalid_Time_Format',
      desc: '',
      args: [],
    );
  }

  /// `Invalid Hours (00-23)`
  String get Invalid_Hours {
    return Intl.message(
      'Invalid Hours (00-23)',
      name: 'Invalid_Hours',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get Time {
    return Intl.message(
      'Time',
      name: 'Time',
      desc: '',
      args: [],
    );
  }

  /// `Enter a Date`
  String get Enter_Date {
    return Intl.message(
      'Enter a Date',
      name: 'Enter_Date',
      desc: '',
      args: [],
    );
  }

  /// `Cannot enter a past date`
  String get Cannot_enter_a_past_date {
    return Intl.message(
      'Cannot enter a past date',
      name: 'Cannot_enter_a_past_date',
      desc: '',
      args: [],
    );
  }

  /// `Enter the date correctly yyyy-MM-dd`
  String get Enter_the_date_correctly_yyyy_MM_dd {
    return Intl.message(
      'Enter the date correctly yyyy-MM-dd',
      name: 'Enter_the_date_correctly_yyyy_MM_dd',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Enter a link`
  String get Enter_a_link {
    return Intl.message(
      'Enter a link',
      name: 'Enter_a_link',
      desc: '',
      args: [],
    );
  }

  /// `Add link`
  String get Add_link {
    return Intl.message(
      'Add link',
      name: 'Add_link',
      desc: '',
      args: [],
    );
  }

  /// `specialization`
  String get Specialization {
    return Intl.message(
      'specialization',
      name: 'Specialization',
      desc: '',
      args: [],
    );
  }

  /// `here we will put description`
  String get here_we_will_put_description {
    return Intl.message(
      'here we will put description',
      name: 'here_we_will_put_description',
      desc: '',
      args: [],
    );
  }

  /// `Check Email`
  String get Check_Email {
    return Intl.message(
      'Check Email',
      name: 'Check_Email',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter Your Email Address To Recive A Verification Code`
  String get Please_Enter_Your_Email_Address_To_Recive_A_Verification_Code {
    return Intl.message(
      'Please Enter Your Email Address To Recive A Verification Code',
      name: 'Please_Enter_Your_Email_Address_To_Recive_A_Verification_Code',
      desc: '',
      args: [],
    );
  }

  /// `Enter Your Email`
  String get Enter_Your_Email {
    return Intl.message(
      'Enter Your Email',
      name: 'Enter_Your_Email',
      desc: '',
      args: [],
    );
  }

  /// `Check`
  String get Check {
    return Intl.message(
      'Check',
      name: 'Check',
      desc: '',
      args: [],
    );
  }

  /// `My Content`
  String get My_Content {
    return Intl.message(
      'My Content',
      name: 'My_Content',
      desc: '',
      args: [],
    );
  }

  /// `select all`
  String get selectall {
    return Intl.message(
      'select all',
      name: 'selectall',
      desc: '',
      args: [],
    );
  }

  /// `delete`
  String get delete {
    return Intl.message(
      'delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get Add {
    return Intl.message(
      'Add',
      name: 'Add',
      desc: '',
      args: [],
    );
  }

  /// `edit`
  String get edit {
    return Intl.message(
      'edit',
      name: 'edit',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get Reset_Password {
    return Intl.message(
      'Reset Password',
      name: 'Reset_Password',
      desc: '',
      args: [],
    );
  }

  /// `NewPassword`
  String get NewPassword {
    return Intl.message(
      'NewPassword',
      name: 'NewPassword',
      desc: '',
      args: [],
    );
  }

  /// `Please Enter new Password`
  String get Please_Enter_new_Password {
    return Intl.message(
      'Please Enter new Password',
      name: 'Please_Enter_new_Password',
      desc: '',
      args: [],
    );
  }

  /// `Recent`
  String get Recent {
    return Intl.message(
      'Recent',
      name: 'Recent',
      desc: '',
      args: [],
    );
  }

  /// `Search Here`
  String get Search_Here {
    return Intl.message(
      'Search Here',
      name: 'Search_Here',
      desc: '',
      args: [],
    );
  }

  /// `Setting`
  String get Setting {
    return Intl.message(
      'Setting',
      name: 'Setting',
      desc: '',
      args: [],
    );
  }

  /// `My Account`
  String get My_Account {
    return Intl.message(
      'My Account',
      name: 'My_Account',
      desc: '',
      args: [],
    );
  }

  /// `Add course`
  String get Add_course {
    return Intl.message(
      'Add course',
      name: 'Add_course',
      desc: '',
      args: [],
    );
  }

  /// `My Content`
  String get My_content {
    return Intl.message(
      'My Content',
      name: 'My_content',
      desc: '',
      args: [],
    );
  }

  /// `Dark Mood`
  String get Dark_Mood {
    return Intl.message(
      'Dark Mood',
      name: 'Dark_Mood',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to log out?`
  String get Are_you_sure_to_log_out {
    return Intl.message(
      'Are you sure to log out?',
      name: 'Are_you_sure_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `confirm`
  String get confirm {
    return Intl.message(
      'confirm',
      name: 'confirm',
      desc: '',
      args: [],
    );
  }

  /// `cancel`
  String get cancel {
    return Intl.message(
      'cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `log out`
  String get log_out {
    return Intl.message(
      'log out',
      name: 'log_out',
      desc: '',
      args: [],
    );
  }

  /// `click here to log out`
  String get click_here_to_log_out {
    return Intl.message(
      'click here to log out',
      name: 'click_here_to_log_out',
      desc: '',
      args: [],
    );
  }

  /// `Close`
  String get Close {
    return Intl.message(
      'Close',
      name: 'Close',
      desc: '',
      args: [],
    );
  }

  /// `Language`
  String get Language {
    return Intl.message(
      'Language',
      name: 'Language',
      desc: '',
      args: [],
    );
  }

  /// `Arabic`
  String get Arabic {
    return Intl.message(
      'Arabic',
      name: 'Arabic',
      desc: '',
      args: [],
    );
  }

  /// `English`
  String get English {
    return Intl.message(
      'English',
      name: 'English',
      desc: '',
      args: [],
    );
  }

  /// `Learning is Everything`
  String get Learning_is_Everything {
    return Intl.message(
      'Learning is Everything',
      name: 'Learning_is_Everything',
      desc: '',
      args: [],
    );
  }

  /// `Learning with pleasure whenever you are`
  String get Learning_with_pleasure_whenever_you_are {
    return Intl.message(
      'Learning with pleasure whenever you are',
      name: 'Learning_with_pleasure_whenever_you_are',
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
