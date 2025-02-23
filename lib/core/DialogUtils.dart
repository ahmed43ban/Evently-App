import 'package:evently/core/color-manger.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:gap/gap.dart';

class DialogUtils {
  static showLoadingDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Loading...",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Gap(10),
                  CircularProgressIndicator(
                    color: Theme.of(context).colorScheme.primary,
                  )
                ],
              ),
            ));
  }

  static showMessageDialog(
      {required BuildContext context,
      required String message,
      required String buttonTitle,
      required void Function() positiveBtnClick,
      String? buttonTitle2,
      void Function()? positiveBtnClick2}) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Text(
                message,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              actions: [
                TextButton(
                    onPressed: positiveBtnClick,
                    child: Text(
                      buttonTitle,
                      style: Theme.of(context).textTheme.titleMedium,
                    )),
                if (buttonTitle2 != null)
                  TextButton(
                      onPressed: positiveBtnClick2,
                      child: Text(buttonTitle2,
                          style: Theme.of(context).textTheme.titleMedium))
              ],
            ));
  }

  static showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: ColorManger.lightPrimary,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
