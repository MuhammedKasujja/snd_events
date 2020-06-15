import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/screens/register.dart';
import 'package:snd_events/screens/splash.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/app_icon.dart';
import 'package:snd_events/widgets/other_option.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email, password;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
            body: Container(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    AppIcon(),
                    Text(Constants.LOGIN,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    TextfieldWidget(
                      hint: Constants.HINT_EMAIL,
                      onTextChange: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextfieldWidget(
                      hint: Constants.HINT_PASSWORD,
                      onTextChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SubmitButtonWidget(onPressed: () {
                      if (_validateFields()) {
                        _login();
                      } else {
                        Fluttertoast.showToast(msg: 'Please fill all fields', gravity: ToastGravity.TOP);
                      }
                    }),
                    ORWidget(),
                    InkWell(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Constants.REGISTER,
                        ),
                      ),
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return RegisterScreen();
                        }));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        )),
      ),
    );
  }

  bool _validateFields() {
    return email != null &&
        email.isNotEmpty &&
        password != null &&
        password.isNotEmpty;
  }

  _login() {
    Repository().login(password: password, email: email).then((data) {
      if (data['code'] == 0) {
        print(data['response']);
        AppUtils.showToast(data[Constants.KEY_RESPONSE]);
      } else {
        AppUtils.showToast(data[Constants.KEY_RESPONSE]);
        Repository().savePrefs(data['token'], email).then((value) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SplashScreen()));
        });
      }
    });
  }
}
