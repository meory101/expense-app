class NormalNotificationModel{
  late String title;
  late String description;

  NormalNotificationModel();


  NormalNotificationModel.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    description = map['description'];


  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['description'] = description;


    return map;
  }
}