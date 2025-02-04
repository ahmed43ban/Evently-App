import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Custonfield extends StatefulWidget {
  String? Function(String?)? validator;
  String hint;
  String prefix;
  TextInputType keyboard;
  TextEditingController controller;
  bool isObscure;
   Custonfield({super.key,
     required this.validator,
     this.isObscure=false,
     required this.hint,required this.prefix,required this.controller,required this.keyboard});

  @override
  State<Custonfield> createState() => _CustonfieldState();
}

class _CustonfieldState extends State<Custonfield> {
  bool PasswordToggle=true;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: widget.validator,
      controller: widget.controller,
      keyboardType: widget.keyboard,
      obscureText: widget.isObscure?PasswordToggle:false,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSecondaryContainer
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: Theme.of(context).colorScheme.onSecondaryContainer
            )
        ),
        hintText: widget.hint,
        suffixIcon: widget.isObscure?IconButton(
            onPressed: (){
              PasswordToggle=!PasswordToggle;
              setState(() {

              });
            },
            icon: Icon(PasswordToggle
              ?Icons.visibility_off_rounded:Icons.visibility_rounded,
              size:24 ,
              color: Theme.of(context).colorScheme.onTertiaryContainer,)):null,
        hintStyle:Theme.of(context).textTheme.bodySmall,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24,
          maxWidth: 60,
        ),
        prefixIcon: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(widget.prefix,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onTertiaryContainer,
              BlendMode.srcIn),),
        ),
      ),
    );
  }
}
