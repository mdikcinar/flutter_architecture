import 'package:flutter_architecture/view/home/home_view.dart';
import 'package:flutter_architecture/view/profile/profile_view.dart';
import 'package:mobx/mobx.dart';
part 'main_viewmodel.g.dart';

class MainViewModel = _MainViewModelBase with _$MainViewModel;

abstract class _MainViewModelBase with Store {
  @observable
  int _bottomNavBarCurrentIndex = 0;

  @computed
  int get bottomNavBarCurrentIndex => _bottomNavBarCurrentIndex;

  @action
  void changeBottomBarCurrentIndex(int value) {
    _bottomNavBarCurrentIndex = value;
  }

  final tabs = [
    const HomeView(),
    const ProfileView(),
  ];
}
