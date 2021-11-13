import 'package:flutter/material.dart';
import '/core/init/cache/cache_manager.dart';
import '/constants/enums/preferances_keys_enum.dart';

class SplashViewModel extends ChangeNotifier {
  bool showOnBoardView = CacheManager.instance.containsKey(PreferancesKeys.showOnBoard)
      ? CacheManager.instance.getBoolValue(PreferancesKeys.showOnBoard)
      : true;

  void changeShowOnBoardView(bool value) {
    showOnBoardView = value;
    CacheManager.instance.setBoolValue(PreferancesKeys.showOnBoard, showOnBoardView);
    notifyListeners();
  }

  Future<void> initializeApp() async {
    await Future.delayed(Duration(seconds: 5));
  }
}
