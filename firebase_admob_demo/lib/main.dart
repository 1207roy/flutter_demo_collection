import 'dart:math';

import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter firebase_admob demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter firebase_admob Home Page'),
    );
  }
}

bool _bannerAdShown = false;
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

final String AD_MOB_APP_ID = FirebaseAdMob.testAppId; //AdMob's testing purpose App ID: 'ca-app-pub-3940256099942544~3347511713'

//my asus zenphone device id: "A33BC47F72FAF46FB952DB76FE75BA3D"
const List<String> AD_MOB_TEST_DEVICE = <String>['A33BC47F72FAF46FB952DB76FE75BA3D'];  //'test_device_id - AdMob won't consider these devices';
final String AD_MOB_BANNER_AD_ID = BannerAd.testAdUnitId; //AdMob's testing purpose banner ad unit id: 'ca-app-pub-3940256099942544/6300978111'
final String AD_MOB_INTERSTITIAL_AD_ID = InterstitialAd.testAdUnitId;  //AdMob's testing purpose interstitial ad unit id: 'ca-app-pub-3940256099942544/1033173712'
final String AD_MOB_REWARD_AD_ID = RewardedVideoAd.testAdUnitId;  //AdMob's testing purpose reward ad unit id: 'ca-app-pub-3940256099942544/5224354917'

enum RewardAdState {
  LOADING,
  NORMAL
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ValueNotifier<RewardAdState> _rewardAdState = ValueNotifier<RewardAdState>(RewardAdState.NORMAL);

  //create a target info, that contains specific app, keywords, contentURL
  static final MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['flutterio', 'beautiful apps'],
    contentUrl: 'https://flutter.io',
    childDirected: false,
    testDevices: AD_MOB_TEST_DEVICE, // Android emulators are considered test devices
//    birthday: DateTime.now(),
//    designedForFamilies: false,
//    gender: MobileAdGender.male, // or MobileAdGender.female, MobileAdGender.unknown
  );

  BannerAd _bannerAd;

  ///method to create a banner ad, with its listener
  BannerAd createBannerAd() {
    return new BannerAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: AD_MOB_BANNER_AD_ID,
      size: AdSize.fullBanner,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("BANNER-AD EVENT is $event");
        switch(event) {
          case MobileAdEvent.loaded:
            _bannerAdShown = true;
            print('Banner ad is loaded...');
            setState(() { });
            break;
          default:
            break;
        }
      },
    );
  }

  InterstitialAd _interstitialAd;

  ///method to create an interstitial Ad, with its listener
  InterstitialAd createInterstitialAd() {
    return new InterstitialAd(
      // Replace the testAdUnitId with an ad unit id from the AdMob dash.
      // https://developers.google.com/admob/android/test-ads
      // https://developers.google.com/admob/ios/test-ads
      adUnitId: AD_MOB_INTERSTITIAL_AD_ID,
      targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) {
        print("INTERSTITIAL-AD EVENT is $event");
        switch(event) {
          case MobileAdEvent.loaded:
            print('Interstitial ad is loaded...');
            break;
          case MobileAdEvent.closed:
            print('Interstitial ad is closed...');
            _interstitialAd = null;
            break;
          default:
            break;
        }
      },
    );
  }

  ///we don't have to create a reward ad instance, as it is a singleton class
  ///due to that, it won't have any dispose method.
  RewardedVideoAd _rewardAd = RewardedVideoAd.instance;

  @override
  void initState() {
    super.initState();

    //intialize the firebase_admob with the AdMob app id
    FirebaseAdMob.instance.initialize(appId: AD_MOB_APP_ID);

    //to check if the banner ad is visible or not
    _bannerAdShown = false;

    //create a banner ad instance, and also load it
    _bannerAd = createBannerAd()
      ..load();
//      ..show();

    //create a interstitial ad instance, and also load it
    _interstitialAd = createInterstitialAd()
      ..load();
//      ..show();

    //won't have to create any rewardAd instance, as it is a singleton class
  }


  @override
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  ///method to show a banner ad
  void showBannerAd() {
    _bannerAd ??= createBannerAd();
    _bannerAd
      ..load()
      ..show(
//      // Banner Position
//      anchorType: AnchorType.bottom,
//      // Positions the banner ad 60 pixels from the bottom of the screen
//      anchorOffset: 0.0,
//      // Positions the banner ad 10 pixels from the center of the screen to the right
//      horizontalCenterOffset: 10.0,
      );
  }

  ///method to hide a banner ad
  void hideBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  ///method to show a interstitial ad
  void showInterstitialAd() {
    _interstitialAd ??= createInterstitialAd();
    _interstitialAd
      ..load()
      ..show(
//      anchorType: AnchorType.bottom,
//      anchorOffset: 0.0,
//      horizontalCenterOffset: 0.0,
    );
  }

  ///method to load and show the reward ad, with its listener
  void loadRewardAd() {
    _rewardAd
        .load(
        adUnitId: AD_MOB_REWARD_AD_ID,
        targetingInfo: targetingInfo);

    _rewardAd.listener = (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
      print("REWARD-AD EVENT is $event");
      switch(event) {
        case RewardedVideoAdEvent.loaded:
          _rewardAdState.value = RewardAdState.NORMAL;
          _rewardAd.show();
          break;
        case RewardedVideoAdEvent.rewarded:
          setState(() {
            print('Reward=====rewardType: $rewardType rewardAmount: $rewardAmount');
            _counter += rewardAmount;
          });
          break;
        case RewardedVideoAdEvent.failedToLoad:
          _rewardAdState.value = RewardAdState.NORMAL;
          break;
        default:
          break;
      }
    };
  }

  @override
  Widget build(BuildContext context) {

    //to add some space at bottom, for banner ad
    List<Widget> fakeBottomButtons = new List<Widget>();
    fakeBottomButtons.add(new Container(
      height: 50.0,
    ));

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              child: Text(
                'Show Banner Ad',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: showBannerAd,
            ),
            FlatButton(
              child: Text(
                'Hide Banner Ad',
                style: Theme.of(context).textTheme.button,
            ),
              onPressed: hideBannerAd,
            ),
            FlatButton(
              child: Text(
                'Interstitial Ad',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: showInterstitialAd,
            ),
            ValueListenableBuilder(
                valueListenable: _rewardAdState,
                builder: (BuildContext context, RewardAdState state, Widget child) {
                  print('ValueListenableBuilder notified with _rewardAdState: ${_rewardAdState.value}');
                  switch(state) {
                    case RewardAdState.LOADING:
                      return FlatButton(
                        child: Text(
                          'Reward ad video is loading...',
                          style: Theme.of(context).textTheme.button,
                        ),
                      );
                    default:
                      return FlatButton(
                        child: Text(
                          'Reward Ad',
                          style: Theme.of(context).textTheme.button,
                        ),
                        onPressed: () {
                          _rewardAdState.value = RewardAdState.LOADING;
                          loadRewardAd();
                        },
                      );
                  }
                }
            ),
            Text(
              'Reward amount: $_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      persistentFooterButtons: _bannerAdShown ? fakeBottomButtons : null,
    );
  }
}
