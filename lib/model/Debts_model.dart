class Debts {

  late String Amount_Depts;
  late String Amount_Paid_Depts;
  late String Date;
  late String Name;
  late String Note;
  late String UserID;

  Debts();

  Debts.fromMap(Map<String, dynamic> map) {
    Amount_Depts = map['Amount_Depts'];
    Amount_Paid_Depts = map['Amount_Paid_Depts'];
    Date = map['Date'];
    Name = map['c'];
    Note = map['Note'];
    UserID = map['UserID'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['Amount_Depts'] = Amount_Depts;
    map['Amount_Paid_Depts'] = Amount_Paid_Depts;
    map['Date'] = Date;
    map['Name'] = Name;
    map['Note'] = Note;
    map['UserID'] = UserID;
    return map;
  }
}