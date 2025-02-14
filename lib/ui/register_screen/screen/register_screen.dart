import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/constants.dart';
import 'package:evently/core/fireStoreHandler.dart';
import 'package:evently/core/firebase_codes.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/reusable_componenes/customField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/model/User.dart' as MyUser;
import 'package:evently/ui/home_screen/screen/home_screen.dart';
import 'package:evently/ui/login_screen/screen/login_screen.dart';
import 'package:evently/ui/start_screen/widget/language_toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName = "register";

  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController rePasswordController;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    rePasswordController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(StringsManger.register.tr()),
        ),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Image.asset(AssetsManger.logo2),
                  Gap(16),
                  CustomField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManger.not_empty.tr();
                      }
                      return null;
                    },
                    hint: StringsManger.name.tr(),
                    prefix: AssetsManger.personIcon,
                    controller: nameController,
                    keyboard: TextInputType.name,
                  ),
                  Gap(8),
                  CustomField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManger.not_empty.tr();
                        }
                        if (!RegExp(emailRegex).hasMatch(value)) {
                          return StringsManger.email_not_valid.tr();
                        }
                        return null;
                      },
                      hint: StringsManger.email.tr(),
                      prefix: AssetsManger.emailIcon,
                      controller: emailController,
                      keyboard: TextInputType.emailAddress),
                  Gap(8),
                  CustomField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return StringsManger.not_empty.tr();
                        }
                        if (value.length < 8) {
                          return StringsManger.atlleast_eight.tr();
                        }
                        return null;
                      },
                      isObscure: true,
                      hint: StringsManger.password.tr(),
                      prefix: AssetsManger.passwordIcon,
                      controller: passwordController,
                      keyboard: TextInputType.visiblePassword),
                  Gap(8),
                  CustomField(
                      validator: (value) {
                        if (value != passwordController.text) {
                          return StringsManger.dont_match.tr();
                        }
                        return null;
                      },
                      isObscure: true,
                      hint: StringsManger.re_password.tr(),
                      prefix: AssetsManger.passwordIcon,
                      controller: rePasswordController,
                      keyboard: TextInputType.visiblePassword),
                  Gap(16),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    width: double.infinity,
                    child: CustomButton(
                        title: StringsManger.create_account.tr(),
                        onPressed: () {
                          createAccount();
                        }),
                  ),
                  Gap(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        StringsManger.already_have_account_ask.tr(),
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routName);
                          },
                          child: Text(StringsManger.login.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                      color: ColorManger.lightPrimary,
                                      decoration: TextDecoration.underline,
                                      decorationColor:
                                          ColorManger.lightPrimary)))
                    ],
                  ),
                  LanguageToggle()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  createAccount() async {
    if (formKey.currentState!.validate()) {
      try {
        DialogUtils.showLoadingDialog(context);
        var credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        FireStoreHandler.AddUser(MyUser.User(
          id: credential.user!.uid,
          email: emailController.text,
          name: nameController.text
        ));
        Navigator.pop(context);
        Navigator.pushNamedAndRemoveUntil(
            context, HomeScreen.routeName, (route) => false);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        if (e.code == FirebaseAuthCodes.weakPass) {
          DialogUtils.showMessageDialog(
              context: context,
              message: StringsManger.pass_weak.tr(),
              buttonTitle: StringsManger.ok.tr(),
              positiveBtnClick: () {
                Navigator.pop(context);
              });
        } else if (e.code == FirebaseAuthCodes.emailAlreadyInUse) {
          DialogUtils.showMessageDialog(
              context: context,
              message: StringsManger.account_already_exists.tr(),
              buttonTitle: StringsManger.ok.tr(),
              positiveBtnClick: () {
                Navigator.pop(context);
              });
        }
      } catch (e) {
        Navigator.pop(context);
        print(e.toString());
      }
    }
  }
}
