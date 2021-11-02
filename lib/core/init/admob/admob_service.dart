import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../../init/iappPurchase/puchases_service.dart';
import 'package:provider/provider.dart';

class AdMobService {
  static String get bannerAdUnitId {
    //return Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/2934735716'; //test
    return Platform.isAndroid ? 'ca-app-pub-3940256099942544/6300978111' : 'ca-app-pub-3940256099942544/6300978111'; //test
  }

  static String get interstitialAdUnitId {
    //return Platform.isAndroid ? 'ca-app-pub-3940256099942544/1033173712' : 'ca-app-pub-3940256099942544/4411468910'; //test
    return Platform.isAndroid ? 'ca-app-pub-8273766392078114/3308988459' : 'ca-app-pub-8273766392078114/5686318905'; //original
  }

  static String get testInterstitialVideoAdUnitId {
    return Platform.isAndroid ? 'ca-app-pub-3940256099942544/8691691433' : 'ca-app-pub-3940256099942544/5135589807'; //test
  }

  static String get nativeAdvancedAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/2247696110'
        : 'ca-app-pub-3940256099942544/3986624511'; //test ios not setted
    //return Platform.isAndroid ? 'ca-app-pub-2004628849062288/2103533904' : 'ca-app-pub-2004628849062288/7300020268'; //original
  }

  static String get testNativeAdvancedVideoAdUnitId {
    return Platform.isAndroid
        ? 'ca-app-pub-3940256099942544/1044960115'
        : 'ca-app-pub-3940256099942544/2521693316'; //test ios not setted
  }

  static InterstitialAd? _interstitialAd;
  static int _numInterstitialLoadAttempts = 0;
  static int maxFailedLoadAttempts = 3;
  static int showAddCounter = 1;

  static final AdRequest request = AdRequest(
      //keywords: <String>['foo', 'bar'],
      //contentUrl: 'http://foo.com/bar.html',
      //nonPersonalizedAds: true,
      );

  // ignore: always_declare_return_types
  static initialize() {
    MobileAds.instance.initialize();
  }

  static void dispose() {
    if (_interstitialAd != null) {
      _interstitialAd!.dispose();
    }
  }

  // ignore: missing_return
  static BannerAd createBannerAd() {
    var ad = BannerAd(
      adUnitId: bannerAdUnitId,
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => debugPrint('Ad loaded'),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
        },
        onAdOpened: (ad) => debugPrint('Ad opened'),
        onAdClosed: (ad) => debugPrint('Ad Closed'),
      ),
    );
    return ad;
  }

  static Future<void> createInterstitialAd() async {
    debugPrint('Create interstitial ad worked.');
    await InterstitialAd.load(
        adUnitId: interstitialAdUnitId,
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            debugPrint('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            debugPrint('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              createInterstitialAd();
            }
          },
        ));
  }

  static Future<void> showInterstitialAd(BuildContext context) async {
    if (_interstitialAd == null) {
      debugPrint('Warning: attempt to show interstitial before loaded.');
      return;
    }
    /*if (context.read<UserManager>().showedAdCount >= 5) {
      debugPrint('Show add maximum limit reached!');
      return;
    }
    debugPrint('Showed add count: ' + context.read<UserManager>().showedAdCount.toString());*/
    if (Provider.of<InAppPurchaseService>(context, listen: false).isUserPatron) {
      if (showAddCounter % 6 == 0) {
        _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
          onAdShowedFullScreenContent: (InterstitialAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
          onAdDismissedFullScreenContent: (InterstitialAd ad) async {
            debugPrint('$ad onAdDismissedFullScreenContent.');
            await ad.dispose();
            await createInterstitialAd();
          },
          onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) async {
            debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
            await ad.dispose();
            await createInterstitialAd();
          },
        );
        await _interstitialAd!.show();
        _interstitialAd = null;
        showAddCounter = 0;
        //context.read<UserManager>().showedAdCount++;
      }
    } else if (showAddCounter % 2 == 0) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        onAdShowedFullScreenContent: (InterstitialAd ad) => debugPrint('ad onAdShowedFullScreenContent.'),
        onAdDismissedFullScreenContent: (InterstitialAd ad) async {
          debugPrint('$ad onAdDismissedFullScreenContent.');
          await ad.dispose();
          await createInterstitialAd();
        },
        onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) async {
          debugPrint('$ad onAdFailedToShowFullScreenContent: $error');
          await ad.dispose();
          await createInterstitialAd();
        },
      );
      await _interstitialAd!.show();
      _interstitialAd = null;
      showAddCounter = 0;
      //context.read<UserManager>().showedAdCount++;
    }
    debugPrint('show add counter: ' + showAddCounter.toString());
    showAddCounter++;
  }
}
