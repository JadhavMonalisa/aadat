import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/common_widget/widget.dart';
import 'package:get/get.dart';

class CustomerLedgerReport extends StatefulWidget {
  const CustomerLedgerReport({Key? key}) : super(key: key);

  @override
  State<CustomerLedgerReport> createState() => _CustomerLedgerReportState();
}

class _CustomerLedgerReportState extends State<CustomerLedgerReport> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromReportToHome();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Customer Ledger Report", whiteColor, context, 16.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.navigateFromReportToHome();
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
                          padding: const EdgeInsets.only(top: 30.0,bottom: 20.0),
                          child: buildTextRegularWidget("CUSTOMER LEDGER REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),
                        
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0,left: 50.0,right: 50.0),
                          child: SizedBox(
                              height: 40.0,
                              child: Center(
                                  child: Container(
                                    width: 230.0,height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color:primaryColor),),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                                      child: DropdownButton<String>(
                                        hint: buildTextBoldWidget(cont.selectedCustomer==""?"Select Customer":cont.selectedCustomer,
                                            primaryColor, context, 15.0),
                                        isExpanded: true,
                                        underline: Container(),
                                        icon: const Icon(Icons.arrow_drop_down,color: primaryColor,size: 30.0,),
                                        items:
                                        cont.customerList.isEmpty
                                            ?
                                        cont.noDataList.map((value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: buildTextBoldWidget(value, primaryColor, context, 15.0,align: TextAlign.left),
                                          );
                                        }).toList()
                                            :
                                        cont.customerList.map((CustomerListDetails value) {
                                          return DropdownMenuItem<String>(
                                            value: value.custAccountName,
                                            child: buildTextBoldWidget(value.custAccountName!, primaryColor, context, 15.0),
                                            onTap: (){
                                            },
                                          );
                                        }).toList(),
                                        onChanged: (val) {
                                          cont.updateSelectedCustomer(val!);
                                        },
                                      ),
                                    ),
                                  )
                              )
                          ),
                        ),

                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectCustomerDate(context,"fromDate");
                                },
                                child: Container(
                                  height: 40.0,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    border: Border.all(color:primaryColor),),
                                  child: Row(
                                    children: [
                                      const SizedBox(width: 10.0,),
                                      buildTextRegularWidget(cont.selectedFromDateToShow==""?"From Date":cont.selectedFromDateToShow, primaryColor, context, 15.0),
                                      const Spacer(),
                                      const Icon(Icons.calendar_month,color: primaryColor,),
                                      const SizedBox(width: 10.0,)
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10.0,),
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectCustomerDate(context,"toDate");
                                },
                                child: Container(
                                    height: 40.0,
                                    decoration: BoxDecoration(
                                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                                      border: Border.all(color:primaryColor),),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 10.0,),
                                        buildTextRegularWidget(cont.selectedToDateToShow==""?"To Date":cont.selectedToDateToShow, primaryColor, context, 15.0),
                                        const Spacer(),
                                        const Icon(Icons.calendar_month,color: primaryColor,),
                                        const SizedBox(width: 10.0,)
                                      ],
                                    )
                                ),
                              ),
                            )
                          ],
                        ),

                        Padding(
                          padding: const EdgeInsets.only(left: 100.0,right: 100.0,top: 20.0),
                          child:GestureDetector(
                            onTap: (){
                              cont.showCustomerLedgerReport();
                            },
                            child:  buildButtonWidget(context, "Get Report", buttonColor: orangeColor),
                          )
                        )
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
