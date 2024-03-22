import 'package:ephonebook/features/user_auth/presentation/pages/login_page.dart';
import 'package:ephonebook/features/user_auth/presentation/pages/contact_list.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:ephonebook/models/users_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../firebase_auth_implementation/Firestore_database.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  String name = '';
  String number = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        title: const Text('E-PhoneBook'),
        actions: [
          ElevatedButton.icon(
              style:
                  ElevatedButton.styleFrom(backgroundColor: Colors.brown[50]),
              onPressed: () {
                FirebaseAuth.instance.signOut();

                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                    (route) => false);
              },
              icon: const Icon(
                Icons.person,
                color: Colors.black,
              ),
              label: const Text(
                'Log Out',
                style: TextStyle(color: Colors.black),
              ))
        ],
      ),
      body: const ContactList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _bottomSheet(),
        backgroundColor: Colors.brown[400],
        child: const Icon(Icons.add),
      ),
    );
  }

// ModalBottomSheet
  _bottomSheet() {
    showModalBottomSheet(
        backgroundColor: Colors.brown[100],
        enableDrag: true,
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: MediaQuery.of(context).size.height / 2,
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 0.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FormContainerWidget(
                    hintText: 'Name',
                    controller: _nameController,
                    isPasswordField: false,
                    onChanged: (val) {
                      setState(() => name = val);
                    },
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r'^[a-z A-Z]+$').hasMatch(value)) {
                        return 'Énter a valid Name';
                      } else {
                        return null;
                      }
                    },
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 10),
                  FormContainerWidget(
                    hintText: 'PhoneNumber',
                    controller: _numberController,
                    onChanged: (val) {
                      setState(() => number = val);
                    },
                    isPasswordField: false,
                    validator: (number) => number!.length < 11
                        ? 'Number should be 11 characters'
                        : null,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      _addUser();
                      Navigator.pop(context);
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _nameController.clear();
                          _numberController.clear();
                        });
                      } else {}
                    },
                    child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                            color: Colors.brown[400],
                            borderRadius: BorderRadius.circular(10)),
                        child: const Center(
                          child: Text('Input',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20)),
                        )),
                  ),
                ],
              ),
            ),
          );
        });
  }

  _addUser() {
    FirestoreDatabase.create(UsersModel(
        name: _nameController.text, phoneNumber: _numberController.text));
  }
}
