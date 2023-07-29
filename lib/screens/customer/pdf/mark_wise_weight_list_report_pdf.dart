import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class MarkWiseWeightListReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<MarkWiseWeightListDetails> markWiseWeightListPdf,HomeController cont) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    if(markWiseWeightListPdf.length <=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Mark Wise Weight List Report",cont,markWiseWeightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Customer Mark"),
                  buildTitleForTable("Customer Name"),
                  buildTitleForTable("Total Quantity"),
                  buildTitleForTable("Total Weight"),
                  buildTitleForTable("Avg. Rate"),
                ],
              ),
              for(int i = 0 ;i < markWiseWeightListPdf.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].mark!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].custAccountName!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].qty!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].weight!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].amount!),
                  ],
                ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    else{
      int divideValue = markWiseWeightListPdf.length ~/ 10;
      int modeValue = markWiseWeightListPdf.length % 10;

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
          buildHeader("Mark Wise Weight List Report",cont,markWiseWeightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Customer Mark"),
                    buildTitleForTable("Customer Name"),
                    buildTitleForTable("Total Quantity"),
                    buildTitleForTable("Total Weight"),
                    buildTitleForTable("Avg. Rate"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].mark!),
                      buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].custAccountName!),
                      buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].qty!),
                      buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].weight!),
                      buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].amount!),
                    ],
                  ),
              ],
            )
          ],
        ));
      }

      if(endIndex<markWiseWeightListPdf.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Mark Wise Weight List Report",cont,markWiseWeightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Customer Mark"),
                  buildTitleForTable("Customer Name"),
                  buildTitleForTable("Total Quantity"),
                  buildTitleForTable("Total Weight"),
                  buildTitleForTable("Avg. Rate"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].mark!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].custAccountName!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].qty!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].weight!),
                    buildRowTextForTable(markWiseWeightListPdf.isEmpty ? "" : markWiseWeightListPdf[i].amount!),
                  ],
                ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }

    return PdfApi.saveDocument(name: 'Mark Wise Weight List Report.pdf', pdf: pdf);
  }

  ///pdf header
  static Widget buildHeader(String title,HomeController cont,String customerName) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Align(
          alignment: Alignment.center,
          child:Text(title,style: TextStyle(fontWeight: FontWeight.bold))
      ),
      pw.SizedBox(height: 20),
      Align(
          alignment: Alignment.center,
          child:Text(customerName,style: TextStyle(fontWeight: FontWeight.bold))
      ),
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
}