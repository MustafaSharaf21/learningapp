import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:timeago/src/messages/lookupmessages.dart';

class CustomMessages implements LookupMessages {
  @override
  String lessThanOneMinute(int seconds) => 'just now';

  @override
  String aboutAMinute(int minutes) => '1 minute ago';

  @override
  String minutes(int minutes) => '$minutes minutes ago';

  @override
  String aboutAnHour(int minutes) => 'an hour ago';

  @override
  String hours(int hours) => '$hours hours ago';

  @override
  String aDay(int hours) => '1 day ago';

  @override
  String days(int days) => '$days days ago';

  @override
  String aboutAMonth(int days) => '1 month ago'; // إزالة about هنا

  @override
  String months(int months) => '$months months ago';

  @override
  String aboutAYear(int year) => '1 year ago'; // إزالة about هنا

  @override
  String years(int years) => '$years years ago';

  @override
  String prefixAgo() => '';

  @override
  String prefixFromNow() => '';

  @override
  String suffixAgo() => 'ago';

  @override
  String suffixFromNow() => 'from now';

  @override
  String wordSeparator() => ' ';
}

void setupCustomTimeago() {
  timeago.setLocaleMessages('custom', CustomMessages());
}
