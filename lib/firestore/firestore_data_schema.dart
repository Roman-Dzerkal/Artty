import 'package:cloud_firestore/cloud_firestore.dart';

// User Profile Model
class UserProfile {
  final String id;
  final String email;
  final String displayName;
  final String username;
  final String? bio;
  final String? profileImageUrl;
  final String? location;
  final List<String> specialties;
  final int followersCount;
  final int followingCount;
  final int artworksCount;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    required this.email,
    required this.displayName,
    required this.username,
    this.bio,
    this.profileImageUrl,
    this.location,
    this.specialties = const [],
    this.followersCount = 0,
    this.followingCount = 0,
    this.artworksCount = 0,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json, String id) {
    return UserProfile(
      id: id,
      email: json['email'] ?? '',
      displayName: json['display_name'] ?? '',
      username: json['username'] ?? '',
      bio: json['bio'],
      profileImageUrl: json['profile_image_url'],
      location: json['location'],
      specialties: List<String>.from(json['specialties'] ?? []),
      followersCount: json['followers_count'] ?? 0,
      followingCount: json['following_count'] ?? 0,
      artworksCount: json['artworks_count'] ?? 0,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'display_name': displayName,
      'username': username,
      'bio': bio,
      'profile_image_url': profileImageUrl,
      'location': location,
      'specialties': specialties,
      'followers_count': followersCount,
      'following_count': followingCount,
      'artworks_count': artworksCount,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}

// Artwork Model
class Artwork {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String ownerId;
  final String ownerDisplayName;
  final String? ownerProfileImageUrl;
  final String category;
  final List<String> tags;
  final int likesCount;
  final int commentsCount;
  final int savesCount;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  Artwork({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.ownerId,
    required this.ownerDisplayName,
    this.ownerProfileImageUrl,
    required this.category,
    this.tags = const [],
    this.likesCount = 0,
    this.commentsCount = 0,
    this.savesCount = 0,
    this.isPublic = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Artwork.fromJson(Map<String, dynamic> json, String id) {
    return Artwork(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'] ?? '',
      ownerId: json['owner_id'] ?? '',
      ownerDisplayName: json['owner_display_name'] ?? '',
      ownerProfileImageUrl: json['owner_profile_image_url'],
      category: json['category'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
      likesCount: json['likes_count'] ?? 0,
      commentsCount: json['comments_count'] ?? 0,
      savesCount: json['saves_count'] ?? 0,
      isPublic: json['is_public'] ?? true,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'owner_id': ownerId,
      'owner_display_name': ownerDisplayName,
      'owner_profile_image_url': ownerProfileImageUrl,
      'category': category,
      'tags': tags,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'saves_count': savesCount,
      'is_public': isPublic,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}

// Comment Model
class Comment {
  final String id;
  final String artworkId;
  final String content;
  final String ownerId;
  final String ownerDisplayName;
  final String? ownerProfileImageUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  Comment({
    required this.id,
    required this.artworkId,
    required this.content,
    required this.ownerId,
    required this.ownerDisplayName,
    this.ownerProfileImageUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Comment.fromJson(Map<String, dynamic> json, String id) {
    return Comment(
      id: id,
      artworkId: json['artwork_id'] ?? '',
      content: json['content'] ?? '',
      ownerId: json['owner_id'] ?? '',
      ownerDisplayName: json['owner_display_name'] ?? '',
      ownerProfileImageUrl: json['owner_profile_image_url'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId,
      'content': content,
      'owner_id': ownerId,
      'owner_display_name': ownerDisplayName,
      'owner_profile_image_url': ownerProfileImageUrl,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}

// Like Model
class Like {
  final String id;
  final String artworkId;
  final String ownerId;
  final DateTime createdAt;

  Like({
    required this.id,
    required this.artworkId,
    required this.ownerId,
    required this.createdAt,
  });

  factory Like.fromJson(Map<String, dynamic> json, String id) {
    return Like(
      id: id,
      artworkId: json['artwork_id'] ?? '',
      ownerId: json['owner_id'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId,
      'owner_id': ownerId,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}

// Save/Bookmark Model
class Save {
  final String id;
  final String artworkId;
  final String ownerId;
  final DateTime createdAt;

  Save({
    required this.id,
    required this.artworkId,
    required this.ownerId,
    required this.createdAt,
  });

  factory Save.fromJson(Map<String, dynamic> json, String id) {
    return Save(
      id: id,
      artworkId: json['artwork_id'] ?? '',
      ownerId: json['owner_id'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'artwork_id': artworkId,
      'owner_id': ownerId,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}

// Follow Model
class Follow {
  final String id;
  final String followerId;
  final String followingId;
  final DateTime createdAt;

  Follow({
    required this.id,
    required this.followerId,
    required this.followingId,
    required this.createdAt,
  });

  factory Follow.fromJson(Map<String, dynamic> json, String id) {
    return Follow(
      id: id,
      followerId: json['follower_id'] ?? '',
      followingId: json['following_id'] ?? '',
      createdAt: (json['created_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'follower_id': followerId,
      'following_id': followingId,
      'created_at': Timestamp.fromDate(createdAt),
    };
  }
}

// Event Model
class Event {
  final String id;
  final String title;
  final String description;
  final String? imageUrl;
  final String organizerId;
  final String organizerDisplayName;
  final String category;
  final String location;
  final DateTime startDate;
  final DateTime endDate;
  final int maxParticipants;
  final int currentParticipants;
  final bool isPublic;
  final DateTime createdAt;
  final DateTime updatedAt;

  Event({
    required this.id,
    required this.title,
    required this.description,
    this.imageUrl,
    required this.organizerId,
    required this.organizerDisplayName,
    required this.category,
    required this.location,
    required this.startDate,
    required this.endDate,
    this.maxParticipants = 0,
    this.currentParticipants = 0,
    this.isPublic = true,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Event.fromJson(Map<String, dynamic> json, String id) {
    return Event(
      id: id,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      imageUrl: json['image_url'],
      organizerId: json['organizer_id'] ?? '',
      organizerDisplayName: json['organizer_display_name'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      startDate: (json['start_date'] as Timestamp).toDate(),
      endDate: (json['end_date'] as Timestamp).toDate(),
      maxParticipants: json['max_participants'] ?? 0,
      currentParticipants: json['current_participants'] ?? 0,
      isPublic: json['is_public'] ?? true,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'organizer_id': organizerId,
      'organizer_display_name': organizerDisplayName,
      'category': category,
      'location': location,
      'start_date': Timestamp.fromDate(startDate),
      'end_date': Timestamp.fromDate(endDate),
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'is_public': isPublic,
      'created_at': Timestamp.fromDate(createdAt),
      'updated_at': Timestamp.fromDate(updatedAt),
    };
  }
}

// Category Model
class Category {
  final String id;
  final String name;
  final String? description;
  final String? iconName;
  final int artworksCount;
  final bool isActive;

  Category({
    required this.id,
    required this.name,
    this.description,
    this.iconName,
    this.artworksCount = 0,
    this.isActive = true,
  });

  factory Category.fromJson(Map<String, dynamic> json, String id) {
    return Category(
      id: id,
      name: json['name'] ?? '',
      description: json['description'],
      iconName: json['icon_name'],
      artworksCount: json['artworks_count'] ?? 0,
      isActive: json['is_active'] ?? true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'icon_name': iconName,
      'artworks_count': artworksCount,
      'is_active': isActive,
    };
  }
}