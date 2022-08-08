import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  static const routeName = '/users';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Users'),
      ),
    );
  }
}
