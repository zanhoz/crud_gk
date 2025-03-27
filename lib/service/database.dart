import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addProductDetails(Map<String, dynamic> employeeInfoMap,
      String id,) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .set(employeeInfoMap);
  }
  Future<Stream<QuerySnapshot>> getProductDetails() async { // Strem no tra ve luong dl thoi gian thuc
    return await FirebaseFirestore.instance.collection("Product").snapshots();
  }

  Future updateProductDetails(String id,
      Map<String, dynamic> updateInfo,) async {
    return await FirebaseFirestore.instance
        .collection("Product")
        .doc(id)
        .update(updateInfo);
  }

  Future deleteProductDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection("Product") // Đảm bảo tên collection chính xác
        .doc(id)
        .delete();
  }
}