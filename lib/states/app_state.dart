import 'package:flutter/foundation.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/models/child_conditions.dart';
import 'package:snd_events/models/community.dart';
import 'package:snd_events/models/user.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/models/topic.dart';

class AppState with ChangeNotifier {
  List<Community> communities;
  Map<String, dynamic> userRefs = {};
  List<ChildCondition> _childConditions;
  List<Topic> _topics;
  List<Topic> get topics => _topics;
  List<ChildCondition> get childConditions => _childConditions;
  Repository repo = Repository();
  String userToken;
  User user;

  AppState() {
    _loadPrefs();
  }

  _loadPrefs() async {
    var refs = await repo.loadPrefs();
    userRefs = refs;
    userToken = userRefs[Constants.USER_TOKEN];
    print(userToken);
    repo = Repository(token: userToken);
    notifyListeners();
  }

  void getUserProfile() async {
    repo.getUserProfile(userToken).then((value) {
      print(value);
    });
  }

  void getChildConditions() async {
    var res = await repo.getChildConditions(token: userToken);
    _childConditions = res;
    notifyListeners();
  }

  Future<List<Topic>> getTopics() async {
    var res =
        await Repository(token: userToken).getTopics().catchError((onError) {
      print(onError);
    });
    _topics = res;
    return res;
  }

  void addTopic(Topic topic) async {
    _topics.insert(0, topic);
    notifyListeners();
  }

  Future<User> getUserData() async{
    var _user =  await Repository().getUserProfile(userToken);
    user = _user;
    print(user.city);
    return _user;
  }

  Future<List<Community>> getMyGroups() async{
    var _communities =  await repo.getMyGroups().catchError((onError){
       print(onError);
    });
    communities = _communities;
    return _communities;
  }

}
