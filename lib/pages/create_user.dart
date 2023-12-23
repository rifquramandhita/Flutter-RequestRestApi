import 'package:flutter/material.dart';
import 'package:request_api/services/users_services.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final _controllerName = TextEditingController();
  final _controllerJob = TextEditingController();
  bool isLoading = false;
  late bool isSuccess;

  void createUser() async {
    setState(() {
      isLoading = true;
    });
    final userCreated = await Users_Services.createUser(
        _controllerName.text, _controllerJob.text);

    showDialog(
      context: context,
      useRootNavigator: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Success"),
          content: Text("User ${userCreated.name} created"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text("Close"))
          ],
        );
      },
    );

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Create User"),
        ),
        body: isLoading
            ? Center(
                child: Container(
                  height: 200,
                  width: 200,
                  child: CircularProgressIndicator(),
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'What do people call you?',
                      labelText: 'Name',
                    ),
                    controller: _controllerName,
                  ),
                  TextFormField(
                    autovalidateMode: AutovalidateMode.always,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.location_city),
                      hintText: 'What are you doing every day?',
                      labelText: 'Job',
                    ),
                    controller: _controllerJob,
                  ),
                  SizedBox(
                    height: 40.0,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        createUser();
                      },
                      icon: Icon(Icons.send),
                      label: Text("Submit"))
                ],
              ));
  }
}
