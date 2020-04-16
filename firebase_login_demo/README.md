# firebase_login_demo

This project is demo of firbase_login using bloc architecture.

This demo project contains 2 way of login:
1. Normal credential(email/password) login
2. Login with Google

# Settings needed from firebase side
1. Enabled "Email/Password" sign-in provider from authentication setting (for normal email/password credential login)
2. Enabled "Google" sign-in provider from authentication setting (for login with Google)
3. Add SHA-1 key in firebase application project setting (for OAuth signing)
4. After step-3, download the "google-services.json" file and put it at android/app/ location at client side project.

# Keystore file - You will need keystore files for following use case:
1. will be used to generate the signed apk/aab in android.
2. By debugging this keystore file, you can get the SHA-1 key (which is needed to add in firebase application project setting)