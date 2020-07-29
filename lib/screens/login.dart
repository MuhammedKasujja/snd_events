import 'package:flutter/material.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/screens/home.dart';
import 'package:snd_events/screens/register.dart';
import 'package:snd_events/utils/app_theme.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
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
      color: AppTheme.PrimaryDarkColor,
      child: SafeArea(
        child: Scaffold(
            body: Container(
          child: ListView(
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      child: Text(
                        Constants.APP_NAME,
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      alignment: Alignment.center,
                    ),
                    // Align(child: Icon(Icons.event_seat),)
                  ],
                ),
                width: double.infinity,
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                    color: AppTheme.PrimaryColor,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15))),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    Text(Constants.LOGIN,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20)),
                    SizedBox(
                      height: 10,
                    ),
                    TextfieldWidget(
                      inputType: TextInputType.emailAddress,
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
                      isPassword: true,
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
                        AppUtils.showToast(Constants.HINT_FILL_ALL_FIELDS);
                      }
                    }),
                    ORWidget(),
                    OutlineButton(
                      highlightedBorderColor: AppTheme.PrimaryDarkColor,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Constants.REGISTER,
                        ),
                      ),
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return RegisterScreen();
                        }));
                      },
                    )
                  ],
                ),
              ),
            ],
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
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        token: data['token'],
                      )));
        });
      }
    });
  }
}
