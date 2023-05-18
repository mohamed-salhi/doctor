import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:doctor_app/app/modules/home/controllers/login_controller.dart';
import 'package:doctor_app/app/modules/home/views/profile_view.dart';
import 'package:doctor_app/app/modules/patients/controllers/article_controller.dart';
import 'package:doctor_app/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:doctor_app/common_widget/custom_size_box.dart';
import 'package:doctor_app/common_widget/custom_text.dart';
import 'package:doctor_app/shared/styles/icon_broken.dart';

class HomePatientsView extends GetView<LayoutPatientsAppController> {
   HomePatientsView({Key? key}) : super(key: key);
  LoginController loginController=LoginController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutPatientsAppController>(
      init: LayoutPatientsAppController(),
      builder: (controller){
        return Scaffold(
          body:
         controller.categories.length==0?Column(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             SpinKitFadingCube(
               color: Colors.blue,

               size: 50.0,
             ),
             CustomSizeBox(30),
             CustomText(Colors.black, 15, FontWeight.w600, "There is no category")
           ],
         ): ListView.separated(shrinkWrap: true,itemBuilder: (context,index)=>
              Stack(
                alignment: AlignmentDirectional.topEnd,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Container(width: double.infinity,height: 120,decoration: BoxDecoration(

                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0xFFfafafa),

                    ),child:GestureDetector(
                      onTap: (){
                        ArticleController article=ArticleController();
                        article.getAllArticle( controller.categories[index].id);
                        loginController.moveBetweenPages('ArticleView',arguments:{
                          "nameCategories": controller.categories[index].nameCategories,
                          "id": controller.categories[index].id,
                        });
                      },
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Container(height: 85,width: 85,decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),color: Colors.white,
                              image:  DecorationImage(image: NetworkImage("${controller.categories[index].imageCategories}"),fit: BoxFit.cover),
                            ),),
                          ),
                          CustomSizeBox(0,width: 20,),
                          
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SingleChildScrollView(child: CustomText(Colors.black,20,FontWeight.w600,"${controller.categories[index].nameCategories}")),
                              CustomSizeBox(10),

                              CustomText(Colors.grey,12,FontWeight.w400,"${controller.categories[index].detailsCategories}"),

                            ],
                          ),
                          const Spacer(),
                          Padding(

                            padding:controller.initLang==Get.deviceLocale||controller.initLang==Locale("at")? EdgeInsets.only(left:10 ):EdgeInsets.only(right:10 ),
                            child: customCircleAvatar(
                              20,
                              color: controller.categories[index].like==false?Colors.grey:Colors.blue,
                              widget:       const Icon(IconBroken.Star,color: Colors.white,),
onTap: (){
                                controller.updateCategories(controller.categories[index].idOfMyCategories);
}
                            ),
                          ),

                        ],
                      ),
                    )
                      ,),
                  ),
                ],
              ), separatorBuilder: (controller,index)=>CustomSizeBox(20), itemCount: controller.categories.length),

        );
      },
    );

  }
}
