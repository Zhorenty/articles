// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'user.dart';
import 'user_widget.dart';

class ObjectKeyPageExample extends StatefulWidget {
  const ObjectKeyPageExample({Key? key}) : super(key: key);

  @override
  State<ObjectKeyPageExample> createState() => _ObjectKeyPageExampleState();
}

class _ObjectKeyPageExampleState extends State<ObjectKeyPageExample> {
  late List<User> users;

  final someUser = User(name: 'someUser', country: 'someCountry');

  @override
  void initState() {
    super.initState();

    users = [
      someUser,
      User(name: 'someUser', country: 'someCountry'),
      User(name: 'Rayyan Markos', country: 'USA'),
      User(name: 'Rayyan Markos', country: 'USA'),
      User(name: 'Jonathan Vangelija', country: 'England'),
      User(name: 'Kehlani Kalyan', country: 'India')
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ObjectKey Example'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          // children: [
          //   Expanded(
          //     child: ListView.builder(
          //         physics: NeverScrollableScrollPhysics(),
          //         itemCount: users.length,
          //         itemBuilder: ((context, index) {
          //           return SizedBox(
          //               child: UserWidget(
          //             key: ObjectKey(users),
          //             user: users[index],
          //           ));
          //         })),
          //   )
          // ],
          children: users
              .map<Widget>((user) => UserWidget(
                    key: ObjectKey(user),
                    user: user,
                  ))
              .toList(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: swapTiles,
        child: const Icon(Icons.swap_horiz, size: 32),
      ),
    );
  }

  void swapTiles() {
    setState(() {
      final user = users.removeAt(0);
      users.insert(1, user);
    });
  }
}
