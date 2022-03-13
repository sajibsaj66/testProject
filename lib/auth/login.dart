import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_reg_project/Screens/home_page.dart';
import 'package:login_reg_project/shared/custom_text.dart';
import 'package:login_reg_project/shared/custom_textfield.dart';

class SignupPage extends StatelessWidget {
  SignupPage({Key? key}) : super(key: key);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Future<int> login(
      email,
      pass,
    ) async {
      Map data = {
        'email': emailController.text,
        'password': passwordController.text,
      };
      print(data);

      String body = json.encode(data);
      var url =
          'http://user-api-dev.london-design-studios.com//api/v1/users/login';
      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: {
          "Content-Type": "application/json",
          "accept": "application/json",
          "Access-Control-Allow-Origin": "*"
        },
      );

      return response.statusCode;

    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const CustomText(
          text: 'Log in Page',
          fontSize: 40,
        ),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              size: 20,
              color: Colors.black,
            )),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        CustomTextField(
                          textController: emailController,
                          hintText: 'Email',
                          textInputType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value != null ||
                                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(value!)) {
                              return 'Enter a valid email!';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          textController: passwordController,
                          hintText: 'password',
                          validator: (value) {
                            if (value != null) {
                              return 'Enter a valid password!';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: Container(
                      padding: const EdgeInsets.only(top: 3, left: 3),
                      child: MaterialButton(
                        minWidth: double.infinity,
                        height: 60,
                        onPressed: () async {
                          showLoaderDialog(context);
                          int statusCode = await login(
                            emailController.text,
                            passwordController.text,
                          );

                          Navigator.pop(context);
                          if (statusCode == 201) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()),
                            );
                          } else {
                            print('error');
                            ScaffoldMessenger.of(context).showSnackBar(snackBar(context));
                          }
                        },
                        color: Colors.redAccent,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40)),
                        child: const Text(
                          "Log in",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(
            strokeWidth: 2,
            color: Colors.teal,
          ),
          Container(
              margin: const EdgeInsets.only(left: 7),
              child: const Text("Log in Successfully")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }


  snackBar(BuildContext context){
    return SnackBar(
      content: const Text('Failed Log in!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
