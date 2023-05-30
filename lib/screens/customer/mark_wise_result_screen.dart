import 'package:adat/common_widget/widget.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class MarkWiseResultScreen extends StatefulWidget {
  const MarkWiseResultScreen({Key? key}) : super(key: key);

  @override
  State<MarkWiseResultScreen> createState() => _MarkWiseResultScreenState();
}

class _MarkWiseResultScreenState extends State<MarkWiseResultScreen> {

  String screen = Get.arguments[0];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.backPressNavigation(screen);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Customer Result", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigation(screen);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER LEDGER REPORT FOR\n${cont.selectedCustomer} "
                              "from ${cont.selectedFromDateToShow} to ${cont.selectedToDateToShow} "
                              "of ${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,left: 250.0),
                          child: buildButtonWidget(context, "Export to",width: 100.0,height: 40.0),
                        ),

                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                              child: Table(
                                border: TableBorder.all(color: whiteColor,width: 2.0),
                                defaultColumnWidth: const FixedColumnWidth(120.0),
                                children: [
                                  TableRow(
                                      children: [
                                        Container(
                                          color: grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextBoldWidget("Column 1", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextBoldWidget("Column 2", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey,
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextBoldWidget("Column 3", blackColor, context, 14.0),
                                          ),
                                        ),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 1", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 2", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 3", blackColor, context, 14.0),
                                          ),
                                        ),
                                      ]
                                  ),
                                  TableRow(
                                      children: [
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 1", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 2", blackColor, context, 14.0),
                                          ),
                                        ),
                                        Container(
                                          color: grey.withOpacity(0.2),
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: buildTextRegularWidget("data 3", blackColor, context, 14.0),
                                          ),
                                        ),
                                      ]
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                ),
              ),
            )
        ),
      );
    });
  }
}
