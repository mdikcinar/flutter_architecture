import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/init/database/sqlite_service.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import 'package:flutter_architecture/core/views/reminder/model/reminder_model.dart';
import 'package:mobx/mobx.dart';
part 'reminder_viewmodel.g.dart';

class ReminderViewModel = _ReminderViewModelBase with _$ReminderViewModel;

abstract class _ReminderViewModelBase with Store {
  final sqliteService = SqliteService();

  @observable
  var reminders = <Reminder>[];

  @action
  Future<List<Reminder>> getReminders() async {
    var result = await sqliteService.getReminders();
    reminders = result;
    return result;
  }

  @action
  Future<int?> addReminder(Reminder newReminder) async {
    var addedReminderID = await sqliteService.addReminder(newReminder);
    newReminder.reminderID = addedReminderID;
    reminders += [newReminder];
    return addedReminderID;
  }
}

String convertWeekdaysFromDatabase(String? days, {bool shorten = false}) {
  String weekDaysString = '';
  if (days != null) {
    var dayList = days.split(',');
    for (var index = 0; index < dayList.length; index++) {
      switch (dayList[index]) {
        case '1':
          if (shorten) {
            weekDaysString += LocaleKeys.dateSundayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateSunday.locale;
          }
          break;
        case '2':
          if (shorten) {
            weekDaysString += LocaleKeys.dateMondayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateMonday.locale;
          }
          break;
        case '3':
          if (shorten) {
            weekDaysString += LocaleKeys.dateTuesdayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateTuesday.locale;
          }
          break;
        case '4':
          if (shorten) {
            weekDaysString += LocaleKeys.dateWednesdayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateWednesday.locale;
          }
          break;
        case '5':
          if (shorten) {
            weekDaysString += LocaleKeys.dateThursdayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateThursday.locale;
          }
          break;
        case '6':
          if (shorten) {
            weekDaysString += LocaleKeys.dateFridayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateFriday.locale;
          }
          break;
        case '7':
          if (shorten) {
            weekDaysString += LocaleKeys.dateSaturdayShorten.locale;
          } else {
            weekDaysString += LocaleKeys.dateSaturday.locale;
          }
          break;
      }
      if (dayList.length > 1 && index != dayList.length - 1) weekDaysString += ', ';
    }
  }
  return weekDaysString;
}

void addOrDeleteRepeatDay(List<String>? days, bool checkBoxValue, String dayNumber) {
  if (days != null) {
    if (checkBoxValue && !days.contains(dayNumber)) {
      days.add(dayNumber);
    } else if (!checkBoxValue && days.contains(dayNumber)) {
      days.remove(dayNumber);
    }
  }
}

String? convertWeekdaysToSaveDatabaseModel(List<String>? dayList) {
  String databaseRepeatDays = '';
  if (dayList != null && dayList.isNotEmpty) {
    if (dayList.length > 1) {
      for (var i = 0; i < dayList.length; i++) {
        databaseRepeatDays += dayList[i];
        if (i != dayList.length - 1) databaseRepeatDays += ',';
      }
    } else {
      databaseRepeatDays = dayList.first;
    }
  }
  return databaseRepeatDays.isNotEmpty ? databaseRepeatDays : null;
}
