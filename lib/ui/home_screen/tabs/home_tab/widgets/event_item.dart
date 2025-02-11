import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key});

  @override
  Widget build(BuildContext context) {
    double height= MediaQuery.of(context).size.height;
    return Container(
      height:height*0.25 ,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        image: DecorationImage(
            image: AssetImage(AssetsManger.birthday),fit: BoxFit.cover)
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(8)
              ),
              child: Column(
                children: [
                  Text(StringsManger.const_day.tr(),style: Theme.of(context).textTheme.titleMedium,),
                  Text(StringsManger.const_month.tr(),style: Theme.of(context).textTheme.titleMedium,)
                ],
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Theme.of(context).colorScheme.outline
              ),
              child: Row(
                children: [
                  Expanded(child: Text(StringsManger.title_birthday.tr(),style: Theme.of(context).textTheme.displaySmall,)),
                  SvgPicture.asset(AssetsManger.loveSelected,height: 24,width: 24,
                    colorFilter:ColorFilter.mode(ColorManger.lightPrimary,
                        BlendMode.srcIn) ,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
