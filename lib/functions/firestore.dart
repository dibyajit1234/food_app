import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final CollectionReference orders = (FirebaseFirestore.instance
    .collection('orders'));

  Future SaveOrderToDatabase(List<Map<String,dynamic>> reciept,) async {
    await orders.add({'order':reciept});
  }
}
