// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reminder_viewmodel.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReminderViewModel on _ReminderViewModelBase, Store {
  final _$remindersAtom = Atom(name: '_ReminderViewModelBase.reminders');

  @override
  List<Reminder> get reminders {
    _$remindersAtom.reportRead();
    return super.reminders;
  }

  @override
  set reminders(List<Reminder> value) {
    _$remindersAtom.reportWrite(value, super.reminders, () {
      super.reminders = value;
    });
  }

  final _$getRemindersAsyncAction =
      AsyncAction('_ReminderViewModelBase.getReminders');

  @override
  Future<List<Reminder>> getReminders() {
    return _$getRemindersAsyncAction.run(() => super.getReminders());
  }

  final _$addReminderAsyncAction =
      AsyncAction('_ReminderViewModelBase.addReminder');

  @override
  Future<int?> addReminder(Reminder newReminder) {
    return _$addReminderAsyncAction.run(() => super.addReminder(newReminder));
  }

  @override
  String toString() {
    return '''
reminders: ${reminders}
    ''';
  }
}
