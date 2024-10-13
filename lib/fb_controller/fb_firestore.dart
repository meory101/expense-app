import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasty_booking/model/Debts_model.dart';
import 'package:tasty_booking/model/expense_amount_model.dart';
import 'package:tasty_booking/model/expense_model.dart';
import 'package:tasty_booking/model/fb_response.dart';
import 'package:tasty_booking/model/normal_notification_model.dart';
import 'package:tasty_booking/model/schedule_notification_model.dart';
import 'package:tasty_booking/model/user_model.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';
import 'package:tasty_booking/utils/firebase_helper.dart';



class FbFirestoreController with FirebaseHelper {
  ///Functions
  ///1) Create
  ///2) Read
  ///3) Update
  ///4) Delete

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;

  Future<void> getUserData({required String doc}) async {
    print('called this');
    try {
      print('go there${doc}');

      print( _firestore
          .collection('users')
          .doc(doc).get());

     var user =await _firestore
          .collection('users')
          .doc(doc).get();

     print(user.data());

      print('000000000000000000000');
      // استخدام withConverter لتحويل البيانات من وإلى UserModel
      DocumentSnapshot<UserModel> snapshot = await _firestore
          .collection('users')
          .doc(doc)
          .withConverter<UserModel>(
        fromFirestore: (snapshot, options) =>
            UserModel.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      ).get();
    print(snapshot.data());
      UserModel? userModel = snapshot.data();
      print(userModel);
      print('user model');
      if (userModel != null) {
        await SharedPrefController().save(userId: doc, userModel: userModel);
      }
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<FbResponse> createExpense(ExpenseModel expenseModel,
      String collection) async {
    return _firestore
        .collection(collection)
        .add(expenseModel.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }

  Stream<QuerySnapshot<Debts>> readDebts() async* {
    yield* _firestore
        .collection('Debts').where('UserID',isEqualTo: user!.uid)
        .withConverter<Debts>(
      fromFirestore: (snapshot, options) => Debts.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();}


  Stream<QuerySnapshot<ExpenseModel>> readBasicSupplies(String collection) async* {
    yield* _firestore
        .collection(collection).where('userId',isEqualTo: user!.uid)
        .withConverter<ExpenseModel>(
      fromFirestore: (snapshot, options) => ExpenseModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }

  Stream<QuerySnapshot<ExpenseModel>> readSeamUserArea(String collection,String userArea) async* {

    yield* _firestore
        .collection(collection).where('userArea', isEqualTo: userArea)
        .withConverter<ExpenseModel>(
      fromFirestore: (snapshot, options) => ExpenseModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }
  Stream<QuerySnapshot<ExpenseModel>> readSameTime(String collection,String DateNow) async* {

    yield* _firestore
        .collection(collection).where('userId',isEqualTo: user!.uid).where('dateNow', isEqualTo: DateNow)
        .withConverter<ExpenseModel>(
      fromFirestore: (snapshot, options) => ExpenseModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }
  Stream<QuerySnapshot<ExpenseModel>> readSameTimeMonthe(String collection,String dateNowMonth) async* {

    yield* _firestore
        .collection(collection).where('userId',isEqualTo: user!.uid).where('dateNowMonth', isEqualTo: dateNowMonth)
        .withConverter<ExpenseModel>(
      fromFirestore: (snapshot, options) => ExpenseModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }
  Stream<QuerySnapshot<ExpenseModel>> readSameTimeYeare(String collection,String dateNowYear) async* {

    yield* _firestore
        .collection(collection).where('userId',isEqualTo: user!.uid).where('dateNowYear', isEqualTo: dateNowYear)
        .withConverter<ExpenseModel>(
      fromFirestore: (snapshot, options) => ExpenseModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }

  Future<FbResponse> createExpenseAmount(ExpenseAmountModel expenseAmount,) async {
    return _firestore
        .collection('ExpenseAmount')
        .add(expenseAmount.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }

  Stream<QuerySnapshot<ExpenseAmountModel>> readExpenseAmount({required String check, required String isEqualTo}) async* {
    yield* _firestore
        .collection('ExpenseAmount').where('userId',isEqualTo: user!.uid).where(check,isEqualTo: isEqualTo)
        .withConverter<ExpenseAmountModel>(
      fromFirestore: (snapshot, options) => ExpenseAmountModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }

  Stream<QuerySnapshot<ScheduleNotificationModel>> readScheduleNotification({required String check, required String isEqualTo}) async* {
    yield* _firestore
        .collection('scheduleNotification').where('userId',isEqualTo: user!.uid).where(check,isEqualTo: isEqualTo)
        .withConverter<ScheduleNotificationModel>(
      fromFirestore: (snapshot, options) => ScheduleNotificationModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }

  Stream<QuerySnapshot<NormalNotificationModel>> readNormalNotification() async* {
    yield* _firestore
        .collection('normalNotification').withConverter<NormalNotificationModel>(
      fromFirestore: (snapshot, options) => NormalNotificationModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }

}
/*  Stream<QuerySnapshot<Contact>> readContact() async* {
    yield* _firestore
        .collection('contact')
        .withConverter<Contact>(
      fromFirestore: (snapshot, options) => Contact.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }
  Stream<QuerySnapshot<AboutUsModel>> readAboutUs() async* {
    yield* _firestore
        .collection('aboutUs')
        .withConverter<AboutUsModel>(
      fromFirestore: (snapshot, options) => AboutUsModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }
  Stream<QuerySnapshot<JobOrderModel>> readMyjob() async* {

      yield* _firestore
          .collection('jobOrder').where('userId', isEqualTo: user!.uid)
          .withConverter<JobOrderModel>(
        fromFirestore: (snapshot, options) => JobOrderModel.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      )
          .snapshots();

  }

  Stream<QuerySnapshot<JobOrderModel>> readJobOrder() async* {
    yield* _firestore
        .collection('jobOrder')
        .withConverter<JobOrderModel>(
      fromFirestore: (snapshot, options) => JobOrderModel.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();
  }
  Future<FbResponse> updateJobOrder(JobOrderModel jobOrder) async {
    return _firestore
        .collection('jobOrder')
        .doc(jobOrder.id)
        .update(jobOrder.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }*/

/*  Stream<QuerySnapshot<Contact>> read() async* {
    yield* _firestore
        .collection('Parking').orderBy('title')
        .withConverter<Contact>(
      fromFirestore: (snapshot, options) => Contact.fromMap(snapshot.data()!),
      toFirestore: (value, options) => value.toMap(),
    )
        .snapshots();

  }*/
/*  Future<FbResponse> create(ParkingModel parking) async {
    return _firestore
        .collection('Notes')
        .add(note.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }*/

/*  Future<FbResponse> update(ParkingModel parking) async {
    return _firestore
        .collection('Parking')
        .doc(parking.id)
        .update(parking.toMap())
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }

  Future<FbResponse> delete(String id) async {
    return _firestore
        .collection('Parking')
        .doc(id)
        .delete()
        .then((value) => successResponse)
        .catchError((error) => errorResponse);
  }

*/

/*  Stream<QuerySnapshot<ParkingModel>> readMyBooking() async* {
    if(user != null){
      yield* _firestore
          .collection('Parking').where('userId', isEqualTo: user!.uid)
          .withConverter<ParkingModel>(
        fromFirestore: (snapshot, options) => ParkingModel.fromMap(snapshot.data()!),
        toFirestore: (value, options) => value.toMap(),
      )
          .snapshots();
    }

  }*/

