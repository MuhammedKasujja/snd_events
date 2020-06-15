import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:snd_events/data/repo.dart';
import 'package:snd_events/utils/app_utils.dart';
import 'package:snd_events/utils/constants.dart';
import 'package:snd_events/widgets/app_icon.dart';
import 'package:snd_events/widgets/other_option.dart';
import 'package:snd_events/widgets/submit_button.dart';
import 'package:snd_events/widgets/textfield.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String name, email, password, confirmPassword;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: SafeArea(
        child: Scaffold(
            body: Container(
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    AppIcon(),
                    Text(
                      Constants.REGISTER,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    TextfieldWidget(
                      hint: Constants.HINT_NAME,
                      onTextChange: (value) {
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                    TextfieldWidget(
                      hint: Constants.HINT_EMAIL,
                      onTextChange: (value) {
                        setState(() {
                          email = value;
                        });
                      },
                    ),
                    TextfieldWidget(
                      hint: Constants.HINT_PASSWORD,
                      onTextChange: (value) {
                        setState(() {
                          password = value;
                        });
                      },
                    ),
                    TextfieldWidget(
                      hint: Constants.HINT_CONFIRM_PASSWORD,
                      onTextChange: (value) {
                        setState(() {
                          confirmPassword = value;
                        });
                      },
                    ),
                    SubmitButtonWidget(onPressed: () {
                      if (_validateFields()) {
                        if (_validatePassword()) {
                          _registerUser();
                        } else {
                          Fluttertoast.showToast(
                              msg: "Passwords do not match",
                              gravity: ToastGravity.TOP);
                        }
                      } else {
                        Fluttertoast.showToast(
                            msg: "Please fill all fields",
                            gravity: ToastGravity.TOP);
                      }
                    }),
                    ORWidget(),
                    GestureDetector(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          Constants.LOGIN,
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
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
        name != null &&
        name.isNotEmpty &&
        password != null &&
        password.isNotEmpty &&
        confirmPassword != null &&
        confirmPassword.isNotEmpty;
  }

  _registerUser() {
    Repository()
        .register(name: name, password: password, email: email)
        .then((data) {
      if (data[Constants.KEY_CODE] == 0) {
        AppUtils.showToast(data[Constants.KEY_ERROR]);
        print(data[Constants.KEY_ERROR]);
      } else {
        AppUtils.showToast(data[Constants.KEY_RESPONSE]);
        print(data[Constants.KEY_RESPONSE]);
      }
    });
  }

  bool _validatePassword() {
    return password == confirmPassword;
  }
}
