import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:login_reg_project/shared/custom_text.dart';
import 'package:login_reg_project/shared/custom_textfield.dart';

class SignUpSecondStep extends StatefulWidget {
  const SignUpSecondStep({Key? key}) : super(key: key);

  @override
  _SignUpSecondStepState createState() => _SignUpSecondStepState();
}

class _SignUpSecondStepState extends State<SignUpSecondStep> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final countryCodeController = TextEditingController();
  final otpPhoneCodeController = TextEditingController();
  final otpEmailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  Future<int> registerSecondStep(
      String name, email, phone, pass, country, otpEmail, otpPhone) async {
    Map data = {
      'name': nameController.text,
      'email': emailController.text,
      'phoneNumber': phoneController.text,
      'password': passwordController.text,
      'countryCode': countryCodeController.text,
      'otpNumberForEmail': otpEmailController.text,
      'otpNumberForPhone': otpPhoneCodeController.text,
    };
    print(data);

    String body = json.encode(data);
    var url =
        'http://user-api-dev.london-design-studios.com/api/v1/users/register';
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
      appBar: AppBar(
        title: const CustomText(
          text: 'Second  Step Registration',
        ),
        backgroundColor: Colors.teal,
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 100,
                ),
                const CustomText(
                  text: 'Sign Up Page second',
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomTextField(
                  textController: nameController,
                  hintText: 'Name',
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
                  validator: (value) {
                    if (value != null) {
                      return 'Enter a valid password!';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textController: countryCodeController,
                  hintText: 'Country Code',
                  validator: (value) {
                    if (value != null) {
                      return 'Enter a valid Country Code';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textController: otpEmailController,
                  hintText: 'otp Email',
                  validator: (value) {
                    if (value != null) {
                      return 'Enter a valid otp Email';
                    }
                    return null;
                  },
                ),
                CustomTextField(
                  textController: otpPhoneCodeController,
                  hintText: 'otp Phone',
                  validator: (value) {
                    if (value != null) {
                      return 'Enter a valid otp Phone';
                    }
                    return null;
                  },
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
                        int statusCode = await registerSecondStep(
                          nameController.text,
                          emailController.text,
                          phoneController.text,
                          passwordController.text,
                          countryCodeController.text,
                          otpPhoneCodeController.text,
                          otpEmailController.text,
                        );

                        print('statusCode ${statusCode}');

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
                        text: 'Sign Up',
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        textAlign: TextAlign.center,
                        color: Colors.white,
                      ),
                    ),
                  ),
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
              child: const Text("Sign Up Successfully...")),
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
      content: const Text('Failed Sign UP!'),
      action: SnackBarAction(
        label: 'Undo',
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
