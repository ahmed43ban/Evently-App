import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/reusable_componenes/customField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/home_screen/tabs/home_tab/widgets/event_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class LoveTab extends StatefulWidget {
  const LoveTab({super.key});

  @override
  State<LoveTab> createState() => _LoveTabState();
}

class _LoveTabState extends State<LoveTab> {
  late TextEditingController controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 16,right: 16,left: 16),
        child: Column(
          children: [
            CustomField(field: false,
                validator: (value){
                  return null;
                },
                hint: StringsManger.search.tr(),
                prefix: AssetsManger.search,
                controller: controller,
                keyboard: TextInputType.text,),
            Gap(16),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) =>EventItem(),
                  separatorBuilder: (context, index) => Gap(16),
                  itemCount: 10),
            ),
          ],
        ),
      ),
    );
  }
}
