import 'package:easy_localization/easy_localization.dart';
import 'package:evently/core/DialogUtils.dart';
import 'package:evently/core/assets-manger.dart';
import 'package:evently/core/color-manger.dart';
import 'package:evently/core/reusable_componenes/customButton.dart';
import 'package:evently/core/reusable_componenes/customField.dart';
import 'package:evently/core/strings-manger.dart';
import 'package:evently/ui/start_screen/widget/language_toggle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName="createEvent";

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  late TextEditingController titleController;
  late TextEditingController descController;
  int selectedIndex=0;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController=TextEditingController();
    descController=TextEditingController();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    titleController.dispose();
    descController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    double height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color:ColorManger.lightPrimary
        ),
        title: Text(StringsManger.create_event.tr(),style: TextStyle(
          color: ColorManger.lightPrimary
        ),),
      ),
      body: Form(
        key: formKey,
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height*0.2,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                        children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                          child: Image.asset(AssetsManger.book_club,height: height*0.2,fit: BoxFit.cover,)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                          child: Image.asset(AssetsManger.sportcard,height: height*0.2,fit: BoxFit.cover,)),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                          child: Image.asset(AssetsManger.birthday,height: height*0.2,fit: BoxFit.cover,)),
                    ]),
                  ),
                  Gap(16),
                  TabBar(
                      onTap: (index){
                        selectedIndex=index;
                        setState(() {
              
                        });
                      },
                      labelColor: Colors.white,
                      unselectedLabelColor: ColorManger.lightPrimary,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(46),
                      ),
                      tabAlignment: TabAlignment.start,
                      isScrollable: true,
                      dividerHeight: 0,
                      tabs: [
                        Tab(child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManger.lightPrimary
                              ),
                              borderRadius: BorderRadius.circular(46)
                          ),
                          padding: EdgeInsets.all( 10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsManger.book_event,colorFilter: ColorFilter.mode(
                                  selectedIndex==0
                                      ?Colors.white
                                      :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                                  BlendMode.srcIn),
                                height: 24,width: 24,),
                              Gap(8),
                              Text(StringsManger.book_club.tr())
                            ],
                          ),
                        ),),
                        Tab(child: Container(
                          padding:  EdgeInsets.all( 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: ColorManger.lightPrimary
                              ),
                              borderRadius: BorderRadius.circular(46)
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsManger.sport_event,colorFilter: ColorFilter.mode(
                                  selectedIndex==1
                                      ?Colors.white
                                      :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                                  BlendMode.srcIn),
                                height: 24,width: 24,),
                              Gap(8),
                              Text(StringsManger.sport.tr())
                            ],
                          ),
                        ),),
                        Tab(child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color:ColorManger.lightPrimary
                              ),
                              borderRadius: BorderRadius.circular(46)
                          ),
                          padding: EdgeInsets.all( 10),
                          child: Row(
                            children: [
                              SvgPicture.asset(AssetsManger.cake_event,colorFilter: ColorFilter.mode(
                                  selectedIndex==2
                                      ?Colors.white
                                      :Theme.of(context).colorScheme.onPrimaryFixedVariant,
                                  BlendMode.srcIn),
                                height: 24,width: 24,),
                              Gap(8),
                              Text(StringsManger.birthday.tr())
                            ],
                          ),
                        ),),
              
              
              
                      ]),
                  Gap(16),
                  Text(StringsManger.title.tr(),style: Theme.of(context).textTheme.titleSmall,),
                  Gap(8),
                  CustomField(
                      validator: (value){
                        if(value==null || value.isEmpty){
                          DialogUtils.showMessageDialog(
                              context: context,
                              message: StringsManger.not_empty.tr(),
                              buttonTitle: StringsManger.ok.tr(),
                              positiveBtnClick: (){
                                Navigator.pop(context);
                              });
                        }
                        return null;
                      },
                      hint: StringsManger.event_title.tr(),
                      prefix: AssetsManger.writeText,
                      controller: titleController,
                      keyboard: TextInputType.text),
                  Gap(8),
                  Text(StringsManger.desc.tr(),style: Theme.of(context).textTheme.titleSmall,),
                  CustomField(maxLines: 3,
                      validator: (value){
                        if(value==null || value.isEmpty){
                          DialogUtils.showMessageDialog(
                              context: context,
                              message: StringsManger.not_empty.tr(),
                              buttonTitle: StringsManger.ok.tr(),
                              positiveBtnClick: (){
                                Navigator.pop(context);
                              });
                        }
                        return null;
                      },
                      hint: StringsManger.event_desc.tr(),
                      controller: descController,
                      keyboard: TextInputType.multiline),
                  Gap(16),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManger.date_mark),
                      Gap(8),
                      Expanded(
                        child: Text(
                          StringsManger.event_date.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(StringsManger.choose_date.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    color: ColorManger.lightPrimary,
                                    ))),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManger.time_mark),
                      Gap(8),
                      Expanded(
                        child: Text(
                          StringsManger.event_time.tr(),
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: TextButton(
                            onPressed: () {},
                            child: Text(StringsManger.choose_time.tr(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                    color: ColorManger.lightPrimary,
                                    ))),
                      )
                    ],
                  ),
                  Text(StringsManger.location.tr(),style: Theme.of(context).textTheme.titleSmall,),
                  Gap(8),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorManger.lightPrimary
                      )
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(AssetsManger.chooseLocation),
                        Gap(8),
                        Expanded(
                          child: Text(StringsManger.choose_location.tr(),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                color: ColorManger.lightPrimary,
                              )),
                        ),
                        Align(
                          alignment: AlignmentDirectional.centerEnd,
                            child: Icon(Icons.arrow_forward_ios_sharp,color: ColorManger.lightPrimary,))
                      ],
                    ),
                  ),
                  Gap(8),
                  Container(
                    width: double.infinity,
                    child: CustomButton(
                        title: StringsManger.add_event.tr(),
                        onPressed: (){}),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
