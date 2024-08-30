import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasty_booking/model/fb_response.dart';


class FbAuthController {
  ///Functions:
  /// 1) signInWithEmailAndPassword
  /// 2) createAccountWithEmailAndPassword
  /// 3) signOut
  ///

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<FbResponse> signIn({required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      bool verified = userCredential.user!.emailVerified;
      if (!userCredential.user!.emailVerified) {
        await userCredential.user!.sendEmailVerification();
        await _auth.signOut();
      }
      return FbResponse(
        verified ? 'تم تسجيل الدخول بنجاح' : 'الرجاء تفعيل بريدك الإلكتروني',
        userCredential.user!.emailVerified,
      );
    } on FirebaseAuthException catch (e) {
      print('Exception 1');
      return FbResponse(e.message ?? '', false);
    } catch (e) {
      print('Exception 2');
      return FbResponse('عذرا لقد حصل خطأ ما !', false);
    }
  }

  Future<FbResponse> createAccount(
      {required String email,
      required String password,
      required String name,
      required String phone,
      required String username,
      required String latitude,
      required String longitude,
      required String userArea,
      }) async {
    try{
      print("After");
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      print("Before");

      await userCredential.user!.updateDisplayName(name);
      await userCredential.user!.sendEmailVerification();
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'email': email,
        'phone': phone,
        'username': username,
        'latitude': latitude,
        'longitude': longitude,
        'userArea': userArea,
      });

      await _auth.signOut();
      return FbResponse('تم التسجيل بنجاء , قم بتفعيل بريدك الالكتروني', true);
    }on FirebaseAuthException catch(e) {
      return FbResponse(e.message ?? '', false);
    }catch(e) {
      return FbResponse('حدث خطأ ما !', false);
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  User get currentUser => _auth.currentUser!;


  bool get loggedIn => _auth.currentUser != null;


}
