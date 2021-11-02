import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_architecture/core/base/model/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../extensions/string_extension.dart';
import '../../init/language/locale_keys.g.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class InAppPurchaseService with ChangeNotifier {
  late BuildContext context;

  List<Package> _productPackages = [];
  List<String>? _activeSubscriptions;
  late PurchaserInfo purchaserInfo;
  bool purchasePending = false;

  bool isUserSubscribed = false;

  bool isUserPatron = false;

  // ignore: unnecessary_getters_setters
  List<Package> get productPackages => _productPackages;
  // ignore: unnecessary_getters_setters
  set productPackages(List<Package> value) {
    _productPackages = value;
    //notifyListeners();
  }

  void initialize(UserModel? userModel) async {
    debugPrint('IAPP initialized');
    await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup('FntJPxAUstueUgyOytyRIjAvYJHhwRtE', appUserId: userModel?.userID);
    if (userModel != null && userModel.email != null) {
      await Purchases.setEmail(userModel.email!);
    }
    purchaserInfo = await Purchases.getPurchaserInfo();
    await isAnyItemPurchased(purchaserInfo, userModel);

    //await getProducts();
  }

  Future<void> getProducts() async {
    try {
      _productPackages = [];
      var offerings = await Purchases.getOfferings();
      var current = offerings.current;
      if (current != null) {
        _productPackages = current.availablePackages;
        notifyListeners();
      }
    } on PlatformException catch (e) {
      debugPrint('error:' + e.message.toString());
      await Fluttertoast.showToast(
          msg: 'Error: ' + e.message.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<void> buyProducts(Package package, UserModel? userModel) async {
    purchasePending = true;
    notifyListeners();
    try {
      purchaserInfo = await Purchases.purchasePackage(package);
      await isAnyItemPurchased(purchaserInfo, userModel);
    } on PlatformException catch (e) {
      var errorCode = PurchasesErrorHelper.getErrorCode(e);
      if (errorCode != PurchasesErrorCode.purchaseCancelledError) {
        debugPrint('HATA:' + e.message.toString());
        await Fluttertoast.showToast(
            msg: 'Error: ' + e.message.toString(),
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
      }
    }
    purchasePending = false;
    notifyListeners();
  }

  Future<bool> isPruchasedProSubscription(PurchaserInfo purchaserInfo) async {
    try {
      if (purchaserInfo.entitlements.all['pro'] != null && purchaserInfo.entitlements.all['pro']!.isActive) {
        return true;
      }
    } on PlatformException catch (e) {
      await Fluttertoast.showToast(
          msg: 'Error: ' + e.message.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
    return false;
  }

  Future<bool> isPruchasedPatron(PurchaserInfo purchaserInfo) async {
    try {
      if (purchaserInfo.entitlements.all['patron'] != null && purchaserInfo.entitlements.all['patron']!.isActive) {
        return true;
      }
    } on PlatformException catch (e) {
      await Fluttertoast.showToast(
          msg: 'Error: ' + e.message.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
    return false;
  }

  Future<void> isAnyItemPurchased(PurchaserInfo purchaserInfo, UserModel? userModel) async {
    try {
      if (purchaserInfo.entitlements.all['pro'] != null && purchaserInfo.entitlements.all['pro']!.isActive) {
        isUserSubscribed = true;
        _activeSubscriptions = purchaserInfo.activeSubscriptions;
      } else {
        isUserSubscribed = false;
        _activeSubscriptions = null;
      }
      if (purchaserInfo.entitlements.all['patron'] != null && purchaserInfo.entitlements.all['patron']!.isActive) {
        isUserPatron = true;
      } else {
        isUserPatron = false;
      }
      notifyListeners();
    } on PlatformException catch (e) {
      debugPrint(e.message);
      _activeSubscriptions = null;
      isUserSubscribed = false;
      isUserPatron = false;
      notifyListeners();
      await Fluttertoast.showToast(
          msg: 'Error: ' + e.message.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
    }
    debugPrint('IAPP: patron ' + isUserPatron.toString());
    if (userModel != null) {
      bool saveUserToCloud = false;
      if (userModel.isSubscribed == null || (userModel.isSubscribed != null && userModel.isSubscribed != isUserSubscribed)) {
        userModel.isSubscribed = isUserSubscribed;
        saveUserToCloud = true;
      }

      if (saveUserToCloud) {
        userModel.saveUserModeltoLocale();
        //userModel.saveSubscriptions(isUserSubscribed, isUserPatron);
      }
    } else {
      debugPrint('Save user subscriptions: User model null');
    }
  }

  List<Product> getSubscribedProductList() {
    // ignore: omit_local_variable_types
    List<Product> subscribedProductList = [];
    if (_activeSubscriptions != null) {
      for (var subscription in _activeSubscriptions!) {
        for (var productPackage in _productPackages) {
          if (productPackage.product.identifier == subscription) {
            subscribedProductList.add(productPackage.product);
          }
        }
      }
    }
    return subscribedProductList;
  }

  Future<void> restorePurchase(UserModel? userModel) async {
    purchasePending = true;
    notifyListeners();
    try {
      var restoredInfo = await Purchases.restoreTransactions();
      await isAnyItemPurchased(restoredInfo, userModel);
      if (isUserSubscribed || isUserPatron) {
        await Fluttertoast.showToast(
            msg: LocaleKeys.pruchaseRestored.locale,
            backgroundColor: Colors.green,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
      } else {
        await Fluttertoast.showToast(
            msg: LocaleKeys.pruchaseRestoreNotFound.locale,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            toastLength: Toast.LENGTH_LONG);
      }
      // ... check restored purchaserInfo to see if entitlement is now active
    } on PlatformException catch (e) {
      debugPrint('RestoreError:' + e.message.toString());
      await Fluttertoast.showToast(
          msg: 'Error: ' + e.message.toString(),
          backgroundColor: Colors.red,
          textColor: Colors.white,
          toastLength: Toast.LENGTH_LONG);
      // Error restoring purchases
    }
    purchasePending = false;
    notifyListeners();
  }
}
