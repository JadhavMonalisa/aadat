import 'package:adat/common_widget/widget.dart';
import 'package:adat/routes/app_pages.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomerLedgerShortReportResultScreen extends StatefulWidget {
  const CustomerLedgerShortReportResultScreen({Key? key}) : super(key: key);

  @override
  State<CustomerLedgerShortReportResultScreen> createState() => _CustomerLedgerShortReportResultScreenState();
}

class _CustomerLedgerShortReportResultScreenState extends State<CustomerLedgerShortReportResultScreen> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.backPressNavigation(AppRoutes.customerLedgerShortReport);
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Ledger Short Report Result", whiteColor, context, 15.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.backPressNavigation(AppRoutes.customerLedgerShortReport);
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
                          child: buildTextRegularWidget("CUSTOMER LEDGER SHORT REPORT FOR\n${cont.selectedCustomer} "
                              "from ${cont.selectedShortReportFromDateToShow} to ${cont.selectedShortReportToDateToShow} "
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
                                defaultColumnWidth: const IntrinsicColumnWidth(),
                                children: [
                                  TableRow(
                                      children: [
                                        buildTableTitleForReport(context,"Amount"),
                                        buildTableTitleForReport(context,"Account Name"),
                                        buildTableTitleForReport(context,"Bill Date"),
                                        buildTableTitleForReport(context,"Account No"),
                                      ]
                                  ),
                                  for (var data in cont.ledgerShortReportList)
                                    TableRow(
                                        children: [
                                          buildTableSubtitleForReport(context,data.amount.toString()),
                                          buildTableSubtitleForReport(context,data.accountName!),
                                          buildTableSubtitleForReport(context,data.billDate!),
                                          buildTableSubtitleForReport(context,data.acctNo.toString()),
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
