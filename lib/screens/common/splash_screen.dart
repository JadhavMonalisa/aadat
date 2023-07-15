import 'dart:async';
import 'package:adat/common_widget/assets.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {

  int? clientId;

  @override
  void initState() {
    super.initState();
    getData();
    startTime();
  }

  getData(){
    clientId = GetStorage().read("clientId")??0;
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  Future<void> navigationPage() async {
    if(clientId==0){
      Get.toNamed(AppRoutes.login);
    }
    else{
      Get.toNamed(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:Scaffold(
          backgroundColor: blueColor,
        body:Stack(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: const EdgeInsets.only(top: 70.0),
                child: buildTextBoldWidget(
                    "WELCOME", whiteColor, context, 26.0,
                    align: TextAlign.center),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 200.0),
              child: Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: MediaQuery
                    .of(context)
                    .size
                    .height,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(100.0),
                    topLeft: Radius.circular(100.0),
                  ),
                  color: whiteColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  //child: Center(child: Text("Coming soon"))
                  child: Center(child: Image.asset(Assets.splashLogo,fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height/3,
                    width: MediaQuery.of(context).size.width/2),)
                ),
              ),
            )
          ],
        )
      )
    );
  }
}
