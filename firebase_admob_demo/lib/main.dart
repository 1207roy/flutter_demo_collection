import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/material.dart';

import 'admob/admob_helper.dart' as admobHelper;

void main() {
  // as we are awaiting main(),
  // we need to initialize WidgetsBinding first.
  WidgetsFlutterBinding.ensureInitialized();

  //intialize the firebase_admob with the AdMob app id
  FirebaseAdMob.instance.initialize(appId: admobHelper.AD_MOB_APP_ID);

  runApp(MyApp());
}

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

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

bool _bannerAdShown = false;

///state of the reward ad
enum RewardAdState {
  LOADING,
  NORMAL,
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  ValueNotifier<RewardAdState> _rewardAdState =
      ValueNotifier<RewardAdState>(RewardAdState.NORMAL);

  BannerAd _bannerAd;
  InterstitialAd _interstitialAd;
  RewardedVideoAd _rewardAd;

  MobileAdListener get _bannerAdListener => (MobileAdEvent event) {
        print("BANNER-AD EVENT is $event");
        switch (event) {
          case MobileAdEvent.loaded:
            _bannerAdShown = true;
            print('Banner ad is loaded...');
            setState(() {});
            break;
          default:
            break;
        }
      };

  MobileAdListener get _interstitialAdListener => (MobileAdEvent event) {
        print("INTERSTITIAL-AD EVENT is $event");
        switch (event) {
          case MobileAdEvent.loaded:
            print('Interstitial ad is loaded...');
            break;
          case MobileAdEvent.closed:
            print('Interstitial ad is closed...');
            _interstitialAd = null;

            //to load it again, for speedy showing interstitial ad on next button press(as we it will be already loaded)
            _initializeInterstitialAd;
            break;
          default:
            break;
        }
      };

  RewardedVideoAdListener get _rewardAdListener =>
      (RewardedVideoAdEvent event, {String rewardType, int rewardAmount}) {
        print("REWARD-AD EVENT is $event");
        switch (event) {
          case RewardedVideoAdEvent.loaded:
            _rewardAdState.value = RewardAdState.NORMAL;
            break;
          case RewardedVideoAdEvent.rewarded:
            setState(() {
              print(
                  'Reward=====rewardType: $rewardType rewardAmount: $rewardAmount');
              _counter += rewardAmount;
            });
            break;
          case RewardedVideoAdEvent.closed:
            _rewardAdState.value = RewardAdState.NORMAL;
            //to load it again, for speedy showing reward video ad on next button press(as we it will be already loaded)
            _initializeRewardAd;
            break;
          case RewardedVideoAdEvent.failedToLoad:
            _rewardAdState.value = RewardAdState.NORMAL;
            break;
          default:
            break;
        }
      };

  BannerAd get _createdBannerAd => admobHelper.createBannerAd(
        bannerId: admobHelper.AD_MOB_BANNER_AD_ID,
        bannerSize: AdSize.fullBanner,
        mobileAdListener: _bannerAdListener,
      );

  BannerAd get _initializeBannerAd {
    _bannerAdShown = false;
    return (_bannerAd ??= _createdBannerAd)..load();
  }

  void _showBannerAd() => _initializeBannerAd.show(
//    Banner Position
        anchorType: AnchorType.bottom,
        // Positions the banner ad some pixels from the bottom of the screen
        anchorOffset: 0.0,
        // Positions the banner ad some pixels from the center of the screen to the right
        horizontalCenterOffset: 10.0,
      );

  void _disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  InterstitialAd get _createdInterstitialAd => admobHelper.createInterstitialAd(
        interstitialId: admobHelper.AD_MOB_INTERSTITIAL_AD_ID,
        mobileAdListener: _interstitialAdListener,
      );

  InterstitialAd get _initializeInterstitialAd =>
      (_interstitialAd ??= _createdInterstitialAd)..load();

  void _showInterstitialAd() => _initializeInterstitialAd.show();

  void _disposeInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
  }

  RewardedVideoAd get _createRewardVideoAd => _rewardAd ??=
      admobHelper.getRewardVideoAd(rewardVideoAdListener: _rewardAdListener);

  RewardedVideoAd get _initializeRewardAd => admobHelper.loadRewardVideoAd(
        rewardVideoAdId: admobHelper.AD_MOB_REWARD_AD_ID,
        rewardVideoAd: (_rewardAd ??= _createRewardVideoAd),
      );

  void _showRewardAd() => _initializeRewardAd.show();
  ///we don't have to dispose reward video ad, as its a singleton class

  void _initializeAds() {
    _initializeBannerAd;
    _initializeInterstitialAd;
    _initializeRewardAd;
  }

  void _disposeAds() {
    _disposeBannerAd();
    _disposeInterstitialAd();
    ///we don't have to dispose reward video ad, as its a singleton class
  }

  @override
  void initState() {
    super.initState();
    _initializeAds();
  }

  @override
  void dispose() {
    _disposeAds();
    super.dispose();
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
              onPressed: _showBannerAd,
            ),
            FlatButton(
              child: Text(
                'Hide Banner Ad',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: _disposeBannerAd,
            ),
            FlatButton(
              child: Text(
                'Interstitial Ad',
                style: Theme.of(context).textTheme.button,
              ),
              onPressed: _showInterstitialAd,
            ),
            ValueListenableBuilder(
                valueListenable: _rewardAdState,
                builder:
                    (BuildContext context, RewardAdState state, Widget child) {
                  print(
                      'ValueListenableBuilder notified with _rewardAdState: ${_rewardAdState.value}');
                  switch (state) {
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
//                          loadRewardAd();
                          _showRewardAd();
                        },
                      );
                  }
                }),
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
