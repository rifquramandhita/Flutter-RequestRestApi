import 'package:flutter/material.dart';
import 'package:request_api/models/users.dart';
import 'package:request_api/services/users_services.dart';

class DetailUser extends StatefulWidget {
  final String id;

  const DetailUser({super.key, required this.id});

  @override
  State<DetailUser> createState() => _DetailUserState();
}

class _DetailUserState extends State<DetailUser> {
  late bool isLoading;
  late Users user;

  void fetchUserById() async {
    setState(() {
      isLoading = true;
    });
    user = await Users_Services.fetchUserById(widget.id);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchUserById();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail User"),
      ),
      body: isLoading
          ? Center(
              child: SizedBox(
                height: 200,
                width: 200,
                child: CircularProgressIndicator(),
              ),
            )
          : Column(
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircleAvatar(backgroundImage: NetworkImage(user.avatar)),
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.person),
                    label: Text("Name"),
                  ),
                  initialValue: "${user.firstName} ${user.lastName}",
                  readOnly: true,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.mail),
                    label: Text("Email"),
                  ),
                  initialValue: "${user.email}",
                  readOnly: true,
                )
              ],
            ),
    );
  }
}
