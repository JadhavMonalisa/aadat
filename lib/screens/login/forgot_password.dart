import 'package:adat/common_widget/assets.dart';
import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/login/login_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (cont)
    {
      return SafeArea(
        child: Scaffold(
            backgroundColor: blueColor,
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 70.0),
                    child: buildTextBoldWidget(
                        "FORGOT PASSWORD", whiteColor, context, 26.0,
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
                      child: ListView(
                        //crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(Assets.splashLogo, height: 130.0, width: 130.0,),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20.0, right: 20.0, top: 70.0,bottom: 70.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                buildTextBoldWidget("Login name", orangeColor, context, 16.0),
                                const SizedBox(width: 10.0,),
                                Flexible(
                                  child: Container(
                                    height: 50.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(5)),
                                      border: Border.all(color: grey),),
                                    child: TextFormField(
                                      controller: cont.forgotPassLoginNameController,
                                      keyboardType: TextInputType.text,
                                      textAlign: TextAlign.left,
                                      textAlignVertical: TextAlignVertical
                                          .center,
                                      textInputAction: TextInputAction.done,
                                      onTap: () {},
                                      style: const TextStyle(fontSize: 15.0),
                                      decoration: const InputDecoration(
                                          contentPadding: EdgeInsets.all(10),
                                          border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(
                                left: 120.0, right: 120.0),
                            child: GestureDetector(
                                onTap: () {
                                },
                                child: buildButtonWidget(
                                    context, "Submit", buttonColor: blueColor,
                                    width: 100.0)
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            )
        ),
      );
    });
  }
}
