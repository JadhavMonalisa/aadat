import 'dart:convert';
import 'dart:io';

import 'package:adat/constant/api_endpoint.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:adat/theme/app_text_theme.dart';
import 'package:flutter/material.dart';
import 'package:adat/theme/app_colors.dart';
import 'package:adat/common_widget/widget.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:easy_search_bar/easy_search_bar.dart';

class SupplierLedgerReport extends StatefulWidget {
  const SupplierLedgerReport({Key? key}) : super(key: key);

  @override
  State<SupplierLedgerReport> createState() => _SupplierLedgerReportState();
}

class _SupplierLedgerReportState extends State<SupplierLedgerReport> {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (cont)
    {
      return WillPopScope(
        onWillPop: () async{
          return await cont.navigateFromReportToHomeScreen();
        },
        child: SafeArea(
            child: Scaffold(
              appBar: AppBar(
                backgroundColor: primaryColor,
                centerTitle: true,
                title: buildTextBoldWidget(
                    "Supplier Ledger Report", whiteColor, context, 16.0),
                leading: GestureDetector(
                    onTap: () {
                      cont.navigateFromReportToHomeScreen();
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
                          child: buildTextRegularWidget("SUPPLIER LEDGER REPORT FOR\n${cont.selectedFirm}", orangeColor, context, 16.0,align: TextAlign.center),
                        ),

                        // Padding(
                        //   padding: const EdgeInsets.only(top: 10.0,left: 50.0,right: 50.0),
                        //   child: SizedBox(
                        //       height: 40.0,
                        //       child: Center(
                        //           child: Container(
                        //             width: 230.0,height: 40.0,
                        //             decoration: BoxDecoration(
                        //               borderRadius: const BorderRadius.all(Radius.circular(5)),
                        //               border: Border.all(color:primaryColor),),
                        //             child: Padding(
                        //               padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                        //               child: DropdownButton<String>(
                        //                 hint: buildTextBoldWidget(cont.selectedSupplier==""?"Select Supplier":cont.selectedSupplier,
                        //                     primaryColor, context, 15.0),
                        //                 isExpanded: true,
                        //                 underline: Container(),
                        //                 icon: const Icon(Icons.arrow_drop_down,color: primaryColor,size: 30.0,),
                        //                 items:
                        //                 cont.supplierList.isEmpty
                        //                     ?
                        //                 cont.noDataList.map((value) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: value,
                        //                     child: buildTextBoldWidget(value, primaryColor, context, 15.0),
                        //                   );
                        //                 }).toList()
                        //                     :
                        //                 cont.supplierList.map((SupplierListDetails value) {
                        //                   return DropdownMenuItem<String>(
                        //                     value: value.suppAccountName,
                        //                     child: buildTextBoldWidget(value.suppAccountName!, primaryColor, context, 15.0),
                        //                     onTap: (){
                        //                     },
                        //                   );
                        //                 }).toList(),
                        //                 onChanged: (val) {
                        //                   cont.updateSelectedSupplier(val!);
                        //                 },
                        //               ),
                        //             ),
                        //           )
                        //       )
                        //   ),
                        // ),

                        Padding(
                          padding: const EdgeInsets.only(top: 10.0,bottom: 20.0,left: 50.0,right: 50.0),
                          child: Container(
                            height: 40.0,width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(5)),
                              border: Border.all(color:primaryColor),),
                            child: Scaffold(
                              backgroundColor: primaryColor,
                              appBar: EasySearchBar(
                                elevation: 0.0,
                                appBarHeight: 40.0,
                                backgroundColor: whiteColor,
                                searchBackgroundColor: whiteColor,
                                searchHintStyle: const TextStyle(color: primaryColor,fontSize: 15.0),
                                searchTextStyle: const TextStyle(color: primaryColor,fontSize: 15.0),
                                titleTextStyle: const TextStyle(color: primaryColor,fontSize: 15.0),
                                suggestionTextStyle: const TextStyle(color: primaryColor,fontSize: 15.0),
                                title:buildTextBoldWidget(cont.selectedSupplier==""?"Select Farmer":cont.selectedSupplier,
                                    primaryColor, context, 15.0),
                                onSearch: (value) {
                                  cont.updateSelectedSupplier(value);
                                  //cont.onSearchSelection(value);
                                },
                                suggestions: cont.supplierNameList,
                                onSuggestionTap: (str){
                                  print("str");
                                  print(str);
                                },
                              ),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Flexible(
                              child: GestureDetector(
                                onTap: (){
                                  cont.selectSupplierDate(context,"fromDate");
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
                                  cont.selectSupplierDate(context,"toDate");
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

                        cont.isLoading ? buildCircularIndicator() :
                        Padding(
                            padding: const EdgeInsets.only(left: 100.0,right: 100.0,top: 20.0),
                            child:GestureDetector(
                              onTap: (){
                                cont.showSupplierLedgerReport();
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
