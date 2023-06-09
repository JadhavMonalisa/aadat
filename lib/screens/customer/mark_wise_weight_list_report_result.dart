import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MarkWiseWeightListResultReport extends StatefulWidget {
  const MarkWiseWeightListResultReport({Key? key}) : super(key: key);

  @override
  State<MarkWiseWeightListResultReport> createState() => _MarkWiseWeightListResultReportState();
}

class _MarkWiseWeightListResultReportState extends State<MarkWiseWeightListResultReport> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await  Get.toNamed(AppRoutes.customerMarkWiseWeightListReportScreen);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Mark Wise Weight List Report Result", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigationFromResult(AppRoutes.customerLedgerReport);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body:
              cont.isLoading ? buildCircularIndicator() :
              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER MARK WISE WEIGHT LIST REPORT FOR\n${cont.selectedCustomer} "
                              "BILL DATE ${cont.selectedBillDateToShow} "
                              "OF ${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,left: 250.0),
                          child: buildButtonWidget(context, "Export to",width: 100.0,height: 40.0),
                        ),

                        cont.markWiseWeightList.isEmpty ? buildNoDataFound(context):
                        Scrollbar(
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                              child:  Table(
                                border: TableBorder.all(color: whiteColor,width: 2.0),
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(
                                      children: [
                                        buildTableTitleForReport(context,"Checkbox"),
                                        buildTableTitleForReport(context,"Customer Mark"),
                                        buildTableTitleForReport(context,"Total Quantity"),
                                        buildTableTitleForReport(context,"Total Weight"),
                                        buildTableTitleForReport(context,"Avg. Rate"),
                                      ]
                                  ),
                                    for (int index = 0 ; index < cont.markWiseWeightList.length ; index ++)
                                    TableRow(
                                        children: [
                                          Checkbox(value:
                                          cont.addedMarkWiseListIndex.contains(index)
                                              ? true : false ,
                                              activeColor: Colors.green,
                                              onChanged:(newValue){
                                                cont.updateMarkWiseListCheckBox(newValue!,index);
                                              }),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].mark.toString()),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].qty.toString()),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].weight.toString()),
                                          buildTableSubtitleForReport(context,cont.markWiseWeightList[index].amount.toString()),
                                        ]
                                    ),
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
