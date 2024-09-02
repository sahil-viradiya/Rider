import 'package:firebase_auth/firebase_auth.dart';
import 'dart:developer';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> verifyPhoneNumber({
    required String phoneCode,
    required String mobileNumber,
    required void Function(String, int?) codeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(String) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout, 
  }) async {
    final fullPhoneNumber = '$phoneCode$mobileNumber'.trim();

    log("Starting phone number verification for: $fullPhoneNumber");

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) async {
          log("Verification completed with credential: $credential");
          onVerificationCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          log("Verification failed: ${e.message}");
          onVerificationFailed(e.message ?? "Unknown error occurred.");
        },
        codeSent: codeSent,
        // (String verificationId, int? resendToken) {
        //   log("Code sent to $fullPhoneNumber. Verification ID: $verificationId");
        //   onCodeSent();
        // },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("Auto-retrieval timeout for verification ID: $verificationId");
          onCodeAutoRetrievalTimeout(verificationId);
        },
        timeout: const Duration(seconds: 60), // Set a timeout duration for auto-retrieval
      );
    } catch (e) {
      log("An error occurred during phone number verification: $e");
      onVerificationFailed("Failed to verify phone number. Please try again.");
    }
  }
// verifyOTP
   Future<void> verifyOtp({
    required String verificationId,
    required String otpCode,
    required Function(UserCredential) onVerificationSuccess,
    required Function(String) onVerificationFailed,
  }) async {
    log("Attempting to verify OTP: $otpCode with verification ID: $verificationId");

    try {
      // Create a credential using the verification ID and the OTP code
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otpCode.trim(),
      );

      // Sign in with the credential
      UserCredential userCredential = await _auth.signInWithCredential(credential);

      log("OTP verification successful. User ID: ${userCredential.user?.uid}");
      onVerificationSuccess(userCredential); // Call success callback
    } on FirebaseAuthException catch (e) {
      log("OTP verification failed: ${e.message}");
      onVerificationFailed(e.message ?? "Unknown error occurred during OTP verification."); // Call failure callback
    } catch (e) {
      log("An unexpected error occurred: $e");
      onVerificationFailed("Failed to verify OTP. Please try again.");
    }
  }

  //resend otp

   Future<void> resendOtp({
    required String phoneCode,
    required String mobileNumber,
    required Function(String verificationId, int? resendToken) onCodeSent,
    required Function(PhoneAuthCredential) onVerificationCompleted,
    required Function(String) onVerificationFailed,
    required Function(String) onCodeAutoRetrievalTimeout,
    int? resendToken, // Optional: Used if you need to resend using the same session
  }) async {
    final fullPhoneNumber = '$phoneCode$mobileNumber'.trim();

    log("Resending OTP to: $fullPhoneNumber");

    try {
      await _auth.verifyPhoneNumber(
        phoneNumber: fullPhoneNumber,
        forceResendingToken: resendToken, // Use the existing resendToken if available
        verificationCompleted: (PhoneAuthCredential credential) async {
          log("Verification completed with credential: $credential");
          onVerificationCompleted(credential);
        },
        verificationFailed: (FirebaseAuthException e) {
          log("Verification failed during OTP resend: ${e.message}");
          onVerificationFailed(e.message ?? "Unknown error occurred during OTP resend.");
        },
        codeSent: (String verificationId, int? newResendToken) {
          log("OTP resent successfully. Verification ID: $verificationId");
          onCodeSent(verificationId, newResendToken); // Pass the new resend token if provided
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          log("Auto-retrieval timeout for verification ID during OTP resend: $verificationId");
          onCodeAutoRetrievalTimeout(verificationId);
        },
        timeout: const Duration(seconds: 60), // Optional: Set a custom timeout for auto-retrieval
      );
    } catch (e) {
      log("An error occurred during OTP resend: $e");
      onVerificationFailed("Failed to resend OTP. Please try again.");
    }
  }
}
