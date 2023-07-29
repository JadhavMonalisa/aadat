import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class LedgerShortReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<LedgerShortReportDetails> ledgerShortReportListPdf,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(cont.add<=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          // ListView.builder(
          //     itemCount: ledgerShortReportListPdf.length,
          //     itemBuilder: (context,index){
          //       return
          //         Column(
          //             children: [
          //               buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
          //               SizedBox(height: 0.4 * PdfPageFormat.cm),
          //               Table(
          //                 border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
          //                 defaultColumnWidth: const IntrinsicColumnWidth(),
          //                 children: [
          //                   TableRow(
          //                     decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
          //                     children: [
          //                       buildTitleForTable("Date"),
          //                       buildTitleForTable("Amount"),
          //                     ],
          //                   ),
          //                   for(int j = startIndex ;j < endIndex ; j++)
          //                     TableRow(
          //                       decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
          //                       children: [
          //                         buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
          //                         buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
          //                       ],
          //                     ),
          //                   TableRow(
          //                     decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
          //                     children: [
          //                       buildTitleForTable("Total"),
          //                       buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
          //                       cont.totalCustomerLedgerShortAmtList[index].toString()),
          //                     ],
          //                   ),
          //                 ],
          //               ),
          //               SizedBox(height: 0.6 * PdfPageFormat.cm),
          //             ]
          //         );
          //     })
          for(int index = startIndex ;index < endIndex ; index++)
            Column(
                children: [
                  buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
                  SizedBox(height: 0.4 * PdfPageFormat.cm),
                  Table(
                    border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
                    defaultColumnWidth: const IntrinsicColumnWidth(),
                    children: [
                      TableRow(
                        decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                        children: [
                          buildTitleForTable("Date"),
                          buildTitleForTable("Amount"),
                        ],
                      ),
                      // for(int j = startIndex ;j < endIndex ; j++)
                      //   TableRow(
                      //     decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                      //     children: [
                      //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
                      //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
                      //     ],
                      //   ),
                      // TableRow(
                      //   decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                      //   children: [
                      //     buildTitleForTable("Total"),
                      //     buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                      //     cont.totalCustomerLedgerShortAmtList[index].toString()),
                      //   ],
                      // ),
                    ],
                  ),
                  SizedBox(height: 0.6 * PdfPageFormat.cm),
                ]
            )
        ],
      ));
    }
    else{
      int divideValue = cont.add ~/ 10;
      int modeValue = cont.add % 10;

      print(divideValue);
      print(modeValue);

      if(modeValue==0){
        totalLength = divideValue;
      }
      else {
        totalLength = divideValue + 1;
      }

      print("totalLength");
      print(totalLength);
      for(int i = 0; i<totalLength-1; i++ ) {
        startIndex = i == 0 ? 0 : startIndex + 10;
        endIndex = i == 0 ? 10 : endIndex + 10;

        print("start : ${startIndex}");
        print("end : ${endIndex}");

        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) =>
          i == 0 ?
          buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            // ListView.builder(
            // itemCount: ledgerShortReportListPdf.length,
            // itemBuilder: (context,index){
            //   return
            //     Column(
            //       children: [
            //         buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
            //         SizedBox(height: 0.4 * PdfPageFormat.cm),
            //         Table(
            //           border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            //           defaultColumnWidth: const IntrinsicColumnWidth(),
            //           children: [
            //             TableRow(
            //               decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //               children: [
            //                 buildTitleForTable("Date"),
            //                 buildTitleForTable("Amount"),
            //               ],
            //             ),
            //             // for(int j = startIndex ;j < endIndex ; j++)
            //             //   TableRow(
            //             //     decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
            //             //     children: [
            //             //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
            //             //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
            //             //     ],
            //             //   ),
            //             // TableRow(
            //             //   decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //             //   children: [
            //             //     buildTitleForTable("Total"),
            //             //     buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
            //             //     cont.totalCustomerLedgerShortAmtList[index].toString()),
            //             //   ],
            //             // ),
            //           ],
            //         ),
            //         SizedBox(height: 0.6 * PdfPageFormat.cm),
            //       ]
            //     );
            // })

            for(int index = startIndex ;index < endIndex ; index++)
            // Column(
            //     children: [
            //       buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
            //       SizedBox(height: 0.4 * PdfPageFormat.cm),
            //       Table(
            //         border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            //         defaultColumnWidth: const IntrinsicColumnWidth(),
            //         children: [
            //           TableRow(
            //             decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //             children: [
            //               buildTitleForTable("Date"),
            //               buildTitleForTable("Amount"),
            //             ],
            //           ),
            //           for(int j = startIndex ;j < endIndex ; j++)
            //             TableRow(
            //               decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
            //               children: [
            //                 buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
            //                 buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
            //               ],
            //             ),
            //           TableRow(
            //             decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //             children: [
            //               buildTitleForTable("Total"),
            //               buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
            //               cont.totalCustomerLedgerShortAmtList[index].toString()),
            //             ],
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 0.6 * PdfPageFormat.cm),
            //     ]
            // )

              Table(
                border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
                defaultColumnWidth: const IntrinsicColumnWidth(),
                children: [
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                    children: [
                      buildTitleForTable("Date"),
                      buildTitleForTable("Amount"),
                    ],
                  ),
                  for(int j = startIndex ;j < endIndex ; j++)
                    TableRow(
                      decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                      children: [
                        buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
                        buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
                      ],
                    ),
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                    children: [
                      buildTitleForTable("Total"),
                      buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                      cont.totalCustomerLedgerShortAmtList[index].toString()),
                    ],
                  ),
                ],
              ),
          ],
        ));
      }

      if(endIndex<cont.add){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0 ?
        buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          // ListView.builder(
          //     itemCount: ledgerShortReportListPdf.length,
          //     itemBuilder: (context,index){
          //
          //     return Column(
          //             children: [
          //               buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
          //               SizedBox(height: 0.4 * PdfPageFormat.cm),
          //               Table(
          //                 border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
          //                 defaultColumnWidth: const IntrinsicColumnWidth(),
          //                 children: [
          //                   TableRow(
          //                     decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
          //                     children: [
          //                       buildTitleForTable("Date"),
          //                       buildTitleForTable("Amount"),
          //                     ],
          //                   ),
          //                   // for(int j = startIndex ;j < endIndex ; j++)
          //                   //   TableRow(
          //                   //     decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
          //                   //     children: [
          //                   //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
          //                   //       buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
          //                   //     ],
          //                   //   ),
          //                   // TableRow(
          //                   //   decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
          //                   //   children: [
          //                   //     buildTitleForTable("Total"),
          //                   //     buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
          //                   //     cont.totalCustomerLedgerShortAmtList[index].toString()),
          //                   //   ],
          //                   // ),
          //                 ],
          //               ),
          //               SizedBox(height: 0.6 * PdfPageFormat.cm),
          //             ]
          //         );
          // })
          for(int index = startIndex ;index < endIndex ; index++)
            // Column(
            //     children: [
            //       buildTitleForTable(ledgerShortReportListPdf[index].shortReportList![0].accountName!,),
            //       SizedBox(height: 0.4 * PdfPageFormat.cm),
            //       Table(
            //         border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            //         defaultColumnWidth: const IntrinsicColumnWidth(),
            //         children: [
            //           TableRow(
            //             decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //             children: [
            //               buildTitleForTable("Date"),
            //               buildTitleForTable("Amount"),
            //             ],
            //           ),
            //           for(int j = startIndex ;j < endIndex ; j++)
            //             TableRow(
            //               decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
            //               children: [
            //                 buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
            //                 buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
            //               ],
            //             ),
            //           TableRow(
            //             decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            //             children: [
            //               buildTitleForTable("Total"),
            //               buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
            //               cont.totalCustomerLedgerShortAmtList[index].toString()),
            //             ],
            //           ),
            //         ],
            //       ),
            //       SizedBox(height: 0.6 * PdfPageFormat.cm),
            //     ]
            // )
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Date"),
                    buildTitleForTable("Amount"),
                  ],
                ),
                for(int j = startIndex ;j < endIndex ; j++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].billDate!),
                      buildRowTextForTable(ledgerShortReportListPdf[index].shortReportList!.isEmpty ? "" : ledgerShortReportListPdf[index].shortReportList![j].amount!),
                    ],
                  ),
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Total"),
                    buildTitleForTable(cont.totalCustomerLedgerShortAmtList.isEmpty?"":
                    cont.totalCustomerLedgerShortAmtList[index].toString()),
                  ],
                ),
              ],
            ),
        ],
      ));
    }
    return PdfApi.saveDocument(name: 'Customer Ledger Short Report.pdf', pdf: pdf);
  }

  ///pdf header
  static Widget buildHeader(String title,HomeController cont) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.center,
          child:Text(title,style: TextStyle(fontWeight: FontWeight.bold))
      ),
      pw.SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 5.0),
          child:Row(
              children: [
                Text("From Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedShortReportFromDateToShow), Spacer(),
                Text("To Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedShortReportToDateToShow),
              ]
          )),
    ],
  );

  /// Build widget to design row text for table
  static Widget buildTitleForTable(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,left: 7,right: 2.0),
      child: Text(title, style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.right,),
    );
  }

  /// Build widget to design row text for table
  static Widget buildRowTextForTable(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 5.0,bottom: 5.0,left: 10.0),
      child: Text(title, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#000000")),textAlign: TextAlign.center,
      ),
    );
  }

  static Widget buildRowTextForTableMarathi(String title, Font ttf) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0,right: 5.0,bottom: 5.0,left: 10.0),
      child: Text(title, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#546cb1"),
          font: ttf
      ),textAlign: TextAlign.center,
      ),
    );
  }
}