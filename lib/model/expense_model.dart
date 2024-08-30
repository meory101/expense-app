class ExpenseModel{
  late String expenseAmount;
  late String expenseType;
  late String userId;
  ExpenseModel();


  ExpenseModel.fromMap(Map<String, dynamic> map) {
    expenseAmount = map['expenseAmount'];
    expenseType = map['expenseType'];
    userId = map['userId'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['expenseAmount'] = expenseAmount;
    map['expenseType'] = expenseType;
    map['userId'] = userId;

    return map;
  }
}