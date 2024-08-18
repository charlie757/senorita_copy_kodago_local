// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class AllTransactionModel {
  dynamic id;
  dynamic payer_name;
  dynamic points;
  dynamic created_at;

  AllTransactionModel(
      this.id,
      this.payer_name,
      this.points,
      this.created_at,
      );
}