import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:typed_data';

String baseUrl = 'https://charitypath.blockchain2b.ch/';

class GetUserData {
  Future<List<UserData>> fetchUsers(http.Client client) async {
    final response =
        await client.get('https://charitypath.blockchain2b.ch/users');

    //await Future.delayed(Duration(milliseconds: 50));

    return parseStrings(response.body);
  }

  List<UserData> parseStrings(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<UserData>((json) => UserData.fromJson(json)).toList();
  }
}

class UserData {
  String id;
  String name;
  String email;
  String password;
  bool isLocalBoy;

  UserData({this.id, this.name, this.email, this.password, this.isLocalBoy});

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        id: json['id'] as String,
        name: json['name'] as String,
        email: json['email'] as String,
        password: json['password'] as String,
        isLocalBoy: json['isLocalBoy'] as bool);
  }
  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getEmail() {
    return email;
  }

  String getPassword() {
    return password;
  }

  bool getIsLocalBoy() {
    return isLocalBoy;
  }
}

class GetTopicData {
  Future<List<TopicData>> fetchTopics(http.Client client) async {
    final response =
    await client.get('https://charitypath.blockchain2b.ch/topics');

    //await Future.delayed(Duration(milliseconds: 50));

    return parseTopics(response.body);
  }

  List<TopicData> parseTopics(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();

    return parsed.map<TopicData>((json) => TopicData.fromJson(json)).toList();
  }
}

class TopicData {
  String id;
  String name;
  String imageBase64;
  String description;



  TopicData({this.id, this.name, this.imageBase64, this.description});

  factory TopicData.fromJson(Map<String, dynamic> json) {
    return TopicData(
        id: json['id'] as String,
        name: json['name'] as String,
        imageBase64: json['image'] as String,
        description: json['description'] as String);
  }
  String getId() {
    return id;
  }

  String getName() {
    return name;
  }

  String getImage() {
    return imageBase64;
  }

  String getDescription() {
    return description;
  }
}
