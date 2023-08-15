import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vexpense/models/expense_item.dart';
import 'package:vexpense/services/auth/auth_service.dart';

class FirebaseStorage {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;
  final AuthService _authService = AuthService();

  void saveData(List<ExpenseItem> allExpense) async {
    for (int i = 0; i < allExpense.length; i++) {
      await _firebaseFirestore
          .collection('Users')
          .doc(_authService.getUserId())
          .collection('Expenses')
          .add(allExpense[i].toMap());
    }
  }

  Future<List<ExpenseItem>> readData() async {
    List<ExpenseItem> list = [];

    Stream<QuerySnapshot> stream = _firebaseFirestore
        .collection('Users')
        .doc(_authService.getUserId())
        .collection('Expenses')
        .snapshots();

    stream.listen((snapshot) {
      for (var doc in snapshot.docs) {
        ExpenseItem expenseItem = ExpenseItem(
            name: doc['name'],
            amount: doc['amount'],
            dateTime: DateTime.fromMillisecondsSinceEpoch(
                doc['datetime'].seconds * 1000));
        list.add(expenseItem);
      }
    });
    return list;
  }
}
