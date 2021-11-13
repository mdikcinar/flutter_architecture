import 'package:flutter/material.dart';
import 'package:flutter_architecture/core/base/state/base_state.dart';
import 'package:flutter_architecture/core/base/view/base_view.dart';
import 'package:flutter_architecture/core/extensions/context_extension.dart';
import 'package:flutter_architecture/core/extensions/string_extension.dart';
import 'package:flutter_architecture/core/init/language/locale_keys.g.dart';
import 'package:flutter_architecture/view/main/viewmodel/main_viewmodel.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends BaseState<MainView> {
  late MainViewModel mainViewModel;
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModel: MainViewModel(),
      onModelReady: (model) => mainViewModel = model as MainViewModel,
      onPageBuilder: (context, value) {
        return Observer(builder: (_) {
          return Scaffold(
            extendBody: true,
            bottomNavigationBar: buildBottomNavBar(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                mainViewModel.changeBottomBarCurrentIndex(1);
              },
              child: const Icon(Icons.fitness_center),
            ),
            body: mainViewModel.tabs[mainViewModel.bottomNavBarCurrentIndex],
          );
        });
      },
    );
  }

  Widget buildBottomNavBar() => ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: Observer(builder: (_) {
          return bottomBar();
        }),
      );

  BottomAppBar bottomBar() {
    return BottomAppBar(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: const CircularNotchedRectangle(),
      notchMargin: 5,
      child: BottomNavigationBar(
        iconSize: context.highIconSize,
        selectedFontSize: context.normalTextSize,
        unselectedFontSize: context.lowTextSize,
        type: BottomNavigationBarType.fixed,
        currentIndex: mainViewModel.bottomNavBarCurrentIndex,
        onTap: (value) => mainViewModel.changeBottomBarCurrentIndex(value),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: LocaleKeys.tabbarViewHome.locale,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_circle_sharp),
            label: LocaleKeys.tabbarViewProfile.locale,
          ),
        ],
      ),
    );
  }
}
