import 'package:ephonebook/features/user_auth/common/toast.dart';
import 'package:ephonebook/features/user_auth/firebase_auth_implementation/firebase_auth_services.dart';
import 'package:ephonebook/features/user_auth/presentation/pages/signup_page.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/circular.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:ephonebook/features/user_auth/presentation/pages/home.dart';
import 'package:ephonebook/models/user_model.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
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
          title: const Text('Login To E-PhoneBook'),
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(30, 200, 30, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Text(
                'Login',
                style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              FormContainerWidget(
                controller: _emailController,
                hintText: 'Email',
                isPasswordField: false,
              ),
              const SizedBox(height: 10),
              FormContainerWidget(
                controller: _passwordController,
                hintText: 'Password',
                isPasswordField: true,
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: _signIn,
                child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.brown[400],
                        borderRadius: BorderRadius.circular(10)),
                    child: Center(
                      child: loading
                          ? const Circular()
                          : const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                const Text("Don't have an account?"),
                const SizedBox(width: 5),
                GestureDetector(
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SignUpPage()),
                          (route) => false);
                    },
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ))
              ]),
            ],
          ),
        ));
  }

  void _signIn() async {
    setState(() {
      loading = true;
    });

    String email = _emailController.text;
    String password = _passwordController.text;

    UserModel? user = await _auth.signInWithEmailAndPassword(email, password);

    setState(() {
      loading = false;
    });

    if (user != null) {
      showToast(message: 'User is successfully Login');
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false);
    } else {}
  }
}
