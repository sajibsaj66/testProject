import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:login_reg_project/auth/sign_up_2nd_Step.dart';
import 'package:login_reg_project/shared/custom_text.dart';
import 'package:login_reg_project/shared/custom_textfield.dart';
import 'package:http/http.dart' as http;

class SignUpFirstStep extends StatefulWidget {
  const SignUpFirstStep({Key? key}) : super(key: key);

  @override
  State<SignUpFirstStep> createState() => _SignUpFirstStepState();
}

class _SignUpFirstStepState extends State<SignUpFirstStep> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryCodeController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


  Future<int> registerFirstStep(
    String name,
    email,
    phone,
    pass,
    country,
  ) async {
    Map data = {
      'name': nameController.text,
      'email': emailController.text,
      'phoneNumber': phoneController.text,
      'password': passwordController.text,
      'countryCode': countryCodeController.text,
    };

    String body = json.encode(data);
    var url =
        'http://user-api-dev.london-design-studios.com/api/v1/otps/register/send';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: const CustomText(
          text: 'Registration From Part One',
        ),
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.only(top: 28.0),
                  child: CustomText(
                    text: 'Sign Up Page First',
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Column(
                    children: [
                      CustomTextField(
                        textController: nameController,
                        hintText: 'Name',
                        onChanged: (text) {},
                        validator: (value) {
                          if (value != null) {
                            return 'Enter a Name';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textController: emailController,
                        hintText: 'Email',
                        textInputType: TextInputType.emailAddress,
                        onChanged: (text) {},
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
                        textController: phoneController,
                        hintText: 'Phone Number',
                        textInputType: TextInputType.phone,
                        onChanged: (text) {},
                        validator: (value) {
                          if (value != null) {
                            return 'Enter a Phone Number';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textController: passwordController,
                        hintText: 'Password',
                        onChanged: (text) {},
                        validator: (value) {
                          if (value != null) {
                            return 'Password must be atlas 8 characters long and First characters must Capital';
                          }
                          return null;
                        },
                      ),
                      CustomTextField(
                        textController: countryCodeController,
                        hintText: 'Country Code',
                        onChanged: (text) {},
                        validator: (value) {
                          if (value != null) {
                            return 'Enter a Country Code';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Container(
                    padding: const EdgeInsets.only(top: 3, left: 3),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () async {
                        showLoaderDialog(context);
                        int statusCode = await registerFirstStep(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          passwordController.text,
                          countryCodeController.text,
                        );

                        Navigator.pop(context);
                        if (statusCode == 201) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignUpSecondStep()),
                          );
                        } else {
                          print('error');
                          ScaffoldMessenger.of(context).showSnackBar(snackBar());
                        }
                      },
                      color: Colors.indigoAccent[400],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)),
                      child: const CustomText(
                        text: 'Sign Up First',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        color: Colors.white,
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
              child: const Text("Sign Up is Processing...")),
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

  snackBar(){
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
