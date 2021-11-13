import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/appbar/appbar_with_drawer.dart';
import 'package:flutter_architecture/core/views/drawer/drawer_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWithDrawer(
        scaffoldKey: _scaffoldKey,
        title: 'Profile',
      ),
      drawer: DrawerView(),
      body: Center(
        child: Text('Profile View'),
      ),
    );
  }
}
