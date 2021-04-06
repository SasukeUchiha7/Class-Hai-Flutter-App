import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(''),
            decoration: BoxDecoration(
              image:
                  DecorationImage(image: AssetImage('assets/drawer-img.jpg')),
              color: Colors.cyan[900],
            ),
          ),
          ListTile(
            leading: Icon(Icons.home_outlined),
            title: Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.assessment_outlined),
            title: Text('Assignments'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings_outlined),
            title: Text('Settings'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: 40,
          ),
          Center(
              child: Text(
            'Version  1.1.0 ',
            style: TextStyle(color: Colors.grey[500]),
          )),
        ],
      ),
    );
  }
}
