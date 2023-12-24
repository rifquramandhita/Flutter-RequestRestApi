import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:request_api/models/users.dart';
import 'package:request_api/pages/create_user.dart';
import 'package:request_api/pages/detail_user.dart';
import 'package:request_api/pages/edit_user.dart';
import 'package:request_api/services/users_services.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({super.key});

  @override
  Widget build(BuildContext context) {
    final _key = GlobalKey<ExpandableFabState>();

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
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailUser(id: user.id.toString()),
                            ));
                      },
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
      floatingActionButtonLocation: ExpandableFab.location,
      floatingActionButton: ExpandableFab(
        key: _key,
        overlayStyle: ExpandableFabOverlayStyle(blur: 5.0),
        type: ExpandableFabType.up,
        children: [
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.edit),
            onPressed: () {
              _key.currentState?.toggle();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EditUser(),
                  ));
            },
          ),
          FloatingActionButton.small(
            heroTag: null,
            child: const Icon(Icons.add),
            onPressed: () {
              _key.currentState?.toggle();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CreateUser(),
                  ));
            },
          ),
        ],
      ),
    );
  }
}
