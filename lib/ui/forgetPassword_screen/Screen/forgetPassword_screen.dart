import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/reusable_componenes/customField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/start_screen/widget/language_toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ForgetPasswordScreen extends StatefulWidget {
  static const String routName = "forgetPassword";

  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late TextEditingController emailController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();

  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsManger.forget_password.tr()),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(AssetsManger.changeSetting),
                  Gap(16),
                  CustomField(
                      validator: (value){
                        if(value==null ||value.isEmpty){
                          return StringsManger.not_empty.tr();
                        }
                        if(!RegExp(emailRegex).hasMatch(value)){
                          return StringsManger.email_not_valid.tr();
                        }
                        return null;
                      },
                      hint: StringsManger.email.tr(), prefix: AssetsManger.emailIcon,
                      controller: emailController,keyboard: TextInputType.emailAddress),
                  Gap(16),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                        title: StringsManger.reset_password.tr(),
                        onPressed: () async{
                          DialogUtils.showLoadingDialog(context);
                          if(formKey.currentState!.validate()){
                            await FirebaseAuth.instance
                                .sendPasswordResetEmail(email: emailController.text);
                            Navigator.pop(context);
                            DialogUtils.showToast(StringsManger.check_mail.tr());
                          };
                        }),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
