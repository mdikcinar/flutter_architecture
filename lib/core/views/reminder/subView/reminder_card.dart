import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/alertDialog/alert_dialog.dart';
import 'package:flutter_architecture/core/components/button/custom_checkbox_listtile.dart';
import 'package:flutter_architecture/core/components/button/custom_inkwell.dart';
import 'package:flutter_architecture/core/components/text/extra_high_text.dart';
import 'package:flutter_architecture/core/components/text/normal_text.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/init/database/sqlite_service.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import 'package:flutter_architecture/core/views/reminder/model/reminder_model.dart';
import 'package:flutter_architecture/core/views/reminder/viewmodel/reminder_viewmodel.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class ReminderCard extends StatefulWidget {
  final Reminder reminder;
  const ReminderCard({Key? key, required this.reminder}) : super(key: key);

  @override
  _ReminderCardState createState() => _ReminderCardState();
}

class _ReminderCardState extends State<ReminderCard> {
  late bool isActive;
  bool isDeleted = false;
  List<String>? repeatDays;
  final sqliteService = SqliteService();
  @override
  void initState() {
    isActive = widget.reminder.isActive == 'true' ? true : false;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      height: isDeleted ? 0 : context.dynamicHeight(0.245),
      child: SingleChildScrollView(
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(context.normalRadius))),
          child: Padding(
            padding: EdgeInsets.all(context.extraHighPadding),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomInkwell(
                        onTap: () async {
                          await DatePicker.showTimePicker(
                            context,
                            showSecondsColumn: false,
                            onConfirm: (time) async {
                              setState(() {
                                widget.reminder.reminderTime = DateFormat('HH:mm').format(time);
                              });
                              await sqliteService.updateReminder(widget.reminder);
                            },
                          );
                        },
                        child: Row(
                          children: [
                            Text(
                              widget.reminder.reminderTime ?? 'Null',
                              style: TextStyle(fontSize: context.dynamicHeight(0.04), fontFamily: 'Barlow'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Switch(
                      value: isActive,
                      onChanged: (value) async {
                        setState(() {
                          isActive = !isActive;
                          widget.reminder.isActive = isActive.toString();
                        });
                        await sqliteService.updateReminder(widget.reminder);
                      },
                    )
                  ],
                ),
                SizedBox(height: context.extraHighPadding),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomInkwell(
                        onTap: () {
                          showCustomAlertDialog(
                            context: context,
                            title: LocaleKeys.reminderRepeat,
                            child: Column(children: repeatDaysWidgetsAlertDialog()),
                            onPressedYes: () async {
                              setState(() {
                                widget.reminder.days = convertWeekdaysToSaveDatabaseModel(repeatDays);
                              });
                              await sqliteService.updateReminder(widget.reminder);
                            },
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const ExtraHighText(LocaleKeys.reminderRepeat),
                            if (widget.reminder.days != null)
                              NormalText(
                                convertWeekdaysFromDatabase(widget.reminder.days, shorten: true),
                                locale: false,
                                color: context.defaultTextColor.withOpacity(0.8),
                              ),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: context.extraHighRadius,
                      icon: Icon(
                        Icons.delete_rounded,
                        size: context.extraHighIconSize,
                      ),
                      onPressed: () async {
                        await sqliteService.deleteReminder(widget.reminder.reminderID);
                        setState(() {
                          isDeleted = true;
                        });
                      },
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> repeatDaysWidgetsAlertDialog() {
    List<Widget> widgetList = [];
    if (widget.reminder.days != null) {
      repeatDays = widget.reminder.days!.split(',');
    }
    for (var i = 1; i <= 7; i++) {
      if (widget.reminder.days != null && widget.reminder.days!.contains(i.toString())) {
        widgetList.add(
          CustomCheckboxListtile(
            value: true,
            locale: false,
            title: convertWeekdaysFromDatabase(i.toString()),
            onChange: (value) {
              //debugPrint('$i. value: ' + value.toString());
              addOrDeleteRepeatDay(repeatDays, value, i.toString());
            },
          ),
        );
      } else {
        widgetList.add(
          CustomCheckboxListtile(
            value: false,
            locale: false,
            title: convertWeekdaysFromDatabase(i.toString()),
            onChange: (value) {
              //debugPrint('$i. value: ' + value.toString());
              addOrDeleteRepeatDay(repeatDays, value, i.toString());
            },
          ),
        );
      }
    }

    return widgetList;
  }
}
