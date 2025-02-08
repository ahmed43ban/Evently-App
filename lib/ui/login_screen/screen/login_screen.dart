import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/firebase_codes.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/reusable_componenes/custonField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/forgetPassword_screen/Screen/forgetPassword_screen.dart';
import 'package:evently/ui/register_screen/screen/register_screen.dart';
import 'package:evently/ui/home_screen/screen/home_screen.dart';
import 'package:evently/ui/start_screen/widget/language_toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  static const String routName = "login";

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManger.logo2),
                  Gap(16),
                  Custonfield(
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
                  Gap(8),
                  Custonfield(
                      validator: (value){
                        if(value==null ||value.isEmpty){
                          return StringsManger.not_empty.tr();
                        }
                        if(value.length<8){
                          return StringsManger.atlleast_eight.tr();
                        }
                        return null;
                      },
                      isObscure:true,
                      hint: StringsManger.password.tr(),
                      prefix: AssetsManger.passwordIcon,
                      controller: passwordController,
                      keyboard: TextInputType.visiblePassword),
                  Gap(8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                                context, ForgetPasswordScreen.routName);
                          },
                          child: Text(StringsManger.forget_passwordask.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: ColorManger.lightPrimary,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorManger.lightPrimary))),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                        title: StringsManger.login.tr(), onPressed: () {
                          loginAccount();
                    }),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManger.dont_have_account_ask.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, RegisterScreen.routName);
                          },
                          child: Text(StringsManger.create_account.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: ColorManger.lightPrimary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: ColorManger.lightPrimary)))
                    ],
                  ),
                  Gap(8),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                            child: Divider(
                                thickness: 2,
                                color: Theme.of(context).colorScheme.primary)),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            StringsManger.or.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .bodySmall
                                ?.copyWith(
                                    color: Theme.of(context).colorScheme.primary),
                          ),
                        ),
                        Expanded(
                            child: Divider(
                          thickness: 2,
                          color: Theme.of(context).colorScheme.primary,
                        )),
                      ],
                    ),
                  ),
                  Gap(8),
                  ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                          backgroundColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          )),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 8.0),
                            child: SvgPicture.asset(AssetsManger.googleIcon),
                          ),
                          Text(
                            StringsManger.login_with_google.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                        ],
                      )),
                  Gap(8),
                  LanguageToggle()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
  loginAccount()async{
    if(formKey.currentState!.validate()){
      try {
        DialogUtils.showLoadingDialog(context);
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: emailController.text,
            password: passwordController.text
        );
        Navigator.pop(context);
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.userNotFound) {
          DialogUtils.showMessageDialog(context: context,
              message: 'No user found for that email.',
              buttonTitle: "ok",
              positiveBtnClick: (){
                Navigator.pop(context);
              });
        } else if (e.code == FirebaseAuthCodes.wrongPass) {
          DialogUtils.showMessageDialog(context: context,
              message: 'Wrong password provided for that user.',
              buttonTitle: "ok",
              positiveBtnClick: (){
                Navigator.pop(context);
              });
        }
      }
    }
  }
}
