import 'package:ephonebook/features/user_auth/firebase_auth_implementation/Firestore_database.dart';
import 'package:ephonebook/features/user_auth/presentation/widgets/form_container_widget.dart';
import 'package:ephonebook/models/users_model.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  final UsersModel user;
  const EditPage({required this.user, super.key});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController? _nameController;
  TextEditingController? _numberController;

  @override
  void initState() {
    _nameController = TextEditingController(text: widget.user.name);
    _numberController = TextEditingController(text: widget.user.phoneNumber);
    super.initState();
  }

  @override
  void dispose() {
    _nameController!.dispose();
    _numberController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        title: const Text('Edit E-PhoneBook'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            child: Column(
              children: [
                FormContainerWidget(
                  controller: _nameController,
                  hintText: 'Name',
                ),
                const SizedBox(height: 20),
                FormContainerWidget(
                    controller: _numberController, hintText: 'Phone Number'),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    FirestoreDatabase.update(UsersModel(
                        id: widget.user.id,
                        name: _nameController!.text,
                        phoneNumber: _numberController!.text));
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: double.infinity,
                      height: 50,
                      decoration: BoxDecoration(
                          color: Colors.brown[400],
                          borderRadius: BorderRadius.circular(10)),
                      child: const Center(
                        child: Text('Edit',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20)),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
