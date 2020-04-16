import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';

/// the testAdUnitId with an ad unit id from the AdMob dash.
///     https://developers.google.com/admob/android/test-ads
///     https://developers.google.com/admob/ios/test-ads
///Ad's test API ID: ca-app-pub-3940256099942544~3347511713
///test banner ID: ca-app-pub-3940256099942544/6300978111
///test interstitial ID: ca-app-pub-3940256099942544/1033173712

//ad mob API id
final String AD_MOB_APP_ID = FirebaseAdMob.testAppId;

//Test device id
const String ROY_ZENPHONE = 'A33BC47F72FAF46FB952DB76FE75BA3D';
const String GOTI_REDMI_7 = '7D0BBC6AFC940A476A528B557CD034FA';
const List<String> AD_MOB_TEST_DEVICE = <String>[
  ROY_ZENPHONE,
  GOTI_REDMI_7
]; //'test_device_id - AdMob won't consider these devices';

///banner ads unit id
final String AD_MOB_BANNER_AD_ID = BannerAd.testAdUnitId;

///interstitial ads unit id
final String AD_MOB_INTERSTITIAL_AD_ID = InterstitialAd.testAdUnitId;

///reward ads unit id
final String AD_MOB_REWARD_AD_ID = RewardedVideoAd.testAdUnitId;

///target devices info, that contains specific app, keywords, contentURL
MobileAdTargetingInfo get _targetingInfo => MobileAdTargetingInfo(
//    keywords: <String>['flutterio', 'beautiful apps'],
//    contentUrl: 'https://flutter.io',
//    childDirected: false,
      testDevices:
          AD_MOB_TEST_DEVICE, // Android emulators are considered test devices
//    birthday: DateTime.now(),
//    designedForFamilies: false,
//    gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
    );

//create banner ad
BannerAd createBannerAd(
    {@required String bannerId,
    @required MobileAdListener mobileAdListener,
    AdSize bannerSize}) {
  return BannerAd(
    adUnitId: bannerId,
    size: bannerSize ?? AdSize.banner,
    targetingInfo: _targetingInfo,
    listener: mobileAdListener,
  );
}

//create interstitial ad
InterstitialAd createInterstitialAd(
    {@required String interstitialId,
    @required MobileAdListener mobileAdListener}) {
  return InterstitialAd(
    adUnitId: interstitialId,
    targetingInfo: _targetingInfo,
    listener: mobileAdListener,
  );
}

//create reward ad
///we don't have to create a new reward ad instance, as it is a singleton class
///due to that, it won't have any dispose method.
RewardedVideoAd getRewardVideoAd(
    {@required RewardedVideoAdListener rewardVideoAdListener}) {
  RewardedVideoAd.instance.listener = rewardVideoAdListener;
  return RewardedVideoAd.instance;
}

//load a reward ad
///since reward video ad is a singlton class, we pass ad ID and targetInfo at loading time, unlike banner and interstitial
RewardedVideoAd loadRewardVideoAd(
    {@required String rewardVideoAdId,
    @required RewardedVideoAd rewardVideoAd}) {
  rewardVideoAd.load(
    adUnitId: rewardVideoAdId,
    targetingInfo: _targetingInfo,
  );
  return rewardVideoAd;
}
