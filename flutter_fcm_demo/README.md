# fcm demo project

A demo project for firebase cloud messaging.

## Getting Started

Library used:

- [firebase_messaging](https://pub.dev/packages/firebase_messaging)

For help getting started with FCM, follow these steps:

1. Download the google-service.json file, after registering you app.
    - To register the app with firebase, we need app package name and SHA-1 key of app's signing certificate.
    - Here we have used debug certificate from the [official site](https://developers.google.com/android/guides/client-auth), but in production we will have to use the SHA-1 key from your signing keystore file.
2. After that, just follows the steps from [firebase_messaging](https://pub.dev/packages/firebase_messaging)


You can send the test fcm from firebase console:
Navigate to Firebase project -> Grow -> Cloud Messaging menu (from Left side slider menu).
Send test message to your device token id.
