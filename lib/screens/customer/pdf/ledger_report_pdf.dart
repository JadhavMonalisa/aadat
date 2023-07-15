import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/customer/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class LedgerShortReportExportScreen {

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
        buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
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

      if(divideValue<modeValue){
        totalLength = divideValue + 1;
      }

      for(int i = 0; i<totalLength-1; i++ ) {
        startIndex = i == 0 ? 0 : startIndex + 10;
        endIndex = i == 0 ? 10 : endIndex + 10;

        pdf.addPage(MultiPage(
          pageFormat: PdfPageFormat.letter,
          header: (context) =>
          i ==0?
          buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
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
        buildHeader("Customer Ledger Short Report",cont): Opacity(opacity: 0.0),
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

    return PdfApi.saveDocument(name: 'Ledger Short Report.pdf', pdf: pdf);
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
                Text("From Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedFromDateToShow), Spacer(),
                Text("To Date : ",style: TextStyle(fontWeight: FontWeight.bold)), Text(cont.selectedFromDateToShow),
              ]
          )),
    ],
  );

  ///invoice details
  static Widget buildWeightListDetails(List<WeightListDetails> weightListPdf,Font ttf,int startIndex,int endIndex) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Center(
        child: Text("Weight List (Rough Bill)",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold)),
      ),
      pw.SizedBox(height: 7),
      pw.Divider(color: PdfColor.fromHex("#E0E0E0")),
      pw.SizedBox(height: 10),
      Table(
        border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [
          TableRow(
            decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
            children: [
              buildTitleForTable("Bill Date"),
              buildTitleForTable("Customer"),
              buildTitleForTable("LOT No"),
              buildTitleForTable("Quantity"),
              buildTitleForTable("Weight"),
              buildTitleForTable("Rate"),
              buildTitleForTable("Supplier"),
            ],
          ),
          for(var data = startIndex; data < endIndex; data++)
            TableRow(
              decoration: BoxDecoration(color: PdfColor.fromHex("#C0C0C0")),
              children: [
                buildRowTextForTable(weightListPdf.isEmpty ? "" : "${weightListPdf[data].billDate}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].custAccountName}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].remark}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].qty}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].weight}"),
                buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[data].rate}"),
                buildRowTextForTableMarathi(weightListPdf.isEmpty ? "" :"${weightListPdf[data].suppAccountName}",ttf),
              ],
            ),
        ],
      )
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

  ///build GST container
  static Widget buildGstContainer(String gstTitle, String gstAmount,double space, MemoryImage iconRupees){
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 0.0,color: PdfColor.fromHex("#9E9E9E")),
      ),
      child: buildGSTText(gstTitle,gstAmount,space,iconRupees),
    );
  }

  /// Build widget to design GST row text
  static Widget buildGSTText(String gstTitle,String gstAmnt,double space, MemoryImage iconRupees,) {
    return Padding(
      padding: const EdgeInsets.only(left: 3.0),
      child: Row(
        children: [
          Text(gstTitle, style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
          SizedBox(width: space),
          pw.Image(iconRupees,height: 12,),
          Text(gstAmnt,style: TextStyle(fontSize: 12,fontWeight: FontWeight.normal),textAlign: TextAlign.center,),
        ],
      ),
    );
  }

  ///Build widget to design for Payment row text
  static Widget buildRowTextPayment(String firstText, String firstText1,String secondText,String secondText1,){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildRowText(firstText,firstText1,1,),
        Spacer(),
        buildRowText(secondText,secondText1,1,),
      ],
    );
  }

  ///pdf footer
  static Widget buildFooter(WeightListDetails invoice) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      SizedBox(height: 15,),
      buildSimpleFooterText(title: 'file:///C:/Users/91966/Downloads/subscription_invoice.html',),
    ],
  );

  ///text widget for footer
  static buildSimpleFooterText({String? title,}) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title!, style: style),
      ],
    );
  }

  ///Build widget to design for last row text
  static Widget buildRowTextLast(String firstText, String firstText1,String secondText,String secondText1,double space){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        buildRowText(firstText,firstText1,1,),
        SizedBox(width: space),
        buildRowText(secondText,secondText1,1,),
      ],
    );
  }

  ///Build widget to design for all normal row text
  static buildRowText(String firstText, String secondText,double space,){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText,style: TextStyle(fontSize: 14,fontWeight: FontWeight.normal, ),),
        SizedBox(width: space),
        Text(secondText,style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.normal,color: PdfColor.fromHex("#546cb1")),textAlign: TextAlign.justify,),
      ],
    );
  }
  ///Build widget to design for all normal row text
  static buildRowTextForNet(String firstText, String secondText,double space,){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(firstText,style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: PdfColor.fromHex("#ed6950")),),
        SizedBox(width: space),
        Text(secondText,style: TextStyle(fontSize: 13.5,fontWeight: FontWeight.normal,color: PdfColor.fromHex("#ed6950")),textAlign: TextAlign.justify,),
      ],
    );
  }

  static buildSimpleText({String? title, String? value,}) {
    final style = TextStyle(fontWeight: FontWeight.bold);
    return Row(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        Text(title!, style: style),
        SizedBox(width: 2 * PdfPageFormat.mm),
        Text(value!),
      ],
    );
  }
}