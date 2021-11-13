import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/components/appbar/appbar_with_drawer.dart';
import 'package:flutter_architecture/core/views/drawer/drawer_view.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarWithDrawer(
        scaffoldKey: _scaffoldKey,
      ),
      drawer: DrawerView(),
      body: Center(
        child: Text('Home View'),
      ),
    );
  }
}
