import 'package:firebase_auth/firebase_auth.dart';
import 'package:artty/firestore/firebase_service.dart';
import 'package:artty/firestore/firestore_data_schema.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  
  // Get current user
  static User? get currentUser => _auth.currentUser;
  
  // Auth state changes stream
  static Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  // Sign up with email and password
  static Future<User?> signUp({
    required String email,
    required String password,
    required String displayName,
    required String username,
    String? bio,
  }) async {
    try {
      final credential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      if (credential.user != null) {
        // Update display name
        await credential.user!.updateDisplayName(displayName);
        
        // Create user profile in Firestore
        final userProfile = UserProfile(
          id: credential.user!.uid,
          email: email,
          displayName: displayName,
          username: username,
          bio: bio,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        );
        
        await FirebaseService.createUserProfile(userProfile);
        
        return credential.user;
      }
      
      return null;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Sign in with email and password
  static Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      
      return credential.user;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Sign out
  static Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }
  
  // Reset password
  static Future<void> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Update password
  static Future<void> updatePassword(String newPassword) async {
    try {
      if (currentUser == null) {
        throw Exception('No user signed in');
      }
      
      await currentUser!.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Update email
  static Future<void> updateEmail(String newEmail) async {
    try {
      if (currentUser == null) {
        throw Exception('No user signed in');
      }
      
      await currentUser!.verifyBeforeUpdateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Delete account
  static Future<void> deleteAccount() async {
    try {
      if (currentUser == null) {
        throw Exception('No user signed in');
      }
      
      final userId = currentUser!.uid;
      
      // Delete user data from Firestore
      // Note: In a production app, you might want to handle this more carefully
      // or use Cloud Functions to clean up user data
      
      await currentUser!.delete();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Send email verification
  static Future<void> sendEmailVerification() async {
    try {
      if (currentUser == null) {
        throw Exception('No user signed in');
      }
      
      await currentUser!.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    }
  }
  
  // Check if email is verified
  static bool get isEmailVerified => currentUser?.emailVerified ?? false;
  
  // Reload user to get updated email verification status
  static Future<void> reloadUser() async {
    if (currentUser != null) {
      await currentUser!.reload();
    }
  }
  
  // Handle auth exceptions and return user-friendly messages
  static String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'weak-password':
        return 'The password provided is too weak.';
      case 'email-already-in-use':
        return 'The account already exists for that email.';
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Wrong password provided for that user.';
      case 'invalid-email':
        return 'The email address is not valid.';
      case 'user-disabled':
        return 'The user account has been disabled.';
      case 'too-many-requests':
        return 'Too many requests. Try again later.';
      case 'operation-not-allowed':
        return 'Signing in with Email and Password is not enabled.';
      case 'invalid-credential':
        return 'The provided credentials are invalid.';
      case 'requires-recent-login':
        return 'This operation requires recent authentication. Please sign in again.';
      default:
        return 'An authentication error occurred: ${e.message}';
    }
  }
}

// Auth state management for widgets
class AuthProvider {
  static Stream<User?> get authStream => AuthService.authStateChanges;
  
  static bool get isSignedIn => AuthService.currentUser != null;
  
  static String? get currentUserId => AuthService.currentUser?.uid;
  
  static String? get currentUserEmail => AuthService.currentUser?.email;
  
  static String? get currentUserDisplayName => AuthService.currentUser?.displayName;
}