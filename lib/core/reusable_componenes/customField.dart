import 'package:evently/core/color-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomField extends StatefulWidget {
  bool field;
  Color borderColor;
  String? Function(String?)? validator;
  String hint;
  String prefix;
  TextInputType keyboard;
  TextEditingController controller;
  bool isObscure;
   CustomField({super.key,
     this.field=true,
     this.borderColor= ColorManger.lightPrimary,
     required this.validator,
     this.isObscure=false,
     required this.hint,required this.prefix,required this.controller,required this.keyboard});

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
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
            color: widget.field?Theme.of(context).colorScheme.onSecondaryContainer
                :widget.borderColor
          )
        ),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: widget.field?Theme.of(context).colorScheme.onSecondaryContainer
                    :widget.borderColor
            )
        ),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: widget.field?Theme.of(context).colorScheme.onSecondaryContainer
                    :widget.borderColor
            )
        ),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
                color: widget.field?Theme.of(context).colorScheme.onSecondaryContainer
                    :widget.borderColor
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
        hintStyle:widget.field
            ?Theme.of(context).textTheme.bodySmall
            :Theme.of(context).textTheme.bodySmall?.copyWith(
          color: widget.borderColor
        ),
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24,
          maxWidth: 60,
        ),
        prefixIcon: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(widget.prefix,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(widget.field
              ?Theme.of(context).colorScheme.onTertiaryContainer
              :widget.borderColor,
              BlendMode.srcIn),),
        ),
      ),
    );
  }
}
