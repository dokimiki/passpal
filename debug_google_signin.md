# Google Sign-In Debug Guide for Android

## Common Causes of "Google Sign-In Cancelled" Error

### 1. Missing SHA-1/SHA-256 Fingerprints
The most common cause is missing debug SHA-1 fingerprints in Firebase Console.

#### Get your debug SHA-1 fingerprint:
```bash
# For Windows (in your project's android directory)
cd android
./gradlew signingReport

# Or use keytool directly
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

#### For Windows users, the debug keystore is usually located at:
```
C:\Users\[USERNAME]\.android\debug.keystore
```

#### Add the SHA-1 fingerprint to Firebase:
1. Go to Firebase Console → Your Project → Project Settings
2. Click on your Android app
3. Add the SHA-1 fingerprint in the "SHA certificate fingerprints" section
4. Download the new `google-services.json` file
5. Replace the existing one in `android/app/google-services.json`

### 2. Enable Google Sign-In in Firebase Authentication
1. Go to Firebase Console → Authentication → Sign-in method
2. Enable "Google" as a sign-in provider
3. Set the project support email

### 3. Verify Package Name
Ensure the package name in Firebase matches your app:
- Firebase package name: `app.chukyopasspal.passpal`
- App package name in `android/app/build.gradle.kts`: `app.chukyopasspal.passpal`

### 4. Emulator-Specific Issues
- Ensure the emulator has Google Play Services installed
- Use an emulator with Google APIs (not just Android)
- Test on a physical device if emulator issues persist

### 5. Network and Proxy Issues
- Ensure the emulator/device has internet access
- Check if corporate firewalls are blocking Google services
- Try using a different network

## Debugging Steps

1. **Check the logs after implementing the debug version:**
   - Look for "Starting Google Sign-In with provider" message
   - Check for any error messages with detailed information

2. **Verify Firebase configuration:**
   - Ensure `google-services.json` is in the correct location
   - Verify the package name matches

3. **Test the SHA-1 fingerprint:**
   - Get your debug SHA-1 using the command above
   - Add it to Firebase Console
   - Clean and rebuild the app

4. **Try different approaches:**
   - Test on a physical device instead of emulator
   - Try a different Google account
   - Clear app data and try again

## Current Implementation Status
✅ Using `signInWithProvider` for native platforms
✅ Proper error handling for cancellation
✅ Debug logging added for troubleshooting
✅ Correct Firebase Auth integration

## Next Steps if Issue Persists
1. Run the SHA-1 fingerprint check
2. Verify Firebase Console configuration
3. Test on physical device
4. Check debug logs for specific error messages
