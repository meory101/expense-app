
import 'package:tasty_booking/model/fb_response.dart';

mixin FirebaseHelper {
  FbResponse get successResponse =>
      FbResponse('تمت العملية بنجاح', true);

  FbResponse get errorResponse => FbResponse('فشلت العملية !', false);
}
