import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:godartadmin/services/fb_services.dart';

class LoginVM with ChangeNotifier {
  bool _isLoading = false;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool get isLoading => _isLoading;

  final FirebaseServices _fbServices = FirebaseServices();

  _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> logOut() async {
    await _auth.signOut();
    notifyListeners();
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    _setLoading(true);

    _fbServices.getAdminCred(email).then((value) async {
      if (value.exists) {
        // this username exist
        if (value.get('username') == email &&
            value.get('password') == password) {
          _setLoading(false);

// sign in anonymously
          try {
            await FirebaseAuth.instance.signInAnonymously();
            notifyListeners();
            _setLoading(false);
          } catch (e) {
            debugPrint(e.toString());
            // not successful sign in
            _setLoading(false);
            //incorrect
            EasyLoading.showError('Something went wrong');
          }
        } else {
          // incorrect login details
          _setLoading(false);
          await logOut();
          EasyLoading.showError('Invalid Login Details, please try again.');
        }
      } else {
        // username does not exist
        _setLoading(false);
        await logOut();
        EasyLoading.showError(
            'No such account exists. Please check login details');

        //value does not exist
      }
    });
  }
}
