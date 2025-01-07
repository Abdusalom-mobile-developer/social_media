import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String formatTimestamp(Timestamp timestamp) {
  DateTime dateTime = timestamp.toDate();

  String formattedDate = DateFormat('MMM d, yyyy').format(dateTime);

  return formattedDate;
}