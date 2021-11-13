import 'package:flutter/material.dart';
import 'package:flutter_architecture/constants/navigation_constants.dart';
import 'package:flutter_architecture/core/init/navigation/navigation_service.dart';

class OnboardView extends StatefulWidget {
  const OnboardView({Key? key}) : super(key: key);

  @override
  _OnboardViewState createState() => _OnboardViewState();
}

class _OnboardViewState extends State<OnboardView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TextButton(
          onPressed: () {
            NavigationService.instance.navigateToPageClear(path: NavigationConstants.mainView);
          },
          child: Text('Complate'),
        ),
      ),
    );
  }
}
