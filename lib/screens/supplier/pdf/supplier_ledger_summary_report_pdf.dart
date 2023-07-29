import 'dart:io';

import 'package:adat/screens/common/pdf_api.dart';
import 'package:flutter/services.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:adat/screens/supplier/supplier_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class SupplierLedgerSummaryReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<SupplierLedgerSummaryReportDetails> supplierLedgerSummaryReportList,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(supplierLedgerSummaryReportList.length<=10){
      print("in if block");
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Supplier Ledger Summary Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Account No"),
                  buildTitleForTable("Supplier"),
                  buildTitleForTable("Mobile No"),
                  buildTitleForTable("Debit Amt"),
                  buildTitleForTable("Credit Amt"),
                ],
              ),
              for(int i = 0 ;i < supplierLedgerSummaryReportList.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].acctNO!),
                    buildRowTextForTableMarathi(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].suppAccountName!,ttf),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].mobile!),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].debitAmount!),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].creditAmount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                  buildRowTextForTable("Total"),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportDebit.toString()),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportCredit.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    else{
      print("in else if block");
      int divideValue = supplierLedgerSummaryReportList.length ~/ 10;
      int modeValue = supplierLedgerSummaryReportList.length % 10;

      if(modeValue==0){
        totalLength = divideValue;
      }
      else {
        totalLength = divideValue + 1;
      }

      for(int i = 0; i<totalLength-1; i++ ) {
        startIndex = i == 0 ? 0 : startIndex + 10;
        endIndex = i == 0 ? 10 : endIndex + 10;
        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) =>
          i ==0?
          buildHeader("Supplier Ledger Summary Report",cont): Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Account No"),
                    buildTitleForTable("Supplier"),
                    buildTitleForTable("Mobile No"),
                    buildTitleForTable("Debit Amt"),
                    buildTitleForTable("Credit Amt"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].acctNO!),
                      buildRowTextForTableMarathi(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].suppAccountName!,ttf),
                      buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].mobile!),
                      buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].debitAmount!),
                      buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].creditAmount!),
                    ],
                  ),
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                    buildRowTextForTable("Total"),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportDebit.toString()),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportCredit.toString()),
                  ],
                ),
              ],
            )
          ],
        ));
      }

      if(endIndex<supplierLedgerSummaryReportList.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Supplier Ledger Summary Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Account No"),
                  buildTitleForTable("Supplier"),
                  buildTitleForTable("Mobile No"),
                  buildTitleForTable("Debit Amt"),
                  buildTitleForTable("Credit Amt"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].acctNO!),
                    buildRowTextForTableMarathi(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].suppAccountName!,ttf),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].mobile!),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].debitAmount!),
                    buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : supplierLedgerSummaryReportList[i].creditAmount!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : ""),
                  buildRowTextForTable("Total"),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportDebit.toString()),
                  buildRowTextForTable(supplierLedgerSummaryReportList.isEmpty ? "" : cont.totalSupplierLedgerSummaryReportCredit.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    return PdfApi.saveDocument(name: 'Supplier Ledger Summary Report.pdf', pdf: pdf);
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
      Align(
          alignment: Alignment.center,
          child:Text(cont.selectedCustomer,style: TextStyle(fontWeight: FontWeight.bold))
      ),
      pw.SizedBox(height: 20),
      Padding(
          padding: const EdgeInsets.only(left: 10.0,top: 5.0),
          child:Row(
              children: [
                Text("From Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedLedgerSummaryFromDate), Spacer(),
                Text("To Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedLedgerSummaryToDate),
              ]
          )),
    ],
  );

  /// Build widget to design row text for table
  static Widget buildTitleForTable(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: 2.0,bottom: 2.0,left: 7,right: 2.0),
      child: Text(title, style: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),textAlign: TextAlign.center,),
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