# Firebase Integration for Artty

This document outlines the Firebase setup and integration for the Artty art-sharing social media app.

## 🔥 Firebase Services Integrated

- **Firebase Authentication**: User signup, signin, and session management
- **Cloud Firestore**: NoSQL database for storing user profiles, artworks, comments, likes, follows, events, and categories
- **Firebase Storage**: (Ready for file uploads like artwork images and profile pictures)

## 📁 Project Structure

```
lib/
├── firestore/
│   ├── firestore_data_schema.dart  # Data models and schemas
│   ├── firebase_service.dart       # Main service layer for Firestore operations
│   ├── auth_service.dart          # Authentication service wrapper
│   └── sample_data.dart           # Sample data generator for development
├── widgets/
│   └── auth_wrapper.dart          # Authentication state management widget
└── screens/
    ├── sign_in_screen.dart        # Updated with Firebase auth
    └── profile_screen.dart        # Updated with Firebase logout
```

## 🗄️ Database Schema

### Collections

1. **users** - User profiles
   - Fields: email, display_name, username, bio, profile_image_url, location, specialties, followers_count, following_count, artworks_count
   - Security: Public read, owner write

2. **artworks** - Art posts and images
   - Fields: title, description, image_url, owner_id, category, tags, likes_count, comments_count, saves_count
   - Security: Public read, owner write

3. **comments** - Comments on artworks
   - Fields: artwork_id, content, owner_id, owner_display_name
   - Security: Signed-in users can read/create, owner can modify

4. **likes** - Artwork likes/hearts
   - Fields: artwork_id, owner_id
   - Security: Signed-in users can read/create, owner can delete

5. **saves** - Saved/bookmarked artworks
   - Fields: artwork_id, owner_id
   - Security: Private to user (owner only)

6. **follows** - User follow relationships
   - Fields: follower_id, following_id
   - Security: Follower can manage their follows

7. **events** - Art events and exhibitions
   - Fields: title, description, organizer_id, category, location, start_date, end_date, max_participants
   - Security: Public read, organizer write

8. **categories** - Art categories
   - Fields: name, description, icon_name, artworks_count
   - Security: Public read only

## 🔐 Security Rules

The Firestore security rules follow the principle of least privilege:

- **Private data**: Only accessible by the owner (saves, user follows)
- **Signed-in only**: Comments, likes require authentication
- **Public read**: Artworks, events, user profiles, categories are publicly readable
- **Owner write**: Users can only modify their own content

## 🚀 Usage Examples

### Authentication

```dart
// Sign up new user
final user = await AuthService.signUp(
  email: 'user@example.com',
  password: 'password123',
  displayName: 'John Doe',
  username: 'johndoe',
);

// Sign in existing user
final user = await AuthService.signIn(
  email: 'user@example.com',
  password: 'password123',
);

// Sign out
await AuthService.signOut();
```

### Firestore Operations

```dart
// Get artworks stream
Stream<List<Artwork>> artworks = FirebaseService.getArtworksStream(
  category: 'painting',
  limit: 20,
);

// Like an artwork
await FirebaseService.likeArtwork(artworkId, userId);

// Add comment
await FirebaseService.addComment(comment);

// Follow user
await FirebaseService.followUser(followerId, followingId);
```

### Real-time Updates

```dart
// Listen to user profile changes
StreamBuilder<UserProfile?>(
  stream: FirebaseService.getUserProfileStream(userId),
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      return ProfileWidget(profile: snapshot.data!);
    }
    return LoadingWidget();
  },
);
```

## 🔧 Development Setup

1. **Install Dependencies**: The following Firebase packages are included:
   - `firebase_core: '>=2.21.1'`
   - `firebase_auth: '>=5.3.3'`
   - `cloud_firestore: '>=5.5.0'`

2. **Firebase Initialization**: Firebase is initialized in `main.dart` using `DefaultFirebaseOptions.currentPlatform`

3. **Authentication Flow**: The `AuthWrapper` widget manages authentication state and shows appropriate screens

4. **Sample Data**: Use `SampleDataGenerator.populateSampleData()` to populate the database with sample data for development

## 📋 Deployment Checklist

- [ ] Configure Firestore security rules: `firebase deploy --only firestore:rules`
- [ ] Deploy Firestore indexes: `firebase deploy --only firestore:indexes`
- [ ] Set up Firebase project settings
- [ ] Configure authentication providers (Email/Password is enabled by default)
- [ ] Set up proper error handling and user feedback
- [ ] Test security rules with different user scenarios

## 🎨 Key Features Ready for Implementation

- User registration and authentication ✅
- Real-time artwork feed with filtering ✅
- Like and save artwork functionality ✅
- Comment system ✅ 
- Follow/unfollow users ✅
- Event creation and participation (ready)
- Category-based browsing ✅
- User profile management ✅

## 🔄 State Management

The Firebase integration uses Flutter's built-in `StreamBuilder` widgets for real-time data updates. Consider implementing a state management solution like Provider or Bloc for more complex state scenarios.

## 🔍 Indexes

Composite indexes are automatically created for common query patterns:
- Artworks by category and date
- Artworks by category and popularity (likes)
- Comments by artwork and date
- Events by location and date
- User follows by relationships

## 🛠️ Next Steps

1. Integrate image upload functionality with Firebase Storage
2. Implement push notifications for likes, comments, follows
3. Add search functionality with full-text search
4. Implement content moderation
5. Add analytics and performance monitoring