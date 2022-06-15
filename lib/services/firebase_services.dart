import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  static Future<DocumentSnapshot> getData() async {
    return await FirebaseFirestore.instance
        .collection('prompter_app')
        .doc('1EESEtyLtTy447I2qL8K')
        .get();
  }

  static Future<bool> updateTexts(List<dynamic> texts) async {
    await FirebaseFirestore.instance
        .collection('prompter_app')
        .doc('1EESEtyLtTy447I2qL8K')
        .update({'texts': texts}).whenComplete(() {
      return true;
    });
    return false;
  }

}
