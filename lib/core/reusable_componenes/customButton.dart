import 'package:evently/core/strings-manger.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final void Function() onPressed;
  const CustomButton({super.key,required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: (){

    },
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          )
        ),
        child: Text(title,style: Theme.of(context).textTheme.labelLarge,));
  }
}
