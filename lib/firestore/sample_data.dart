import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:artty/firestore/firestore_data_schema.dart';

class SampleDataGenerator {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sample categories
  static final List<Category> sampleCategories = [
    Category(id: 'painting', name: 'Painting', description: 'Traditional and digital paintings', iconName: 'palette'),
    Category(id: 'sculpture', name: 'Sculpture', description: '3D art and sculptures', iconName: 'architecture'),
    Category(id: 'photography', name: 'Photography', description: 'Digital and film photography', iconName: 'photo_camera'),
    Category(id: 'digital', name: 'Digital Art', description: 'Computer-generated artwork', iconName: 'computer'),
    Category(id: 'drawing', name: 'Drawing', description: 'Sketches and illustrations', iconName: 'brush'),
    Category(id: 'mixed_media', name: 'Mixed Media', description: 'Combined art forms', iconName: 'auto_awesome'),
  ];

  // Sample user profiles
  static List<UserProfile> getSampleUsers() {
    final now = DateTime.now();
    return [
      UserProfile(
        id: 'user_1',
        email: 'alex@example.com',
        displayName: 'Alex Rivera',
        username: 'alex_r',
        bio: 'Painter • Digital artist • NYC',
        profileImageUrl: 'https://i.pravatar.cc/150?img=12',
        location: 'New York City',
        specialties: ['Painting', 'Digital Art'],
        followersCount: 12400,
        followingCount: 318,
        artworksCount: 45,
        createdAt: now.subtract(const Duration(days: 365)),
        updatedAt: now,
      ),
      UserProfile(
        id: 'user_2',
        email: 'maya@example.com',
        displayName: 'Maya Chen',
        username: 'maya_creates',
        bio: 'Sculptor & mixed media artist exploring forms',
        profileImageUrl: 'https://i.pravatar.cc/150?img=47',
        location: 'San Francisco',
        specialties: ['Sculpture', 'Mixed Media'],
        followersCount: 8200,
        followingCount: 156,
        artworksCount: 28,
        createdAt: now.subtract(const Duration(days: 200)),
        updatedAt: now,
      ),
      UserProfile(
        id: 'user_3',
        email: 'david@example.com',
        displayName: 'David Park',
        username: 'david_lens',
        bio: 'Street photographer capturing urban life',
        profileImageUrl: 'https://i.pravatar.cc/150?img=31',
        location: 'Los Angeles',
        specialties: ['Photography'],
        followersCount: 15600,
        followingCount: 89,
        artworksCount: 67,
        createdAt: now.subtract(const Duration(days: 450)),
        updatedAt: now,
      ),
    ];
  }

