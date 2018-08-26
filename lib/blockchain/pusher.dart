import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:async';

class GetStoryData {
  String projectId;

  GetStoryData(this.projectId);

  Future<List<StoryData>> fetchStoryData(http.Client client) async {
    final response = await client
        .get('https://charitypath.blockchain2b.ch/stories/' + projectId);

    //await Future.delayed(Duration(milliseconds: 50));

    return parseStoryData(response.body);
  }

  List<StoryData> parseStoryData(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed
        .map<StoryData>((json) => StoryData.fromJson(json))
        .toList();
  }
}

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


class DonationData {
  String userId;
  String topicId;
  int money;

  DonationData(
      {
        this.userId,
        this.topicId,
      this.money});

  factory DonationData.fromJson(Map<String, dynamic> json) {
    return DonationData(
        userId: json['userId'] as String,
        topicId: json['projectId'] as String,
    money: json['money'] as int);
  }

  Map<String, dynamic> toJson() => {
    'userId': userId,
    'topicId': topicId,
    'money': money,
  };
}
