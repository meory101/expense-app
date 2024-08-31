class ScheduleNotificationModel{
  late String description;
  late String endDate;
  late String name;
  late String notificationDate;
  late String userId;

  ScheduleNotificationModel();


  ScheduleNotificationModel.fromMap(Map<String, dynamic> map) {
    description = map['description'];
    endDate = map['endDate'];
    name = map['name'];
    notificationDate = map['notificationDate'];
    userId = map['userId'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['description'] = description;
    map['endDate'] = endDate;
    map['name'] = name;
    map['notificationDate'] = notificationDate;
    map['userId'] = userId;

    return map;
  }
}