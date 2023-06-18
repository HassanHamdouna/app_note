import 'package:app_note/pref/shared_Controller.dart';
import 'package:flutter/cupertino.dart';

class LanguageProvider extends ChangeNotifier{
  String language = SharedController().getValueFor<String>(PrefKey.lagCode.name)??'en';

  void changeLanguage(){
    language= language==  'en' ? 'ar' : 'en';
    SharedController().changeLanguage(lang: language);
    notifyListeners();
  }
}