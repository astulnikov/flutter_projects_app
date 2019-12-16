import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:projects_app/model/Post.dart';
import 'package:projects_app/model/Project.dart';

const BASE_URL = "my-json-server.typicode.com/astulnikov/flutter_projects_app";

Future<List<Post>> fetchNews(
    String projectId, int startIndex, int limit) async {
  final response = await http.get('$BASE_URL/news?project=$projectId');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return compute(parseNews, response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load news');
  }
}

List<Post> parseNews(String responseBody) {
  final parsed = json.decode(responseBody);
  final data = parsed['data'].cast<Map<String, dynamic>>();
  return data.map<Post>((json) => Post.fromJson(json)).toList();
}

Future<List<Project>> fetchProjects(int startIndex, int limit) async {
  final response = await http.get('$BASE_URL/projects');

  if (response.statusCode == 200) {
    // If the call to the server was successful, parse the JSON.
    return compute(parseProjects, response.body);
  } else {
    // If that call was not successful, throw an error.
    throw Exception('Failed to load projects');
  }
}

List<Project> parseProjects(String responseBody) {
  final parsed = json.decode(responseBody);
  final data = parsed['data'].cast<Map<String, dynamic>>();
  return data.map<Project>((json) => Project.fromJson(json)).toList();
}
