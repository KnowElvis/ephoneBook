import 'package:ephonebook/features/user_auth/common/toast.dart';
import 'package:ephonebook/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:ephonebook/features/user_auth/presentation/pages/home.dart';
import 'package:ephonebook/features/user_auth/presentation/pages/login_page.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/circular.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:ephonebook/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.brown[100],
        appBar: AppBar(
          backgroundColor: Colors.brown[400],
          elevation: 0.0,
          title: const Text('SignUp To E-PhoneBook'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Text(
                  'SignUp',
                  style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                FormContainerWidget(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter your Username' : null,
                  controller: _usernameController,
                  hintText: 'Username',
                  isPasswordField: false,
                ),
                const SizedBox(height: 10),
                FormContainerWidget(
                  validator: (val) => val!.isEmpty ? 'Enter an Email' : null,
                  controller: _emailController,
                  hintText: 'Email',
                  isPasswordField: false,
                ),
                const SizedBox(height: 10),
                FormContainerWidget(
                  validator: (val) => val!.length < 6
                      ? 'Password should contain 6 or more characters'
                      : null,
                  controller: _passwordController,
                  hintText: 'Password',
                  isPasswordField: true,
                ),
                const SizedBox(height: 30),
                GestureDetector(
                  onTap: () {
                    _signUp();
                    if (_formkey.currentState!.validate()) {
                    } else {
                      return showToast(message: 'Form is Incomplete');
                    }
                  },
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.brown[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: loading
                            ? const Circular()
                            : const Text('SignUp',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20)),
                      )),
                ),
                const SizedBox(height: 20),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Text("Already have an account?"),
                  const SizedBox(width: 5),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginPage()),
                            (route) => false);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.blue),
                      )),
                  const SizedBox(height: 20),
                ]),
              ],
            ),
          ),
        ));
  }

  void _signUp() async {
    setState(() {
      loading = true;
    });

    // ignore: unused_local_variable
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    UserModel? user = await _auth.signUpWithEmailAndPassword(email, password);
    setState(() {
      loading = false;
    });

    if (user != null) {
      showToast(message: 'User has successfully Created');
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {
      showToast(message: 'Unable to Create Acoount');
    }
  }
}
