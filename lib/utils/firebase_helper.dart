import 'package:app_note/models/fb_response.dart';

mixin FirebaseHelper{
  FbResponse get successfullyResponse => FbResponse('Operation completed successfully', true);
  FbResponse get errorResponse => FbResponse('Operation failed ', false);
}