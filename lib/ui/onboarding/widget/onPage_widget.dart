import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class OnpageWidget extends StatelessWidget {
  String path;
  String title;
  String desc;
  OnpageWidget({super.key,required this.path,required this.title,required this.desc});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(path),
        Text(title.tr(),style:Theme.of(context).textTheme.titleMedium),
        Text(desc.tr(),style:Theme.of(context).textTheme.titleSmall),
      ],
    );
  }
}
