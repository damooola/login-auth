# login_auth

---

## Login Authentication App

This app showcases user authentication using Firebase. Users can sign up, log in, and recover their password. Users also have the option to sign in with Google or Apple.

## Getting Started

1. **Firebase Setup**:
   - Create a Firebase project through the [Firebase Console](https://console.firebase.google.com/).
   - Enable Firebase Authentication in your project.
   - Download the `google-services.json` file and place it in the `android/app` directory.
   - Add your iOS app to the Firebase project and download the `GoogleService-Info.plist` file. Place it in the `ios/Runner` directory.

2. **Project Setup**:
   - Clone this repository or create a new Flutter project.
   - Add the necessary dependencies to your `pubspec.yaml`:

     ```yaml
     dependencies:
       flutter:
         sdk: flutter
       firebase_core: ^3.4.0
       firebase_auth: ^5.2.0
       google_sign_in: ^latest_version
       apple_sign_in: ^latest_version
     ```

3. **Firebase Authentication Methods**:
   - Email/Password: Users can sign up and log in using their email and password.
   - Google Sign-In: Users can sign in using their Google account.
   - Apple Sign-In: Users can sign in using their Apple ID (iOS only).

4. **Run the App**:
   - Run `flutter pub get` to install dependencies.
   - Launch the app on an emulator or physical device.

## Contributing

Feel free to contribute to this project by opening issues or pull requests.

---

Happy coding! 🚀🔥 If you have any questions or need further assistance, feel free to ask!
