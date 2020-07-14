import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snd_events/data/urls.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/models/event.dart';
import 'package:snd_events/models/topic.dart';
import 'package:snd_events/models/user.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:snd_events/enums/event_type.dart';
//
// Uploading media files
//
import 'package:http_parser/http_parser.dart';

class Repository {
  Dio dio;
  Repository({token}) {
    if (token != null) {
      dio = new Dio();
      dio.options.headers.addAll({
        HttpHeaders.authorizationHeader: 'Token $token',
        HttpHeaders.contentTypeHeader: 'application/json'
      });
    }
  }
  Future<Map> register({name, email, password, country, city}) async {
    var res = await http.post(Urls.REGISTER, body: {
      "email": email,
      "password1": password,
      "password2": password,
      "name": name,
      "country": country,
      "city": city
    }).catchError((onError) {
      print("$onError");
    });
    var data = json.decode(res.body);
    print(data);
    return data;
  }

  Future<Map> login({email, password}) async {
    var res = await http.post(Urls.LOGIN, body: {
      "email": email,
      "password": password,
    }).catchError((onError) {
      print("$onError");
    });
    var data = json.decode(res.body);
    // _savePrefs(data['token']);
    print(data);
    //var map
    return data;
  }

  Future<Map<String, dynamic>> loadPrefs() async {
    var prefs = await SharedPreferences.getInstance();
    Map<String, dynamic> map = {
      Constants.USER_TOKEN: prefs.getString(Constants.USER_TOKEN),
      Constants.KEY_EMAIL: prefs.getString(Constants.KEY_EMAIL),
      Constants.KEY_PROFILE_PHOTO: prefs.getString(Constants.KEY_PROFILE_PHOTO),
    };
    return map;
  }

  Future logout() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.clear();
  }

  Future savePrefs(token, email) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString(Constants.USER_TOKEN, token);
    prefs.setString(Constants.KEY_EMAIL, email);
  }

  Future<bool> photoPrefs(photoUrl) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setString(Constants.KEY_PROFILE_PHOTO, photoUrl);
  }

  Future changePassword({token, oldPassword, newPassword}) async {
    var res = await http.put(Urls.CHANGE_PASSWORD, headers: {
      HttpHeaders.authorizationHeader: 'Token $token'
    }, body: {
      'old_password': oldPassword,
      'new_password1': newPassword,
      'new_password2': newPassword
    });

    return json.decode(res.body);
  }

  Future<User> getUserProfile(token) async {
    var res = await http.get(
      Urls.USER_PROFILE,
      headers: {HttpHeaders.authorizationHeader: 'Token $token'},
    );
    var user = User.fromJson(json.decode(res.body));
    print(user.email);
    print(user.children.length);
    return user;
  }

  //////////////////////////////////Starting////////////////////////

  Future<Map> addProfession({token, prof, desc, spec}) async {
    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio.post(Urls.ADD_PROFESSION, data: {
      'prof': prof,
      'any_info': desc,
      'spec': [1, 2]
    });
    return res.data;
  }

  Future<Map> addEvent(
      {token,
      theme,
      startDate,
      endDate,
      locationDistrict,
      buildingStreet,
      speaker,
      startTime,
      endTime,
      country,
      File file}) async {
    var dio = Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      // HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio
        .post(Urls.ADD_MEETUP,
            data: FormData.fromMap({
              'theme': theme,
              "start_date": startDate,
              "start_time": startTime,
              "location_district": locationDistrict,
              "building_street": buildingStreet,
              "speaker": speaker,
              "end_date": endDate,
              "end_time": endTime,
              "location_country": country,
              "photo": await _createMultipartFile(file),
            }))
        .catchError((onError) {
      print(onError);
    });

    print(res.data);
    return res.data;
  }

  Future<Map> addCommunity(
      {token,
      name,
      desc,
      locationDistrict,
      topics,
      country,
      File photo}) async {
    var dio = Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio
        .post(Urls.ADD_COMMUNITY,
            data: FormData.fromMap({
              "name": name,
              'describe': desc,
              'location_district': locationDistrict,
              'topics': topics,
              'location_country': country,
              'image': await _createMultipartFile(photo),
            }))
        .catchError((onError) {
      print(onError);
      //return {'ServerError' : onError};
    });

    return res.data;
  }

  Future<Map> addTopic({token, title, desc, conditions}) async {
    var dio = Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio.post(Urls.ADD_TOPICS, data: {
      "title": title,
      'details': desc,
      'condition': conditions,
    }).catchError((onError) {
      print(onError);
    });

    return res.data;
  }

  Future<Map> addChild(
      {token, firstname, lastname, gender, dob, conditions}) async {
    print("token: $token");
    print(firstname);
    print(lastname);
    print(gender);
    print(dob);
    print(conditions);
    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    Response res = await dio.post(Urls.ADD_CHILD, data: {
      "full_name": "$firstname $lastname",
      "gender": gender,
      "dob": "2019-06-23",
      "condition": conditions
    }).catchError((onError) {
      print('Catch error: $onError');
    });
    // Response is returned as a Map
    var data = res.data;
    print(data);
    return data;
  }

  Future<Map> updateProfile({name, email, File file}) async {
    var formData = FormData.fromMap({
      // "name": name,
      // "email": email,
      "photo": await _createMultipartFile(file),
    });
    var res =
        await dio.put(Urls.PHOTO_UPDATE, data: formData).catchError((onError) {
      print("Catch Error: $onError");
    });
    return res.data;
  }

  Future<List<Event>> getMyMeetups(EventType eventType, {token}) async {
    var url;
    if (eventType == EventType.Going) url = Urls.MY_MEETUPS;
    if (eventType == EventType.Saved) url = Urls.SAVED_MEETUPS;
    if (eventType == EventType.Suggested) url = Urls.SUGGESTED_MEETUPS;

    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio.get(url).catchError((onError) {
      print("Catch Error: $onError");
    });
    // print('Data: ${res.data}');
    var listEvents = (res.data['results'] as List)
        .map((m) => new Event.fromJson(m))
        .toList();
    return listEvents;
  }

  Future<List<Community>> getMyGroups() async {
    var res = await dio.get(Urls.MY_GROUPS).catchError((onError) {
      print("GroupsError: $onError");
      print("Catch Error: $onError");
    });
    return (res.data['response'] as List)
        .map((m) => new Community.fromJson(m))
        .toList();
  }

  Future<List<ChildCondition>> getChildConditions({token}) async {
    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var res = await dio.get(Urls.CHILD_CONDITIONS).catchError((onError) {
      print("Catch Error: $onError");
    });
    var conditions = (res.data['response'] as List)
        .map((m) => ChildCondition.fromJson(m))
        .toList();
    print("Total: ${conditions.length}");
    return conditions;
  }

  Future<Map> groupComment({ comment, groupId}) async {
    var res = await dio.get(Urls.CHILD_CONDITIONS).catchError((onError) {
      print("Catch Error: $onError");
    });
    return res.data;
  }

  Future<List<Topic>> getTopics() async {
    var res = await dio.get(Urls.MY_TOPICS).catchError((onError) {
      print("Catch Error: $onError");
    });
   // print(res.data);
    var listTopics = (res.data['results'] as List)
        .map((m) => new Topic.fromJson(m))
        .toList();
    return listTopics;
  }

  Future<MultipartFile> _createMultipartFile(File file) async {
    var fileName = file.path.split('/').last;
    var ext = fileName.split(".")[1];
    var futureFile = await MultipartFile.fromFile(file.path,
        filename: fileName, contentType: MediaType('image', '$ext'));
    return futureFile;
  }
}
