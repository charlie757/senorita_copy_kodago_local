import 'package:shared_preferences/shared_preferences.dart';
import '../utils/stringConstants.dart';

setAuthToken(value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(authToken, value);
}
