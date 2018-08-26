import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class PostStoryData {}

class StoryData {
  String image;
  String storytext;
  double longitude;
  double latitude;
  String userId;
  String projectId;

  StoryData(
      {this.image,
      this.storytext,
      this.longitude,
      this.latitude,
      this.userId,
      this.projectId});

  factory StoryData.fromJson(Map<String, dynamic> json) {
    return StoryData(
        image: json['image'] as String,
        storytext: json['storytext'] as String,
        longitude: json['longitude'] as double,
        latitude: json['latitude'] as double,
        userId: json['userId'] as String,
        projectId: json['projectId'] as String);
  }

  Map<String, dynamic> toJson() => {
        'image': image,
        'storytext': storytext,
        'longitude': longitude,
        'latitude': latitude,
        'userId': userId,
        'projectId': projectId,
      };
}
