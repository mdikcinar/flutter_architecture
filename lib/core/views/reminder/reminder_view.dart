import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/base/state/base_state.dart';
import 'package:flutter_architecture/core/base/view/base_view.dart';
import 'package:flutter_architecture/core/components/alertDialog/alert_dialog.dart';
import 'package:flutter_architecture/core/components/appbar/custom_appbar.dart';
import 'package:flutter_architecture/core/components/button/custom_checkbox_listtile.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import 'package:flutter_architecture/core/views/reminder/model/reminder_model.dart';
import 'package:flutter_architecture/core/views/reminder/subView/reminder_card.dart';
import 'package:flutter_architecture/core/views/reminder/viewmodel/reminder_viewmodel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class ReminderView extends StatefulWidget {
  const ReminderView({Key? key}) : super(key: key);

  @override
  _ReminderViewState createState() => _ReminderViewState();
}

class _ReminderViewState extends BaseState<ReminderView> {
  var reminderViewModel = ReminderViewModel();

  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: ReminderViewModel(),
      onModelReady: (model) => reminderViewModel = model as ReminderViewModel,
      onPageBuilder: (context, value) => Scaffold(
        appBar: const CustomAppBar(
          title: LocaleKeys.reminders,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            String reminderTime;
            List<String>? dayList = ['1', '2', '3', '4', '5', '6', '7'];
            String? days;
            await DatePicker.showTimePicker(
              context,
              showSecondsColumn: false,
              onConfirm: (time) async {
                reminderTime = DateFormat('HH:mm').format(time);
                await showCustomAlertDialog(
                  context: context,
                  title: LocaleKeys.reminderRepeat,
                  child: Column(children: [
                    for (var i = 1; i <= 7; i++)
                      CustomCheckboxListtile(
                        value: true,
                        locale: false,
                        title: convertWeekdaysFromDatabase(i.toString()),
                        onChange: (value) {
                          //debugPrint('$i. value: ' + value.toString());
                          addOrDeleteRepeatDay(dayList, value, i.toString());
                        },
                      ),
                  ]),
                  onPressedYes: () async {
                    days = convertWeekdaysToSaveDatabaseModel(dayList);
                    Reminder newReminder = Reminder(reminderTime, days, 'true');
                    await reminderViewModel.addReminder(newReminder);
                  },
                );
              },
            );
          },
          child: Icon(
            Icons.add,
            size: context.extraHighIconSize,
          ),
        ),
        body: Observer(builder: (_) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: context.highPadding),
            child: reminderViewModel.reminders.isEmpty
                ? FutureBuilder(
                    future: reminderViewModel.getReminders(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return reminderListView();
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  )
                : reminderListView(),
          );
        }),
      ),
    );
  }

  Widget reminderListView() {
    return Observer(builder: (_) {
      return ListView.builder(
        itemCount: reminderViewModel.reminders.length,
        itemBuilder: (context, index) {
          return ReminderCard(reminder: reminderViewModel.reminders[index]);
        },
      );
    });
  }
}
