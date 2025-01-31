import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Custonfield extends StatelessWidget {
  String hint;
  String prefix;
  TextEditingController controller;
   Custonfield({super.key,required this.hint,required this.prefix,required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
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
        hintText: hint,
        hintStyle:Theme.of(context).textTheme.bodySmall,
        prefixIconConstraints: BoxConstraints(
          maxHeight: 24,
          maxWidth: 60,
        ),
        prefixIcon: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 16),
          child: SvgPicture.asset(prefix,
          width: 24,
          height: 24,
          colorFilter: ColorFilter.mode(Theme.of(context).colorScheme.onTertiaryContainer,
              BlendMode.srcIn),),
        ),
      ),
    );
  }
}
