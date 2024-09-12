import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:recipe_app/models/UserManagement/userAuthentication.dart';

import '../models/UserManagement/userRegistration.dart';
import '../services/UserServices/AuthService.dart';
import '../services/UserServices/Registration.dart';

class UserProvider extends ChangeNotifier{

  final AuthService _authService = AuthService();
  final RegistrationService _registrationService = RegistrationService();
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  String? _token;
  bool _isAuthenticated = false;

  String? get token => _token;
  bool get isAuthenticated => _isAuthenticated;

  AuthProvider(){
    _loadToken();
  }

  Future<void> _loadToken() async {
    _token = await _secureStorage.read(key: 'authToken');
    if(_token !=null && !_authService.isTokenExpired(_token!)){
      _isAuthenticated = true;
    }else{
      _token = null;
      _isAuthenticated = false;
    }
    notifyListeners();
  }

  Future<void> login(UserAuthentication userAuth) async{
    final response = await _authService.login(userAuth);
    if(response.statusCode == 200){
      _token = await _secureStorage.read(key: 'authToken');
      print(_token);
      _isAuthenticated = true;
      notifyListeners();
    }
  }

  Future<void> logout() async{
    await _authService.logout();
    _token = null;
    _isAuthenticated = false;
    notifyListeners();
  }

  Future<bool> signUp(UserRegistration userRegistration, BuildContext context) async{
    try{
      final response = await _registrationService.register(
          userRegistration.firstName,
          userRegistration.lastName,
          userRegistration.email,
          userRegistration.password
      );
      if(response.statusCode == 201 || response.statusCode == 200){
        print("Registered successfully");
        return true;
      }else if(response.statusCode == 409){
        _isAuthenticated = false;
        print('Email already exists');
        return false;
      }else{
        _isAuthenticated = false;
        return false;
      }
    }catch(e){
      _isAuthenticated = false;
      print("Error during sign up : $e");
      return false;
    }finally{
      notifyListeners();
    }
  }



}