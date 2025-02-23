import 'package:evently/core/assets-manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class ToggleButton extends StatefulWidget {
  const ToggleButton({super.key});

  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}

class _ToggleButtonState extends State<ToggleButton> {
  bool isArabic = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary, width: 5)),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isArabic = false;
              });
            },
            child: CircleAvatar(
              backgroundColor: !isArabic
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              radius: 20,
              child: SvgPicture.asset(
                AssetsManger.englishLan,
                height: 30,
                width: 30,
              ),
            ),
          ),
          Gap(16),
          InkWell(
            onTap: () {
              setState(() {
                isArabic = true;
              });
            },
            child: CircleAvatar(
              backgroundColor: isArabic
                  ? Theme.of(context).colorScheme.primary
                  : Colors.transparent,
              radius: 20,
              child: SvgPicture.asset(
                AssetsManger.arabicLan,
                height: 30,
                width: 30,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
