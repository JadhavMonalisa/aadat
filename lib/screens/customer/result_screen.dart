import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get_state_manager/src/simple/get_state.dart';

class ResultScreen extends StatefulWidget {
  const ResultScreen({Key? key}) : super(key: key);

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.backPressNavigationFromResult(AppRoutes.customerLedgerReport);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Customer Ledger Report Result", whiteColor, context, 15.0),
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
                            child:  Table(
                              border: TableBorder.all(color: whiteColor,width: 2.0),
                              defaultColumnWidth: const IntrinsicColumnWidth(),
                              children: [
                                TableRow(
                                    children: [
                                      buildTableTitleForReport(context,"Sr No"),
                                      buildTableTitleForReport(context,"Receipt Date"),
                                      buildTableTitleForReport(context,"Receipt Narration"),
                                      buildTableTitleForReport(context,"Receipt Amt"),
                                      buildTableTitleForReport(context,"Payment Date"),
                                      buildTableTitleForReport(context,"Payment Narration"),
                                      buildTableTitleForReport(context,"Payment Amount"),
                                    ]
                                ),
                                for (var data in cont.ledgerReportList)
                                  TableRow(
                                      children: [
                                        buildTableSubtitleForReport(context,data.srNo.toString()),
                                        buildTableSubtitleForReport(context,data.recieptDate.toString()),
                                        buildTableSubtitleForReport(context,data.recieptNarration.toString()),
                                        buildTableSubtitleForReport(context,data.recieptAmount.toString()),
                                        buildTableSubtitleForReport(context,data.paymentDate.toString()),
                                        buildTableSubtitleForReport(context,data.paymentNarration.toString()),
                                        buildTableSubtitleForReport(context,data.paymentAmonut.toString()),
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
