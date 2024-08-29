
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasty_booking/get_controller/language_getx_controller.dart';

enum PrefKeys {
  language,
  loggedIn,
  id,
  name,
  email,
  phone,
  token,
  status,
  image,
  branchId,
  isMember,
  userId
}

class SharedPrefController {
  SharedPrefController._();

  late SharedPreferences _sharedPreferences;
  static SharedPrefController? _instance;

  factory SharedPrefController() {
    return _instance ??= SharedPrefController._();
  }

  Future<void> initPref() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }


/*
  Future<void> save(UserModel user, {bool withToken = true,bool withLoggedIn = true}) async {
    if (withToken) {
      await _sharedPreferences.setString(PrefKeys.token.name, '${user.token}');
    }
    if(withLoggedIn){
      await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    }
    await _sharedPreferences.setString(PrefKeys.id.name, user.userdata!.userId!);
    await _sharedPreferences.setString(PrefKeys.name.name, user.userdata!.memberName??'');
    await _sharedPreferences.setString(PrefKeys.phone.name, user.userdata!.personalPhone??'');
    await _sharedPreferences.setString(PrefKeys.email.name, user.userdata!.email??'');
    await _sharedPreferences.setString(PrefKeys.image.name, user.userdata!.image??'');
    await _sharedPreferences.setString(PrefKeys.isMember.name, user.userdata!.isMember??'');
    await _sharedPreferences.setString(PrefKeys.branchId.name, user.userdata!.branchId??'');
  }
*/
  Future<void> save({required String userId}) async {
    await _sharedPreferences.setBool(PrefKeys.loggedIn.name, true);
    await _sharedPreferences.setString(PrefKeys.userId.name, userId);
  }
  Future<void> saveBranchId(String branchId) async {
    await _sharedPreferences.setString(PrefKeys.branchId.name, branchId);
  }

  void changeLanguage({required String langCode}) {
    _sharedPreferences.setString(PrefKeys.language.name, langCode);
  }
/*  Future<void> setTokenValue({required String token}) async{
    await _sharedPreferences.setString(PrefKeys.token.name, token);
  }*/
  Future<void> changeEmail({required String email}) async{
    await _sharedPreferences.setString(PrefKeys.email.name, email);
  }


  T? getValueFor<T>({required String key}) {
    if (_sharedPreferences.containsKey(key)) {
      return _sharedPreferences.get(key) as T?;
    }
    return null;
  }

  Future<void> clear() async {
    await _sharedPreferences.clear();
    LanguageGetexController.to.saveLanguageAfterLogOut();
  }
}
