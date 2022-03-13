import 'package:flutter/material.dart';
import 'package:login_reg_project/shared/custom_text.dart';
import 'auth/login.dart';
import 'auth/sign_up_first_step.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.teal,
        title: const Text("Sign In "),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  CustomText(
                    text: 'Welcome to Our App',
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  CustomText(
                    text:
                        'Automatic identity verification which enable you to verify your identity',
                    fontSize: 15,
                    textAlign: TextAlign.center,
                    color: Colors.grey,
                  ),
                ],
              ),
              Expanded(child: Container()),
              logInButton(context),
              const SizedBox(
                height: 20,
              ),
              signUpButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget logInButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const SignUpFirstStep()),
        );
      },
      color: Colors.indigoAccent[400],
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: const CustomText(
        text: 'Sign Up',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
        color: Colors.white,
      ),
    );
  }

  Widget signUpButton(BuildContext context) {
    return MaterialButton(
      minWidth: double.infinity,
      height: 60,
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  SignupPage()),
        );
      },
      color: Colors.redAccent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      child: const CustomText(
        text: 'Login',
        fontSize: 16,
        fontWeight: FontWeight.w600,
        textAlign: TextAlign.center,
        color: Colors.white,
      ),
    );
  }
}
