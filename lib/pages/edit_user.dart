import 'package:flutter/material.dart';
import 'package:request_api/models/response/update_user_response.dart';
import 'package:request_api/services/users_services.dart';

class EditUser extends StatefulWidget {
  const EditUser({super.key});

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  late bool isLoading;
  late UpdateUserResponse user;

  final _controllerId = TextEditingController();
  final _controllerName = TextEditingController();
  final _controllerJob = TextEditingController();

  void updateUserById() async {
    setState(() {
      isLoading = true;
    });
    user = await Users_Services.updateUser(
        _controllerId.text, _controllerName.text, _controllerJob.text);
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Sukses"),
        content: Text("update at ${user.updatedAt}"),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text("Close"))
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit User"),
      ),
      body: (isLoading)
          ? Center(
              child: SizedBox(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration:
                      InputDecoration(label: Text("Id"), icon: Icon(Icons.key)),
                  controller: _controllerId,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text("Name"), icon: Icon(Icons.person)),
                  controller: _controllerName,
                ),
                TextFormField(
                  decoration: InputDecoration(
                      label: Text("Job"), icon: Icon(Icons.location_city)),
                  controller: _controllerJob,
                ),
                SizedBox(
                  height: 50,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      updateUserById();
                    },
                    icon: Icon(Icons.send),
                    label: Text("Send"))
              ],
            ),
    );
  }
}
