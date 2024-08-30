class ExpenseModel{
  late String expenseAmount;
  late String expenseType;
  late String ceiling;
  late String userId;
  late String userArea;
  late String userName;
  ExpenseModel();


  ExpenseModel.fromMap(Map<String, dynamic> map) {
    expenseAmount = map['expenseAmount'];
    expenseType = map['expenseType'];
    ceiling = map['ceiling'];
    userId = map['userId'];
    userArea = map['userArea'];
    userName = map['userName'];

  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['expenseAmount'] = expenseAmount;
    map['expenseType'] = expenseType;
    map['ceiling'] = ceiling;
    map['userId'] = userId;
    map['userArea'] = userArea;
    map['userName'] = userName;

    return map;
  }
}