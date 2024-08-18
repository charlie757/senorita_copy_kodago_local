import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';


Future<http.Response> getLocationData(String text,context) async {
  String kPLACES_API_KEY = "AIzaSyAopcumfPIKkHn4Ym1z2AeU0RDEAAY0ZXo";
  String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  String request= "$baseURL?input=$text&key=$kPLACES_API_KEY";
  http.Response response;
  response = await http.get(Uri.parse(request), headers: {"Content-Type": "application/json"},);
  print(jsonDecode(response.body));
  /*if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    if (data['status'] == 'OK' && data['results'] != null && data['results'].isNotEmpty) {
      final location = data['results'][0]['geometry']['location'];
      final lat = location['lat'];
      final lng = location['lng'];

    } else {
      throw  Exception('Failed to fetch location details');
    }
  } else {
    throw Exception('Failed to load data');
  }*/
  return response;
}