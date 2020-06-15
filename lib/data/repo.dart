import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:snd_events/data/urls.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:dio/dio.dart';

class Repository {
  Future<Map> register({name, email, password}) async {
    var res = await http.post(Urls.REGISTER, body: {
      "email": email,
      "password1": password,
      "password2": password,
      "name": name
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
      // Constants.KEY_EMAIL: prefs.getString(Constants.KEY_EMAIL),
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

  Future changePassword({token, oldPassword, newPassword}) async {
    await http.put(Urls.CHANGE_PASSWORD, headers: {
      HttpHeaders.authorizationHeader: 'Token $token'
    }, body: {
      'old_password': oldPassword,
      'new_password1': newPassword,
      'new_password2': newPassword
    });
  }

  Future getUserProfile(token) async {
    var res = await http.get(
      Urls.USER_PROFILE,
      headers: {HttpHeaders.authorizationHeader: 'Token $token'},
    );

    return json.decode(res.body);
  }

  //////////////////////////////////Starting////////////////////////

  Future<Map> addProfession({token, prof, desc, spec}) async {
    var res = await http.post(Urls.ADD_PROFESSION,
        headers: {HttpHeaders.authorizationHeader: 'Token $token'},
        body: {'prof': prof, 'any_info': desc, 'spec': spec});
    return json.decode(res.body);
  }

  Future<Map> addEvent(
      {token,
      theme,
      startDate,
      endDate,
      locationDistrict,
      buildingStreet,
      speaker}) async {
    print(token);
    print(theme);
    print(startDate);
    print(endDate);
    print(locationDistrict);
    print(buildingStreet);
    print(speaker);

    var res = await http.post(Urls.ADD_MEETUP, headers: {
      HttpHeaders.authorizationHeader: 'Token $token'
    }, body: {
      'theme': theme,
      "start": "2020-12-17 14:12:03",
      "end": "2020-12-17 14:12:03",
      "location_district": locationDistrict,
      "building_street": buildingStreet,
      "speaker": speaker
    }
        // {
        //   'theme': theme,
        //   'start': startDate,
        //   'end': endDate,
        //   'speaker': speaker,
        //   'location_district': locationDistrict,
        //   'building_street': buildingStreet
        // }
        ).catchError((onError) {
      print(onError);
    });

    var data = json.decode(res.body);
    print(data);
    return data;
  }

  Future<Map> addCommunity(
      {token, name, desc, locationDistrict, topics}) async {
    var res = await http.post(Urls.ADD_COMMUNITY, headers: {
      HttpHeaders.authorizationHeader: 'Token $token'
    }, body: {
      "name": name,
      'describe': desc,
      'location_district': locationDistrict,
      'topics': topics
    }).catchError((onError) {
      print(onError);
    });

    return json.decode(res.body);
  }

  Future<Map> addChild(
      {token, firstname, lastname, gender, dob, condition}) async {
    print(token);
    print(firstname);
    print(lastname);
    print(gender);
    print(dob);
    print(condition);
    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    Response res = await dio.post(Urls.ADD_CHILD, data: {
      "full_name": "$firstname $lastname",
      "gender": gender,
      "dob": "2019-06-23",
      "condition": [1, 2]
    }).catchError((onError) {
      print('Catch error: $onError');
    });
    // Response is returned as a Map
    var data = res.data;
    print(data);
    return data;
  }

  Future<Map> updateProfile({token, name, email, File file}) async {
    var dio = new Dio();
    dio.options.headers.addAll({
      HttpHeaders.authorizationHeader: 'Token $token',
      HttpHeaders.contentTypeHeader: 'application/json'
    });
    var fileName = file.path.split('/').last;
    print("FileName: "+fileName);
    var formData = FormData.fromMap({
      "name": name,
      "email": email,
      "photo": await MultipartFile.fromFile(file.path, filename: fileName),
    });
    var res = await dio
        .put(Urls.PROFILE_UPDATE, data: formData)
        .catchError((onError) {
      print("Catch Error: $onError");
    });
    return res.data;
  }
}
