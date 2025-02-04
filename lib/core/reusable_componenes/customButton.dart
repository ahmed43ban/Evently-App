import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const CustomButton({super.key,required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed:onPressed,
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Text(title,style: Theme.of(context).textTheme.labelLarge,));
  }
}
