import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupplierResultScreen extends StatefulWidget {
  const SupplierResultScreen({Key? key}) : super(key: key);

  @override
  State<SupplierResultScreen> createState() => _SupplierResultScreenState();
}

class _SupplierResultScreenState extends State<SupplierResultScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.backPressNavigation(AppRoutes.supplierLedgerReport);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Supplier Ledger Report ", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigation(AppRoutes.supplierLedgerReport);
                    },
                    child: const Icon(Icons.arrow_back_ios, color: whiteColor,)
                ),
              ),
              body:
              cont.isLoading ? buildCircularIndicator() :
                  cont.supplierLedgerReportList.isEmpty ? buildNoDataFound(context):

              Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20.0,bottom: 20.0,top: 30.0),
                child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0),
                          child: buildTextRegularWidget("SUPPLIER LEDGER REPORT FOR\n${cont.selectedFirm} "
                              "from ${cont.selectedFromDateToShow} to ${cont.selectedToDateToShow} "
                              "of ${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0,left: 250.0),
                          child: buildButtonWidget(context, "Export to",width: 100.0,height: 40.0),
                        ),
                        cont.supplierLedgerReportList.isEmpty?const Text(""):
                        Center(child:buildTextBoldWidget(cont.supplierLedgerReportList[0].suppAccountName!,
                            blackColor, context, 15.0)),
                        Scrollbar(
                          child:SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0,right: 10.0,top: 10.0),
                              child: Table(
                                border: TableBorder.all(color: whiteColor,width: 2.0),
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(
                                    decoration: const BoxDecoration(color: grey),
                                      children: [
                                        buildTableTitleForReport(context,"Date"),
                                        buildTableTitleForReport(context,"Ledger Name"),
                                        buildTableTitleForReport(context,"Narration"),
                                        buildTableTitleForReport(context,"Debit"),
                                        buildTableTitleForReport(context,"Credit"),
                                      ]
                                  ),
                                  for (var data in cont.supplierLedgerReportList)
                                    TableRow(
                                        decoration: BoxDecoration(color: grey.withOpacity(0.2)),
                                        children: [
                                          buildTableSubtitleForReport(context,data.tranDate.toString()),
                                          buildTableSubtitleForReport(context,data.ledgerName.toString()),
                                          buildTableSubtitleForReport(context,data.narration.toString()),
                                          buildTableSubtitleForReport(context,data.debitAmt.toString()),
                                          buildTableSubtitleForReport(context,data.creditAmt.toString()),
                                        ]
                                    ),
                                  TableRow(
                                      decoration: const BoxDecoration(color: grey),
                                      children: [
                                        buildTableSubtitleForReport(context,""),
                                        buildTableSubtitleForReport(context,""),
                                        buildTableSubtitleForReport(context,"Total",fontWeight: FontWeight.bold),
                                        buildTableSubtitleForReport(context,cont.totalSupplierLedgerReportDebit.toString(),fontWeight: FontWeight.bold),
                                        buildTableSubtitleForReport(context,cont.totalSupplierLedgerReportCredit.toString(),fontWeight: FontWeight.bold),
                                      ]
                                  ),

                                  // TableRow(
                                  //     children: [
                                  //       buildTableTitleForReport(context,"Amount",align: TextAlign.center),
                                  //       buildTableTitleForReport(context,"Date",align: TextAlign.center),
                                  //     ]
                                  // ),
                                  // for (var data in cont.supplierLedgerReportList)
                                  //   TableRow(
                                  //       children: [
                                  //         buildTableSubtitleForReport(context,data.debitBalance.toString()),
                                  //         buildTableSubtitleForReport(context,data.pattiDate.toString()),
                                  //       ]
                                  //   ),
                                  // TableRow(
                                  //     children: [
                                  //       buildTableSubtitleForReport(context,cont.totalSupplierLedgerShortReportAmt.toString(),fontWeight: FontWeight.bold),
                                  //       buildTableSubtitleForReport(context,""),
                                  //     ]
                                  // ),
                                ],
                              ),
                            ),
                          )
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
