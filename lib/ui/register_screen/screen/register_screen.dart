import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/reusable_componenes/custonField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  static const String routName="register";
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController nameController;
  GlobalKey<FormState>formKey=GlobalKey<FormState>();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    nameController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManger.register.tr()),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            Image.asset(AssetsManger.logo2),
            SizedBox(height: 16,),
            Custonfield(hint: StringsManger.name.tr(),prefix: AssetsManger.personIcon,
            controller: nameController,)
          ],
        ),
      ),
    );
  }
}
