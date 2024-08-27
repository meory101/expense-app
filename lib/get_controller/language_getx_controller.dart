import 'package:get/get.dart';
import 'package:tasty_booking/shared_preferences/shared_prefrences_controller.dart';

class LanguageGetexController extends GetxController {

  String? currentLanguage =SharedPrefController().getValueFor<String>(key: PrefKeys.language.name);
  String? language;

 static LanguageGetexController get to => Get.find<LanguageGetexController>();

/* final GeneralAppRequest _generalAppRequest =GeneralAppRequest();
  List<LanguageModel> langItem =<LanguageModel>[];*/
  List<dynamic> permissionList = <dynamic>[];
  bool loading = false;
  @override
  void onInit() {
    language = currentLanguage;
    // read();
    super.onInit();
  }

  void read() async {
    loading = true;
/*    permissionList = await PlansApiController().plansPermissions();
    langItem = await _generalAppRequest.getLanguagesApp();*/
    loading = false;
    update();
  }

  Future<void> changeLanguage({required String languageCode}) async{
    language = languageCode;
      if(language != null){
        SharedPrefController().changeLanguage(langCode: language!);
        currentLanguage = languageCode;
      }
    update();
  }
 Future<void> saveLanguageAfterLogOut()async{
   if(language != null){
     SharedPrefController().changeLanguage(langCode: language!);
   }
     update();
 }


}