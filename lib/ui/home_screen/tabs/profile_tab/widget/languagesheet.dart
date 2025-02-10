import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class LanguageSheet extends StatelessWidget {
  const LanguageSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey,
      padding:  EdgeInsets.all(16),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(context.locale.languageCode == "ar"
                  ? StringsManger.language2
                  : StringsManger.language1,
                style: Theme.of(context).textTheme.titleMedium,),
              Icon(Icons.check,size: 30,color: ColorManger.lightPrimary,)
            ],
          ),
          Gap(24),
          InkWell(
            onTap: (){
              if(context.locale.languageCode=="ar"){
                context.setLocale(Locale("en"));
              }else{
                context.setLocale(Locale("ar"));
              }
            },
            child: Text(context.locale.languageCode != "ar"
                ? StringsManger.language2
                : StringsManger.language1,
              style: Theme.of(context).textTheme.displaySmall,),
          )
        ],
      ),
    );
  }
}
