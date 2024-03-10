import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/global/global.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  final nameTextEdittingController = TextEditingController();
  final phoneTextEdittingController = TextEditingController();
  final addressTextEdittingController = TextEditingController();

  DatabaseReference userRef = FirebaseDatabase.instance.ref().child("users");

  Future<void>  showUserNameDialgAlert(BuildContext context, String name){

    nameTextEdittingController.text = name;

    return showDialog(context: context,
      builder: (context){
      return AlertDialog(
        title: Text("Update"),
        content: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                controller: nameTextEdittingController,
              )
            ],
          ),
        ),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          },
              child: Text("Cancel", style:  TextStyle(color: Colors.red),)
          ),
          TextButton(onPressed: (){
            userRef.child(firebaseAuth.currentUser!.uid).update({
              "name" : nameTextEdittingController.text.trim(),
            }).then((value){
              nameTextEdittingController.clear();
              Fluttertoast.showToast(msg: "Updated Succesfully, \n Relod the app to see the changes");
            }).catchError((errorMessage) {
              Fluttertoast.showToast(msg: "Error Occured, \n $errorMessage");
            });
            Navigator.pop(context);
          },
              child: Text("Ok", style:  TextStyle(color: Colors.black),)
          ),

        ],
      );
      }

    );

  }

  Future<void>  showUserPhoneDialgAlert(BuildContext context, String phone){

    phoneTextEdittingController.text = phone;

    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Update"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: phoneTextEdittingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text("Cancel", style:  TextStyle(color: Colors.red),)
              ),
              TextButton(onPressed: (){
                userRef.child(firebaseAuth.currentUser!.uid).update({
                  "phone" : phoneTextEdittingController.text.trim(),
                }).then((value){
                  phoneTextEdittingController.clear();
                  Fluttertoast.showToast(msg: "Updated Succesfully, \n Relod the app to see the changes");
                }).catchError((errorMessage) {
                  Fluttertoast.showToast(msg: "Error Occured, \n $errorMessage");
                });
                Navigator.pop(context);
              },
                  child: Text("Ok", style:  TextStyle(color: Colors.black),)
              ),

            ],
          );
        }

    );

  }

  Future<void>  showUserAddressDialgAlert(BuildContext context, String adress){

    addressTextEdittingController.text = adress;

    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Update"),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  TextFormField(
                    controller: addressTextEdittingController,
                  )
                ],
              ),
            ),
            actions: [
              TextButton(onPressed: (){
                Navigator.pop(context);
              },
                  child: Text("Cancel", style:  TextStyle(color: Colors.red),)
              ),
              TextButton(onPressed: (){
                userRef.child(firebaseAuth.currentUser!.uid).update({
                  "address" : addressTextEdittingController.text.trim(),
                }).then((value){
                  addressTextEdittingController.clear();
                  Fluttertoast.showToast(msg: "Updated Succesfully, \n Relod the app to see the changes");
                }).catchError((errorMessage) {
                  Fluttertoast.showToast(msg: "Error Occured, \n $errorMessage");
                });
                Navigator.pop(context);
              },
                  child: Text("Ok", style:  TextStyle(color: Colors.black),)
              ),

            ],
          );
        }

    );

  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
          ),
          title: Text("Profile Screen", style:  TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
          centerTitle: true,
          elevation: 0.0,
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 50),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(50),
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    shape: BoxShape.circle,
                  ),
                  child:  Icon(Icons.person, color: Colors.white,),
                ),

                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${userModelCurrentInfo!.name!}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(onPressed:(){
                      showUserNameDialgAlert(context, userModelCurrentInfo!.name!);
                    },
                      icon:Icon(
                        Icons.edit,
                      ),
                    ),

                  ],
                ),

                Divider(
                  thickness: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${userModelCurrentInfo!.phone!}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(onPressed:(){
                      showUserPhoneDialgAlert(context, userModelCurrentInfo!.phone!);
                    },
                      icon:Icon(
                        Icons.edit,
                      ),
                    ),

                  ],
                ),

                Divider(
                  thickness: 1,
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${userModelCurrentInfo!.address!}",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(onPressed:(){
                      showUserAddressDialgAlert(context, userModelCurrentInfo!.address!);
                    },
                      icon:Icon(
                        Icons.edit,
                      ),
                    ),

                  ],
                ),

                Divider(
                  thickness: 1,
                ),

                Text("${userModelCurrentInfo!.email!}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
