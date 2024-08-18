// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class TransactionModel {
  dynamic id;
  dynamic payer_name;
  dynamic points;
  dynamic remark;
  dynamic txn_status;
  dynamic created_at;

  TransactionModel(
      this.id,
      this.payer_name,
      this.points,
      this.remark,
      this.txn_status,
      this.created_at,



      );
}