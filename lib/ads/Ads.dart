import 'package:firebase_admob/firebase_admob.dart';

const String testDevice = 'YOUR_DEVICE_ID';

class Ads {
  static BannerAd _bannerAd;
  static InterstitialAd _interstitialAd;
  static bool _adShown = false;

  static void initialize() {
    FirebaseAdMob.instance.initialize(appId: FirebaseAdMob.testAppId);
  }

  static const MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    testDevices: testDevice != null ? <String>[testDevice] : null,
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    childDirected: true,
    nonPersonalizedAds: true,
  );

  static BannerAd _createBannerAd() {
    return BannerAd(
      adUnitId: BannerAd.testAdUnitId,
      size: AdSize.fullBanner,
     // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BannerAd event $event");
       /* if (event == MobileAdEvent.loaded) {
          _adShown = true;

        } else if (event == MobileAdEvent.failedToLoad) {
          _adShown = false;

        }*/
      },
    );
  }

  static InterstitialAd createInterstitialAd() {
    return InterstitialAd(
      adUnitId: InterstitialAd.testAdUnitId,
      // targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        if (event == MobileAdEvent.failedToLoad) {
          _interstitialAd..load();
        } else if (event == MobileAdEvent.closed) {
          _interstitialAd = createInterstitialAd()..load();
        }
        print("InterstitialAd event $event");
      },
    );
  }

  static void showBannerAd() {
    if (_bannerAd == null) _bannerAd = _createBannerAd();
    _bannerAd
      ..load()
      ..show(anchorOffset: 0.0, anchorType: AnchorType.bottom);
    _adShown = true;
  }

  static void showInterstitialAd(){
    _interstitialAd?.dispose();
    _interstitialAd = createInterstitialAd()..load();
    _interstitialAd?.show();
  }

  static void hideBannerAd() async {
    if (_bannerAd != null) await _bannerAd.dispose();
    _bannerAd = null;
    _adShown = false;
  }

  static bool isAdsShowing(){
    return _bannerAd == null? false: true;
  }
}