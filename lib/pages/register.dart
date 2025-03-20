import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart'; // Import trang Login

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void register() async {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Vui lòng nhập đầy đủ thông tin!")),
      );
      return;
    }

    // Kiểm tra username đã tồn tại chưa
    QuerySnapshot userQuery = await _firestore
        .collection("users")
        .where("username", isEqualTo: username)
        .get();

    if (userQuery.docs.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Tên đăng nhập đã tồn tại!")),
      );
      return;
    }

    // Nếu chưa tồn tại, thêm vào Firestore
    await _firestore.collection("users").add({
      "username": username,
      "password": password,
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Đăng ký thành công! Vui lòng đăng nhập.")),
    );

    // Chuyển về LoginPage
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Đăng Ký")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: "Tên đăng nhập"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Mật khẩu"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: Text("Đăng Ký"),
            ),
            TextButton(
              onPressed: () {
                // Chuyển sang trang Login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              child: Text("Đã có tài khoản? Đăng nhập ngay"),
            ),
          ],
        ),
      ),
    );
  }
}
