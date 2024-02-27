import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:users/screens/forgot_password.dart';

import '../global/global.dart';
import 'main_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final emailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  bool _visiblePassword = false;

  final _formKey = GlobalKey<FormState>();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      await firebaseAuth
          .signInWithEmailAndPassword(
          email: emailTextEditingController.text.trim(),
          password: passwordTextEditingController.text.trim())
          .then((auth) async {
        currentUser = auth.user;

        await Fluttertoast.showToast(msg: "Successfully Logged In");
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      }).catchError((errorMessage) {
        Fluttertoast.showToast(msg: "Error Occured \n $errorMessage");
      });
    }
    Fluttertoast.showToast(msg: "Not all fields are valid");
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
                  "Login",
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
                        TextFormField(
                          obscureText: !_visiblePassword,
                          inputFormatters: [
                            LengthLimitingTextInputFormatter(50)
                          ],
                          decoration: InputDecoration(
                              hintText: "Password",
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
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _visiblePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: darkTheme
                                      ? Colors.amber.shade400
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _visiblePassword = !_visiblePassword;
                                  });
                                },
                              )),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return "Password can't be null";
                            }
                            if (text.length < 6) {
                              return "Please enter valid Password";
                            }
                            if (text.length > 49) {
                              return "Please enter valid Password";
                            }
                            return null;
                          },
                          onChanged: (text) => setState(() {
                            passwordTextEditingController.text = text;
                          }),
                        ),

                        SizedBox(
                          height: 20,
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
                              "Login",
                              style: TextStyle(fontSize: 20),
                            )),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context, MaterialPageRoute(builder: (c) => ForgotPassworScreen()));
                          },
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
                              "Doesn't Have an account?",
                              style:
                              TextStyle(color: Colors.grey, fontSize: 15),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                "Register",
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
