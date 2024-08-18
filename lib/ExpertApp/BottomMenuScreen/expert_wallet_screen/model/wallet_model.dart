// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);
import 'dart:convert';

class WalletTransactionModel {
  dynamic id;
  dynamic txn_id;
  dynamic payer_name;
  dynamic points;
  dynamic created_at;

  WalletTransactionModel(
      this.id,
      this.txn_id,
      this.payer_name,
      this.points,
      this.created_at,
      );
}