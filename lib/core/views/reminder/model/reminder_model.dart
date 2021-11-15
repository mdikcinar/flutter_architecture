class Reminder {
  int? reminderID;
  String? reminderTime;
  String? days;
  String? isActive;

  Reminder(this.reminderTime, this.days, this.isActive);
  Reminder.withID(this.reminderID, this.reminderTime, this.days, this.isActive);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['reminderID'] = reminderID;
    map['reminderTime'] = reminderTime;
    map['days'] = days;
    map['isActive'] = isActive;
    return map;
  }

  Reminder.fromMap(Map<String, dynamic> map) {
    reminderID = map['reminderID'];
    reminderTime = map['reminderTime'];
    days = map['days'];
    isActive = map['isActive'];
  }
}