  // Sample artworks
  static List<Artwork> getSampleArtworks() {
    final now = DateTime.now();
    final users = getSampleUsers();
    
    return [
      Artwork(
        id: 'artwork_1',
        title: 'Urban Sunset',
        description: 'A vibrant sunset over the city skyline, painted with acrylics',
        imageUrl: 'https://picsum.photos/600/800?random=1',
        ownerId: users[0].id,
        ownerDisplayName: users[0].displayName,
        ownerProfileImageUrl: users[0].profileImageUrl,
        category: 'painting',
        tags: ['sunset', 'cityscape', 'acrylic'],
        likesCount: 234,
        commentsCount: 12,
        savesCount: 45,
        createdAt: now.subtract(const Duration(days: 5)),
        updatedAt: now.subtract(const Duration(days: 5)),
      ),
      Artwork(
        id: 'artwork_2',
        title: 'Abstract Forms',
        description: 'Exploring the relationship between space and form through mixed media',
        imageUrl: 'https://picsum.photos/600/800?random=2',
        ownerId: users[1].id,
        ownerDisplayName: users[1].displayName,
        ownerProfileImageUrl: users[1].profileImageUrl,
        category: 'mixed_media',
        tags: ['abstract', 'sculpture', 'contemporary'],
        likesCount: 189,
        commentsCount: 8,
        savesCount: 32,
        createdAt: now.subtract(const Duration(days: 3)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
      Artwork(
        id: 'artwork_3',
        title: 'Street Life',
        description: 'Candid moment captured on the streets of downtown LA',
        imageUrl: 'https://picsum.photos/600/800?random=3',
        ownerId: users[2].id,
        ownerDisplayName: users[2].displayName,
        ownerProfileImageUrl: users[2].profileImageUrl,
        category: 'photography',
        tags: ['street', 'black and white', 'documentary'],
        likesCount: 567,
        commentsCount: 23,
        savesCount: 89,
        createdAt: now.subtract(const Duration(days: 1)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      Artwork(
        id: 'artwork_4',
        title: 'Digital Dreams',
        description: 'A futuristic landscape created entirely in digital medium',
        imageUrl: 'https://picsum.photos/600/800?random=4',
        ownerId: users[0].id,
        ownerDisplayName: users[0].displayName,
        ownerProfileImageUrl: users[0].profileImageUrl,
        category: 'digital',
        tags: ['futuristic', 'landscape', 'sci-fi'],
        likesCount: 445,
        commentsCount: 18,
        savesCount: 67,
        createdAt: now.subtract(const Duration(days: 7)),
        updatedAt: now.subtract(const Duration(days: 7)),
      ),
      Artwork(
        id: 'artwork_5',
        title: 'Nature Study',
        description: 'Detailed pencil drawing of botanical specimens',
        imageUrl: 'https://picsum.photos/600/800?random=5',
        ownerId: users[1].id,
        ownerDisplayName: users[1].displayName,
        ownerProfileImageUrl: users[1].profileImageUrl,
        category: 'drawing',
        tags: ['botanical', 'pencil', 'realistic'],
        likesCount: 123,
        commentsCount: 6,
        savesCount: 28,
        createdAt: now.subtract(const Duration(days: 12)),
        updatedAt: now.subtract(const Duration(days: 12)),
      ),
      Artwork(
        id: 'artwork_6',
        title: 'Golden Hour Portrait',
        description: 'Natural light portrait during the golden hour',
        imageUrl: 'https://picsum.photos/600/800?random=6',
        ownerId: users[2].id,
        ownerDisplayName: users[2].displayName,
        ownerProfileImageUrl: users[2].profileImageUrl,
        category: 'photography',
        tags: ['portrait', 'golden hour', 'natural light'],
        likesCount: 789,
        commentsCount: 35,
        savesCount: 134,
        createdAt: now.subtract(const Duration(days: 2)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
    ];
  }

  // Sample events
  static List<Event> getSampleEvents() {
    final now = DateTime.now();
    final users = getSampleUsers();
    
    return [
      Event(
        id: 'event_1',
        title: 'Urban Art Festival',
        description: 'Join us for a day of street art, live painting, and creative workshops in downtown LA',
        imageUrl: 'https://picsum.photos/600/400?random=101',
        organizerId: users[0].id,
        organizerDisplayName: users[0].displayName,
        category: 'Festival',
        location: 'Los Angeles, CA',
        startDate: now.add(const Duration(days: 15)),
        endDate: now.add(const Duration(days: 17)),
        maxParticipants: 500,
        currentParticipants: 234,
        createdAt: now.subtract(const Duration(days: 30)),
        updatedAt: now.subtract(const Duration(days: 5)),
      ),
      Event(
        id: 'event_2',
        title: 'Photography Walk',
        description: 'Explore the city through your lens with fellow photographers',
        imageUrl: 'https://picsum.photos/600/400?random=102',
        organizerId: users[2].id,
        organizerDisplayName: users[2].displayName,
        category: 'Workshop',
        location: 'San Francisco, CA',
        startDate: now.add(const Duration(days: 8)),
        endDate: now.add(const Duration(days: 8, hours: 4)),
        maxParticipants: 25,
        currentParticipants: 18,
        createdAt: now.subtract(const Duration(days: 20)),
        updatedAt: now.subtract(const Duration(days: 2)),
      ),
      Event(
        id: 'event_3',
        title: 'Sculpture Symposium',
        description: 'Contemporary sculpture techniques and discussions with leading artists',
        imageUrl: 'https://picsum.photos/600/400?random=103',
        organizerId: users[1].id,
        organizerDisplayName: users[1].displayName,
        category: 'Symposium',
        location: 'New York, NY',
        startDate: now.add(const Duration(days: 25)),
        endDate: now.add(const Duration(days: 27)),
        maxParticipants: 100,
        currentParticipants: 67,
        createdAt: now.subtract(const Duration(days: 45)),
        updatedAt: now.subtract(const Duration(days: 1)),
      ),
      Event(
        id: 'event_4',
        title: 'Digital Art Bootcamp',
        description: 'Intensive weekend workshop on digital art techniques and tools',
        imageUrl: 'https://picsum.photos/600/400?random=104',
        organizerId: users[0].id,
        organizerDisplayName: users[0].displayName,
        category: 'Workshop',
        location: 'Austin, TX',
        startDate: now.add(const Duration(days: 35)),
        endDate: now.add(const Duration(days: 37)),
        maxParticipants: 30,
        currentParticipants: 12,
        createdAt: now.subtract(const Duration(days: 25)),
        updatedAt: now.subtract(const Duration(days: 3)),
      ),
    ];
  }

  // Method to populate sample data (for development only)
  static Future<void> populateSampleData() async {
    try {
      // Add categories
      for (final category in sampleCategories) {
        await _firestore.collection('categories').doc(category.id).set(category.toJson());
      }

      // Add users
      for (final user in getSampleUsers()) {
        await _firestore.collection('users').doc(user.id).set(user.toJson());
      }

      // Add artworks
      for (final artwork in getSampleArtworks()) {
        await _firestore.collection('artworks').doc(artwork.id).set(artwork.toJson());
      }

      // Add events
      for (final event in getSampleEvents()) {
        await _firestore.collection('events').doc(event.id).set(event.toJson());
      }

      print('Sample data populated successfully!');
    } catch (e) {
      print('Error populating sample data: $e');
    }
  }
}