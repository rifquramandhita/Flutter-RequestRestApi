import 'package:flutter/material.dart';
import 'package:request_api/models/users.dart';
import 'package:request_api/services/users_services.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List Users"),
      ),
      body: Padding(
        padding: EdgeInsetsDirectional.all(8),
        child: FutureBuilder<List<Users>>(
          future: Users_Services.fetchUsers(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SizedBox(
                      width: 200,
                      height: 200,
                      child: CircularProgressIndicator()));
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                final listUsers = snapshot.data;
                return ListView.builder(
                  itemCount: listUsers!.length,
                  itemBuilder: (context, index) {
                    final user = listUsers![index];
                    return ListTile(
                      title: Text("${user.firstName} ${user.lastName}"),
                      subtitle: Text(user.email),
                      leading: CircleAvatar(
                          backgroundImage: NetworkImage(user.avatar)),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error.toString()),
                );
              } else {
                return Text("");
              }
            } else {
              return Text("");
            }
          },
        ),
      ),
    );
  }
}
