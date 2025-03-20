import 'package:crud_gk/service/database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class Product extends StatefulWidget {
  const Product({super.key});

  @override
  State<Product> createState() => _ProductState();
}

class _ProductState extends State<Product> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController producttypecontroller = new TextEditingController();
  TextEditingController pricecontroller = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // căn chỉnh tiêu đề ở giữa
          children: [
            Text(
              "Thêm",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " món ăn",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Container(
        margin: EdgeInsets.only(left: 20.0, top: 30.0, right: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Name",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              // cai ni la khoang trang tinh tu ben trai qua roi den thong tin minh nhap ne
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: namecontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ), // mat cai duong vien
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              "Type",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              // cai ni la khoang trang tinh tu ben trai qua roi den thong tin minh nhap ne
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: producttypecontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ), // mat cai duong vien
              ),
            ),

            SizedBox(height: 20.0),
            Text(
              "Price",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10.0),
            Container(
              padding: EdgeInsets.only(left: 10),
              // cai ni la khoang trang tinh tu ben trai qua roi den thong tin minh nhap ne
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.circular(10),
              ),
              child: TextField(
                controller: pricecontroller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ), // mat cai duong vien
              ),
            ),
            SizedBox(height: 30.0),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  String Id = randomAlphaNumeric(10);
                  Map<String, dynamic> productInfoMap = {
                    "Id" : Id,
                    "Name": namecontroller.text,
                    "Type": producttypecontroller.text,
                    "Price": pricecontroller.text,
                  };
                  await DatabaseMethods().addProductDetails(productInfoMap, Id).then((value) {
                    Fluttertoast.showToast(
                        msg: "Đã tải thành công nhen...",
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  });
                },
                child: Text(
                  "Add",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
