import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:mvvm_theme_switching/repository/remote/auth_repository.dart';
import 'package:mvvm_theme_switching/utils/routes/routes_name.dart';
import 'package:mvvm_theme_switching/utils/utils.dart';

class AuthViewModel with ChangeNotifier{
  final _authRepo = AuthRepository();
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  setLoading(value){
    _isLoading = value;
    notifyListeners();
  }

  String getUserUid(){
    return _authRepo.userUid();
  }

  registerUser({required BuildContext context, required String email, required String password}){
    setLoading(true);
    _authRepo.registerUser(email: email, password: password)
        .then((value) {
      setLoading(false);

      Navigator.pushNamedAndRemoveUntil(context, RoutesName.demo, (route) => false,);
      // Utils.flushBarSuccessMessage("Welcome Foodie", context);
    })
        .onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  loginUser({required BuildContext context, required String email, required String password}){
    setLoading(true);

    _authRepo.loginUser(email: email, password: password)
        .then((value) {
      setLoading(false);
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.demo, (route) => false,);
      // Utils.flushBarSuccessMessage("Welcome Foodie", context);
    })
        .onError((error, stackTrace) {
      setLoading(false);
      Utils.flushBarErrorMessage(error.toString(), context);
    });
  }

  signOutUser({required BuildContext context}){
    _authRepo.logoutUser().then((value) {
      Navigator.pushNamedAndRemoveUntil(context, RoutesName.login, (route) => false,);
      // Utils.flushBarSuccessMessage("Logout successfully", context);
    }).onError((error, stackTrace) {
      Utils.flushBarSuccessMessage("Logout Failed", context);
    });
  }
  bool checkIsUserLoggedIn(){
    return  _authRepo.isUserLoggedIn();
  }

}