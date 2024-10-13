class ExpenseAmountModel{
  late String userId;
  late String expenseAmount;
  late String expenseType;
  late String dateNow;
  late String dateNowMonth;
  late String dateNowYear;
  late String expenseName;
  ExpenseAmountModel();


  ExpenseAmountModel.fromMap(Map<String, dynamic> map) {
    userId = map['userId'];
    expenseAmount = map['expenseAmount'];
    expenseType = map['expenseType'];
    dateNow = map['dateNow'];
    dateNowMonth = map['dateNowMonth'];
    dateNowYear = map['dateNowYear'];
    expenseName = map['expenseName'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['userId'] = userId;
    map['expenseAmount'] = expenseAmount;
    map['expenseType'] = expenseType;
    map['dateNow'] = dateNow;
    map['dateNowMonth'] = dateNowMonth;
    map['dateNowYear'] = dateNowYear;
    map['expenseName'] = expenseName;
    return map;
  }
}