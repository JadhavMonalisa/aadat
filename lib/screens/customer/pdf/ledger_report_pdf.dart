import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class LedgerReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<CustomerLedgerReportDetails> ledgerReportListPdf,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(ledgerReportListPdf.length<=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Customer Ledger Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Sr. No."),
                  buildTitleForTable("Receipt Date"),
                  buildTitleForTable("Receipt Narration"),
                  buildTitleForTable("Receipt Amt"),
                  buildTitleForTable("Payment Date"),
                  buildTitleForTable("Payment Narration"),
                  buildTitleForTable("Payment Amt"),
                ],
              ),
              for(int i = 0 ;i < ledgerReportListPdf.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].srNo.toString()),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptDate!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptNarration!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptAmount!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentDate!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentNarration!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentAmonut!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : cont.totalReceiptAmt.toString()),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : cont.totalPaymentAmt.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    else{
      int divideValue = ledgerReportListPdf.length ~/ 10;
      int modeValue = ledgerReportListPdf.length % 10;

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
          buildHeader("Customer Ledger Report",cont): Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Sr. No."),
                    buildTitleForTable("Receipt Date"),
                    buildTitleForTable("Receipt Narration"),
                    buildTitleForTable("Receipt Amt"),
                    buildTitleForTable("Payment Date"),
                    buildTitleForTable("Payment Narration"),
                    buildTitleForTable("Payment Amt"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].srNo.toString()),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptDate!),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptNarration!),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptAmount!),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentDate!),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentNarration!),
                      buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentAmonut!),
                    ],
                  ),
              ],
            )
          ],
        ));
      }

      if(endIndex<ledgerReportListPdf.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Customer Ledger Report",cont): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Sr. No."),
                  buildTitleForTable("Receipt Date"),
                  buildTitleForTable("Receipt Narration"),
                  buildTitleForTable("Receipt Amt"),
                  buildTitleForTable("Payment Date"),
                  buildTitleForTable("Payment Narration"),
                  buildTitleForTable("Payment Amt"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].srNo.toString()),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptDate!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptNarration!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].recieptAmount!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentDate!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentNarration!),
                    buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ledgerReportListPdf[i].paymentAmonut!),
                  ],
                ),
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : cont.totalReceiptAmt.toString()),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : ""),
                  buildRowTextForTable(ledgerReportListPdf.isEmpty ? "" : cont.totalPaymentAmt.toString()),
                ],
              ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }

    return PdfApi.saveDocument(name: 'Ledger Report.pdf', pdf: pdf);
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
                Text("From Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedSupplierLedgerFromDateToShow), Spacer(),
                Text("To Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedSupplierLedgerToDate),
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