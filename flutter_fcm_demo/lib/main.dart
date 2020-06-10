import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart' as path_provider;

//for fcm
final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

//for local notification
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;
//final BehaviorSubject<String> selectNotificationSubject = BehaviorSubject<String>();

void main() async {
  // needed if you intend to initialize in the `main` function
  WidgetsFlutterBinding.ensureInitialized();

  //get fcm token
  String token = await _firebaseMessaging.getToken();
  print('Token: $token');

  //configuration for local notification
  await initializeLocalNotifications();

  runApp(MyApp());
}

initializeLocalNotifications() async {
  //action to be performed when we click on notification
  onSelectNotification(String payload) async {
    if (payload != null) {
      print('notification payload: $payload');
    }
//      selectNotificationSubject.add(payload);
  }

  notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

  var initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');
  // Note: permissions aren't requested here just to demonstrate that can be done later using the `requestPermissions()` method
  // of the `IOSFlutterLocalNotificationsPlugin` class
  var initializationSettingsIOS = IOSInitializationSettings();
//      IOSInitializationSettings(
//      requestAlertPermission: false,
//      requestBadgePermission: false,
//      requestSoundPermission: false,
//      onDidReceiveLocalNotification:
//          (int id, String title, String body, String payload) async {
//        didReceiveLocalNotificationSubject.add(ReceivedNotification(
//            id: id, title: title, body: body, payload: payload));
//      });
  var initializationSettings = InitializationSettings(
      initializationSettingsAndroid, initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onSelectNotification: (payload) => onSelectNotification(payload),
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _message = '';

  @override
  void initState() {
    super.initState();
    getFCMMessage();
  }

  void getFCMMessage() {
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print('on message $message');
        setState(() {
          print('title: ${message["notification"]["title"]}');
          print('title: ${message["notification"]["body"]}');
          _showLocalNotification(title: message["notification"]["title"], text: message["notification"]["body"]);
          _message = message["notification"]["title"];
        });
      },
      onResume: (Map<String, dynamic> message) async {
        print('on resume $message');
        setState(() => _message = message["notification"]["title"]);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print('on launch $message');
        setState(() => _message = message["notification"]["title"]);
      },
    );
  }

  Future _showLocalNotification({String title = '', String text = '', String payload = ''}) async {
//    var largeIconPath = await _downloadAndSaveFile(
//        'https://pmcdeadline2.files.wordpress.com/2018/04/shutterstock_9136796ci-e1524603806885.jpg?w=681&h=383&crop=1',
//        'largeIcon');
//    var bigPicturePath = await _downloadAndSaveFile(
//        'https://pmcdeadline2.files.wordpress.com/2018/04/shutterstock_9136796ci-e1524603806885.jpg?w=681&h=383&crop=1',
//        'bigPicture');
//    var bigPictureStyleInformation = BigPictureStyleInformation(
//        FilePathAndroidBitmap(bigPicturePath),
//        largeIcon: FilePathAndroidBitmap(largeIconPath),
//        htmlFormatContentTitle: true,
//        contentTitle: 'overridden <b>big</b> content title',
//        summaryText: 'summary <i>text</i>',
//        htmlFormatSummaryText: true);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'channel id', 'channel name', 'channel description',
//        sound: 'sound.mp3', //notification with sound.mp3 located at android/app/src/res/raw/
//        playSound: false, //notification without sound  //play sound settings once intialized for specific channel, it can't be changed fot that channel id.
        importance: Importance.Max,
        priority: Priority.High,
    );
//        styleInformation: bigPictureStyleInformation);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
//      sound: 'sound.aiff',
        );

    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      text,
      platformChannelSpecifics,
      payload: payload, //for notification without sound
    );
  }

//  Future<String> _downloadAndSaveFile(String url, String fileName) async {
//    var directory = await path_provider.getApplicationDocumentsDirectory();
//    var filePath = '${directory.path}/$fileName';
//    var response = await http.get(url);
//    var file = File(filePath);
//    await file.writeAsBytes(response.bodyBytes);
//    return filePath;
//  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text("Message: $_message"),
                OutlineButton(
                  child: Text("Register My Device"),
                  onPressed: () async {
                    print('token: ${await _firebaseMessaging.getToken()}');
                    _showLocalNotification();
                  },
                ),
                // Text("Message: $message")
              ]),
        ),
      ),
    );
  }
}
