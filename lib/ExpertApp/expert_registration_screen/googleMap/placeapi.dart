import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

Future<http.Response> getLocationData(String text) async {

  String kPLACES_API_KEY = "AIzaSyAopcumfPIKkHn4Ym1z2AeU0RDEAAY0ZXo";
  String baseURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json";
  String request= "$baseURL?input=$text&key=$kPLACES_API_KEY";
  http.Response response;

  response = await http.get(
    Uri.parse(request),
    headers: {"Content-Type": "application/json"},);

  print(jsonDecode(response.body));
  return response;
}