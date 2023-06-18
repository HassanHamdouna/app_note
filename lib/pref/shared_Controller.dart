import 'package:shared_preferences/shared_preferences.dart';
enum PrefKey{lagCode,}
class SharedController  {

  SharedController._();

  late SharedPreferences _sharedPreferences;

  static SharedController? _instance;

  factory SharedController(){
    return _instance??= SharedController._();
  }

  Future<void> initSharedPref() async{
    _sharedPreferences = await SharedPreferences.getInstance();
  }
  T? getValueFor<T>(String key){
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.get(key) as T;
    }
    return null;
  }

  void clear(){
    _sharedPreferences.clear();
  }

  Future<bool> removeValueFor(String key) async{
    if(_sharedPreferences.containsKey(key)){
      return _sharedPreferences.remove(key);
    }
    return false;
  }

  void changeLanguage({required String lang}){
    _sharedPreferences.setString(PrefKey.lagCode.name, lang);
  }
}
