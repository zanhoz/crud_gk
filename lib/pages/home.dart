import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud_gk/pages/employee.dart';
import 'package:crud_gk/service/database.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController namecontroller = new TextEditingController();
  TextEditingController agecontroller = new TextEditingController();
  TextEditingController locationcontroller = new TextEditingController();
  Stream? EmployeeStream;

  getontheload() async{
    EmployeeStream = await DatabaseMethods().getEmployeeDetails();
    setState(() {

    });
  }
  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allEmployeeDetails() {
    return StreamBuilder(
      stream: EmployeeStream,
      builder: (context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot ds = snapshot.data.docs[index];
                return Container(
                  margin: EdgeInsets.only(bottom: 20.0),
                  child: Material(
                    elevation: 5.0,
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      padding: EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(

                            children: [
                              Text(
                                "Name: " +ds["Name"],
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: (){
                                    namecontroller.text=ds["Name"];
                                    agecontroller.text = ds["Age"];
                                    locationcontroller.text= ds["Location"];
                                    EditEmployeeDetail(ds["Id"]);
                                  },
                                  child: Icon(Icons.edit, color: Colors.red,)),
                                  SizedBox(width: 5.0,),
                                  GestureDetector(
                                    onTap: () async{
                                      await DatabaseMethods().deleteEmployeeDetail(ds["Id"]);

                                    },
                                      child: Icon(Icons.delete, color: Colors.red,))
                            ],
                          ),
                          Text(
                            "Age: "+ds["Age"],
                            style: TextStyle(
                              color: Colors.yellow,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Location: "+ds["Location"],
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            )
            : Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Employee()),
          ); // bam vao + de qua trang moi
        },
        child: Icon(Icons.add),
      ), // thêm icon add
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          // căn chỉnh tiêu đề ở giữa
          children: [
            Text(
              "Chào Admin ",
              style: TextStyle(
                color: Colors.blue,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              " Văn Học",
              style: TextStyle(
                color: Colors.red,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      // hien thi o trang chu
      body: Container(
        margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
        child: Column(
          children: [
           Expanded(child: allEmployeeDetails()),
          ],
        ),
      ),
    );
  }
  Future EditEmployeeDetail(String id) => showDialog(context: context, builder: (context)=> AlertDialog(
    content: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           Row(children: [
             GestureDetector(
               onTap: () {
                 Navigator.pop(context);
               },
                 child: Icon(Icons.cancel)),
             SizedBox(width: 60.0,),
             Text(
               "Edit ",
               style: TextStyle(
                 color: Colors.blue,
                 fontSize: 24.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
             Text(
               " detail",
               style: TextStyle(
                 color: Colors.red,
                 fontSize: 20.0,
                 fontWeight: FontWeight.bold,
               ),
             ),
           ],),
          SizedBox(height: 20.0,),
          Text(
            "Name",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
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
            "Age",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
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
              controller: agecontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
              ), // mat cai duong vien
            ),
          ),

          SizedBox(height: 20.0),
          Text(
            "Location",
            style: TextStyle(
              color: Colors.black,
              fontSize: 20.0,
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
              controller: locationcontroller,
              decoration: InputDecoration(
                border: InputBorder.none,
              ), // mat cai duong vien
            ),
          ),
          SizedBox(height: 30.0,),
          Center(child: ElevatedButton(onPressed: () async {
            Map<String, dynamic>updateInfo= {
              "Id": id,
              "Name": namecontroller.text,
              "Age" : agecontroller.text,
              "Location" : locationcontroller.text,
            };
            await DatabaseMethods().updateEmployeeDetail(id, updateInfo).then((value){
              Navigator.pop(context);
            });

          }, child: Text("Update")))
        ],),
    ),
  ));
}
