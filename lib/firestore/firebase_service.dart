import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:artty/firestore/firestore_data_schema.dart';

class FirebaseService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;

  // Current user
  static User? get currentUser => _auth.currentUser;
  static Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Authentication
  static Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Sign in failed: $e');
    }
  }

  static Future<UserCredential?> createUserWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      throw Exception('Sign up failed: $e');
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  // User Profile Operations
  static Future<void> createUserProfile(UserProfile profile) async {
    await _firestore.collection('users').doc(profile.id).set(profile.toJson());
  }

  static Future<UserProfile?> getUserProfile(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return UserProfile.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  static Future<void> updateUserProfile(String userId, Map<String, dynamic> updates) async {
    updates['updated_at'] = FieldValue.serverTimestamp();
    await _firestore.collection('users').doc(userId).update(updates);
  }

  static Stream<UserProfile?> getUserProfileStream(String userId) {
    return _firestore.collection('users').doc(userId).snapshots().map((doc) {
      if (doc.exists) {
        return UserProfile.fromJson(doc.data()!, doc.id);
      }
      return null;
    });
  }

  // Artwork Operations
  static Future<String> createArtwork(Artwork artwork) async {
    final docRef = await _firestore.collection('artworks').add(artwork.toJson());
    
    // Update user's artwork count
    await _firestore.collection('users').doc(artwork.ownerId).update({
      'artworks_count': FieldValue.increment(1),
    });
    
    return docRef.id;
  }

  static Future<Artwork?> getArtwork(String artworkId) async {
    final doc = await _firestore.collection('artworks').doc(artworkId).get();
    if (doc.exists) {
      return Artwork.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  static Future<void> updateArtwork(String artworkId, Map<String, dynamic> updates) async {
    updates['updated_at'] = FieldValue.serverTimestamp();
    await _firestore.collection('artworks').doc(artworkId).update(updates);
  }

  static Future<void> deleteArtwork(String artworkId, String ownerId) async {
    await _firestore.collection('artworks').doc(artworkId).delete();
    
    // Update user's artwork count
    await _firestore.collection('users').doc(ownerId).update({
      'artworks_count': FieldValue.increment(-1),
    });
  }

  static Stream<List<Artwork>> getArtworksStream({
    String? category,
    String? ownerId,
    int limit = 20,
  }) {
    Query query = _firestore.collection('artworks');
    
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    
    if (ownerId != null) {
      query = query.where('owner_id', isEqualTo: ownerId);
    }
    
    query = query.orderBy('created_at', descending: true).limit(limit);
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Artwork.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  static Stream<List<Artwork>> getPopularArtworksStream({
    String? category,
    int limit = 20,
  }) {
    Query query = _firestore.collection('artworks');
    
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    
    query = query.orderBy('likes_count', descending: true).limit(limit);
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Artwork.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Like Operations
  static Future<void> likeArtwork(String artworkId, String userId) async {
    final likeId = '${userId}_$artworkId';
    
    await _firestore.runTransaction((transaction) async {
      // Add like document
      transaction.set(_firestore.collection('likes').doc(likeId), {
        'artwork_id': artworkId,
        'owner_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      });
      
      // Increment likes count
      transaction.update(_firestore.collection('artworks').doc(artworkId), {
        'likes_count': FieldValue.increment(1),
      });
    });
  }

  static Future<void> unlikeArtwork(String artworkId, String userId) async {
    final likeId = '${userId}_$artworkId';
    
    await _firestore.runTransaction((transaction) async {
      // Remove like document
      transaction.delete(_firestore.collection('likes').doc(likeId));
      
      // Decrement likes count
      transaction.update(_firestore.collection('artworks').doc(artworkId), {
        'likes_count': FieldValue.increment(-1),
      });
    });
  }

  static Future<bool> isArtworkLiked(String artworkId, String userId) async {
    final likeId = '${userId}_$artworkId';
    final doc = await _firestore.collection('likes').doc(likeId).get();
    return doc.exists;
  }

  // Save/Bookmark Operations
  static Future<void> saveArtwork(String artworkId, String userId) async {
    final saveId = '${userId}_$artworkId';
    
    await _firestore.runTransaction((transaction) async {
      // Add save document
      transaction.set(_firestore.collection('saves').doc(saveId), {
        'artwork_id': artworkId,
        'owner_id': userId,
        'created_at': FieldValue.serverTimestamp(),
      });
      
      // Increment saves count
      transaction.update(_firestore.collection('artworks').doc(artworkId), {
        'saves_count': FieldValue.increment(1),
      });
    });
  }

  static Future<void> unsaveArtwork(String artworkId, String userId) async {
    final saveId = '${userId}_$artworkId';
    
    await _firestore.runTransaction((transaction) async {
      // Remove save document
      transaction.delete(_firestore.collection('saves').doc(saveId));
      
      // Decrement saves count
      transaction.update(_firestore.collection('artworks').doc(artworkId), {
        'saves_count': FieldValue.increment(-1),
      });
    });
  }

  static Future<bool> isArtworkSaved(String artworkId, String userId) async {
    final saveId = '${userId}_$artworkId';
    final doc = await _firestore.collection('saves').doc(saveId).get();
    return doc.exists;
  }

  static Stream<List<Artwork>> getSavedArtworksStream(String userId) {
    return _firestore
        .collection('saves')
        .where('owner_id', isEqualTo: userId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      final artworkIds = snapshot.docs.map((doc) => doc.data()['artwork_id'] as String).toList();
      
      if (artworkIds.isEmpty) return <Artwork>[];
      
      final artworkDocs = await _firestore.collection('artworks').where(FieldPath.documentId, whereIn: artworkIds).get();
      return artworkDocs.docs.map((doc) => Artwork.fromJson(doc.data(), doc.id)).toList();
    });
  }

  // Comment Operations
  static Future<String> addComment(Comment comment) async {
    final docRef = await _firestore.collection('comments').add(comment.toJson());
    
    // Increment comments count
    await _firestore.collection('artworks').doc(comment.artworkId).update({
      'comments_count': FieldValue.increment(1),
    });
    
    return docRef.id;
  }

  static Future<void> deleteComment(String commentId, String artworkId) async {
    await _firestore.collection('comments').doc(commentId).delete();
    
    // Decrement comments count
    await _firestore.collection('artworks').doc(artworkId).update({
      'comments_count': FieldValue.increment(-1),
    });
  }

  static Stream<List<Comment>> getCommentsStream(String artworkId) {
    return _firestore
        .collection('comments')
        .where('artwork_id', isEqualTo: artworkId)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Comment.fromJson(doc.data(), doc.id)).toList();
    });
  }

  // Follow Operations
  static Future<void> followUser(String followerId, String followingId) async {
    final followId = '${followerId}_$followingId';
    
    await _firestore.runTransaction((transaction) async {
      // Add follow document
      transaction.set(_firestore.collection('follows').doc(followId), {
        'follower_id': followerId,
        'following_id': followingId,
        'created_at': FieldValue.serverTimestamp(),
      });
      
      // Update follower count
      transaction.update(_firestore.collection('users').doc(followingId), {
        'followers_count': FieldValue.increment(1),
      });
      
      // Update following count
      transaction.update(_firestore.collection('users').doc(followerId), {
        'following_count': FieldValue.increment(1),
      });
    });
  }

  static Future<void> unfollowUser(String followerId, String followingId) async {
    final followId = '${followerId}_$followingId';
    
    await _firestore.runTransaction((transaction) async {
      // Remove follow document
      transaction.delete(_firestore.collection('follows').doc(followId));
      
      // Update follower count
      transaction.update(_firestore.collection('users').doc(followingId), {
        'followers_count': FieldValue.increment(-1),
      });
      
      // Update following count
      transaction.update(_firestore.collection('users').doc(followerId), {
        'following_count': FieldValue.increment(-1),
      });
    });
  }

  static Future<bool> isFollowingUser(String followerId, String followingId) async {
    final followId = '${followerId}_$followingId';
    final doc = await _firestore.collection('follows').doc(followId).get();
    return doc.exists;
  }

  // Event Operations
  static Future<String> createEvent(Event event) async {
    final docRef = await _firestore.collection('events').add(event.toJson());
    return docRef.id;
  }

  static Future<Event?> getEvent(String eventId) async {
    final doc = await _firestore.collection('events').doc(eventId).get();
    if (doc.exists) {
      return Event.fromJson(doc.data()!, doc.id);
    }
    return null;
  }

  static Stream<List<Event>> getEventsStream({
    String? category,
    String? location,
    int limit = 20,
  }) {
    Query query = _firestore.collection('events');
    
    if (category != null && category.isNotEmpty) {
      query = query.where('category', isEqualTo: category);
    }
    
    if (location != null && location.isNotEmpty) {
      query = query.where('location', isEqualTo: location);
    }
    
    query = query.orderBy('start_date', descending: false).limit(limit);
    
    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>, doc.id)).toList();
    });
  }

  // Categories
  static Stream<List<Category>> getCategoriesStream() {
    return _firestore
        .collection('categories')
        .where('is_active', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) => Category.fromJson(doc.data(), doc.id)).toList();
    });
  }
}