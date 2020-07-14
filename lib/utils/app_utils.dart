import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:snd_events/utils/app_theme.dart';

class AppUtils {
  BuildContext _context;
  AppUtils(BuildContext context) {
    this._context = context;
  }

  nextPage({@required page}) {
    Navigator.push(_context, MaterialPageRoute(builder: (_) {
      return page;
    }));
  }

  static String convertDateFormat(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        gravity: ToastGravity.TOP,
        backgroundColor: AppTheme.PrimaryDarkColor);
  }

  static Future<File> getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    return File(pickedFile.path);
  }
}
