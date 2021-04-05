import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  List<Widget> buildDividedListTile(
      BuildContext context, IconData icon, String text, Function f) {
    return [
      Divider(),
      ListTile(
          leading: Icon(icon),
          title: Text(
            text,
            style: Theme.of(context).textTheme.headline2,
          ),
          onTap: f)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: <Widget>[
        AppBar(
          title: Text(
            'Educa',
            style: Theme.of(context)
                .textTheme
                .headline3
                .copyWith(color: Colors.white),
          ),
          automaticallyImplyLeading: false,
        ),
        ...buildDividedListTile(
          context,
          Icons.settings,
          'Configurações',
          null,
        ),
        Divider(),
        ListTile(
            leading: Icon(
              Icons.exit_to_app,
              color: Colors.red,
            ),
            title: Text(
              'Logout',
              style: Theme.of(context)
                  .textTheme
                  .headline2
                  .copyWith(color: Colors.red),
            ),
            onTap: () {
              FirebaseAuth.instance.signOut();
            })
      ],
    ));
  }
}
