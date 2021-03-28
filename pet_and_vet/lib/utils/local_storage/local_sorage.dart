import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pet_and_vet/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
SharedPreferences prefs;
  ///Write on Disk
  void saveLanguageToDisk(String language) async {
    await GetStorage().write('lang', language);
  }

  void saveUser(UserApp user) async {
    prefs =await SharedPreferences.getInstance();
    await prefs.setString('username', user.name);
    await prefs.setString('email', user.email);
    await prefs.setString('id', user.id);
    await prefs.commit();
  }

 void setLogin(bool isLogin) async {
    await GetStorage().write('isLogin', isLogin);
  }

void setFirstOpen(bool firstOpen) async {
    await GetStorage().write('isFirst', firstOpen);
  }

  ///Read from Disk
  Future<String> get languageSelected async {
    return await GetStorage().read('lang');
  }

  Future<UserApp> get user async {
    prefs =await SharedPreferences.getInstance();
    String username= prefs.getString('username');
    String email= prefs.getString('email');
    String id= prefs.getString('id');

    print('fghj : $username');
    return UserApp(email,username,id);
  }

  Future<bool> get isLogin async {
    return await GetStorage().read('isLogin');
  }

  Future<bool> get isFirstOpen async {
    return await GetStorage().read('isFirst');
  }


}
