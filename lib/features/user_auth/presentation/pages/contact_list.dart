import 'package:ephonebook/features/user_auth/presentation/pages/edit_page.dart';
import 'package:ephonebook/models/users_model.dart';
import 'package:flutter/material.dart';
import '../../firebase_auth_implementation/Firestore_database.dart';

class ContactList extends StatefulWidget {
  const ContactList({super.key});

  @override
  State<ContactList> createState() => _ContactListState();
}

class _ContactListState extends State<ContactList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[100],
      body: StreamBuilder<List<UsersModel>>(
        stream: FirestoreDatabase.read(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Connection Error'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: Text('Loading....'));
          }
          final docs = snapshot.data;
          return Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
            child: ListView.builder(
                itemCount: docs!.length,
                itemBuilder: (context, index) {
                  final singleUser = docs[index];
                  return Column(
                    children: [
                      const SizedBox(height: 20),
                      ListTile(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          tileColor: Colors.white,
                          title: Text('${singleUser.name}'),
                          subtitle: Text('${singleUser.phoneNumber}'),
                          leading: CircleAvatar(
                              backgroundColor: Colors.brown[300],
                              child: const Icon(
                                Icons.person_outline_sharp,
                                color: Colors.black,
                              )),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => EditPage(
                                              user: UsersModel(
                                                  name: singleUser.name,
                                                  phoneNumber:
                                                      singleUser.phoneNumber,
                                                  id: singleUser.id))));
                                },
                                icon: const Icon(
                                  Icons.edit_outlined,
                                  color: Colors.black,
                                ),
                              ),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            title: const Text('Delete'),
                                            content: const Text(
                                                'Are you sure you want to delete this contact'),
                                            actions: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text('No',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .black))),
                                                  ElevatedButton(
                                                      onPressed: () {
                                                        FirestoreDatabase.delete(UsersModel(id:
                                                        singleUser.id));
                                                        Navigator.pop(context);
                                                      },
                                                      child: const Text(
                                                        'Delete',
                                                        style: TextStyle(
                                                            color: Colors.red),
                                                      ))
                                                ],
                                              )
                                            ],
                                          );
                                        });
                                  },
                                  icon: const Icon(
                                      Icons.delete_outline_outlined,
                                      color: Colors.red)),
                            ],
                          )),
                    ],
                  );
                }),
          );
        },
      ),
    );
  }
  // _delete(UserModel user){
  //   var collection = FirebaseFirestore.instance.collection('user');
  //    //collection.doc(user.id).delete();
  //   collection.doc(user.uid).delete();
  //
  // }
}
