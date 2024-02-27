import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/global/global.dart';
import 'package:users/screens/login_screen.dart';

class ForgotPassworScreen extends StatefulWidget {
  const ForgotPassworScreen({super.key});

  @override
  State<ForgotPassworScreen> createState() => _ForgotPassworScreenState();
}

class _ForgotPassworScreenState extends State<ForgotPassworScreen> {

  final emailTextEditingController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _submit(){
    firebaseAuth.sendPasswordResetEmail(email: emailTextEditingController.text.trim()).then((value) {
      Fluttertoast.showToast(msg: "we have sent you an email to recover password,please check email");
    }).onError((error, stackTrace){
      Fluttertoast.showToast(msg: "error occured: \n ${error.toString()}");
    });
  }

  @override
  Widget build(BuildContext context) {

    bool darkTheme = MediaQuery.of(context).platformBrightness==Brightness.dark;

    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: ListView(
          children: [
            Column(
              children: [
                Image.asset('images/register1.png'),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Forgot Password",
                  style: TextStyle(
                      color: darkTheme ? Colors.amber.shade400 : Colors.blueAccent,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 20, 15, 50),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [

                        TextFormField(
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(100)
                          ],
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(color: Colors.grey),
                            filled: true,
                            fillColor: darkTheme
                                ? Colors.black45
                                : Colors.grey.shade200,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(40),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.person,
                              color: darkTheme
                                  ? Colors.amber.shade400
                                  : Colors.grey,
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Email can't be null";
                            }
                            if (EmailValidator.validate(text) == true) {
                              return null;
                            }
                            if (text.length < 2) {
                              return "Please enter valid Email";
                            }
                            if (text.length > 50) {
                              return "Please enter valid Email";
                            }
                          },
                          onChanged: (text) => setState(() {
                            emailTextEditingController.text = text;
                          }),
                        ),


                        SizedBox(
                          height: 5,
                        ),

                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                primary: darkTheme
                                    ? Colors.amber.shade400
                                    : Colors.blueAccent,
                                onPrimary:
                                darkTheme ? Colors.black : Colors.white,
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(32),
                                ),
                                minimumSize: Size(double.infinity, 50)),
                            onPressed: () {
                              _submit();
                            },
                            child: Text(
                              "Send Reset Password link",
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            "Forget Password",
                            style: TextStyle(
                              color: darkTheme
                                  ? Colors.amber.shade400
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Already have an account?",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context, MaterialPageRoute(builder: (c) => LoginScreen()));
                              },
                              child: Text(
                                "Login",
                                style: TextStyle(
                                    color: darkTheme
                                        ? Colors.amber.shade400
                                        : Colors.blue),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
