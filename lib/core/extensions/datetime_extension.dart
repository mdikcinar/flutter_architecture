import 'string_extension.dart';
import '../init/language/locale_keys.g.dart';

extension DateTimeExtension on DateTime {
  String getMonthString({bool shorten = false}) {
    switch (month) {
      case 1:
        if (shorten) return LocaleKeys.dateJanuaryShorten.locale;
        return LocaleKeys.dateJanuary.locale;
      case 2:
        if (shorten) return LocaleKeys.dateFebruaryShorten.locale;
        return LocaleKeys.dateFebruary.locale;
      case 3:
        if (shorten) return LocaleKeys.dateMarchShorten.locale;
        return LocaleKeys.dateMarch.locale;
      case 4:
        if (shorten) return LocaleKeys.dateAprilShorten.locale;
        return LocaleKeys.dateApril.locale;
      case 5:
        if (shorten) return LocaleKeys.dateMayShorten.locale;
        return LocaleKeys.dateMay.locale;
      case 6:
        if (shorten) return LocaleKeys.dateJunShorten.locale;
        return LocaleKeys.dateJun.locale;
      case 7:
        if (shorten) return LocaleKeys.dateJulyShorten.locale;
        return LocaleKeys.dateJuly.locale;
      case 8:
        if (shorten) return LocaleKeys.dateAugustShorten.locale;
        return LocaleKeys.dateAugust.locale;
      case 9:
        if (shorten) return LocaleKeys.dateSeptemperShorten.locale;
        return LocaleKeys.dateSeptemper.locale;
      case 10:
        if (shorten) return LocaleKeys.dateOctoberShorten.locale;
        return LocaleKeys.dateOctober.locale;
      case 11:
        if (shorten) return LocaleKeys.dateNovemberShorten.locale;
        return LocaleKeys.dateNovember.locale;
      case 12:
        if (shorten) return LocaleKeys.dateDecemberShorten.locale;
        return LocaleKeys.dateDecember.locale;
      default:
        return 'Err';
    }
  }

  String dateFormat({
    bool twoLine = false,
    bool shorten = false,
  }) {
    var today = DateTime.now();
    //var oneDay = const Duration(days: 1);
    var twoDay = const Duration(days: 2);
    var oneWeek = const Duration(days: 7);

    var difference = today.difference(this);
    if (difference.compareTo(twoDay) == -1) {
      if (difference.inMinutes < 1) {
        if (shorten) return difference.inSeconds.toString() + LocaleKeys.secondAgoShorten.locale;
        return difference.inSeconds.toString() + ' ' + LocaleKeys.secondAgo.locale;
      } else if (difference.inMinutes == 1) {
        if (shorten) return difference.inMinutes.toString() + LocaleKeys.minuteAgoShorten.locale;
        return difference.inMinutes.toString() + ' ' + LocaleKeys.minuteAgo.locale;
      } else if (difference.inMinutes > 1 && difference.inMinutes < 59) {
        if (shorten) return difference.inMinutes.toString() + LocaleKeys.minutesAgoShorten.locale;
        return difference.inMinutes.toString() + ' ' + LocaleKeys.minutesAgo.locale; //LocaleKeys.dateToday.locale;
      } else if (difference.inHours == 1) {
        if (shorten) return difference.inHours.toString() + LocaleKeys.hourAgoShorten.locale;
        return difference.inHours.toString() + ' ' + LocaleKeys.hourAgo.locale;
      }
      if (shorten) return difference.inHours.toString() + LocaleKeys.hoursAgoShorten.locale;
      return difference.inHours.toString() + ' ' + LocaleKeys.hoursAgo.locale;
    } else if (difference.compareTo(oneWeek) == -1) {
      switch (weekday) {
        case 1:
          if (shorten) return LocaleKeys.dateMondayShorten.locale;
          return LocaleKeys.dateMonday.locale;
        case 2:
          if (shorten) return LocaleKeys.dateTuesdayShorten.locale;
          return LocaleKeys.dateTuesday.locale;
        case 3:
          if (shorten) return LocaleKeys.dateWednesdayShorten.locale;
          return LocaleKeys.dateWednesday.locale;
        case 4:
          if (shorten) return LocaleKeys.dateThursdayShorten.locale;
          return LocaleKeys.dateThursday.locale;
        case 5:
          if (shorten) return LocaleKeys.dateFridayShorten.locale;
          return LocaleKeys.dateFriday.locale;
        case 6:
          if (shorten) return LocaleKeys.dateSaturdayShorten.locale;
          return LocaleKeys.dateSaturday.locale;
        case 7:
          if (shorten) return LocaleKeys.dateSundayShorten.locale;
          return LocaleKeys.dateSunday.locale;
      }
    } else if (year == today.year) {
      if (twoLine) {
        return '$day \n $month';
      }
      return '$day ' + getMonthString(shorten: shorten);
    } else {
      if (twoLine) {
        return '$day $month \n $year';
      }
      return '$day ' + getMonthString(shorten: shorten) + ' $year';
    }
    return '';
  }
}
