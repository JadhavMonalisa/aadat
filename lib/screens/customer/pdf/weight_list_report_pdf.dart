import 'dart:io';

import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:adat/screens/home/home_controller.dart';
import 'package:pdf/widgets.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class WeightListReportExportScreen {

  static int startIndex = 0;
  static int endIndex = 0;
  static int totalLength = 0;

  static Future<File> generate(List<WeightListDetails> weightListPdf,HomeController cont) async {
    final pdf = Document();

    if(weightListPdf.length <=10){
      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Weight List Report",cont,weightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Bill Date"),
                  buildTitleForTable("Customer"),
                  buildTitleForTable("LOT No."),
                  buildTitleForTable("Quantity"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Supplier"),
                ],
              ),
              for(int i = 0 ;i < weightListPdf.length ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].billDate!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].custAccountName!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].remark!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].qty!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].weight!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].rate!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].suppAccountName!),
                  ],
                ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    else{
      int divideValue = weightListPdf.length ~/ 10;
      int modeValue = weightListPdf.length % 10;

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
          buildHeader("Weight List Report",cont,weightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
          build: (context) => [
            SizedBox(height: 0.2 * PdfPageFormat.cm),
            Table(
              border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
              defaultColumnWidth: const IntrinsicColumnWidth(),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                  children: [
                    buildTitleForTable("Bill Date"),
                    buildTitleForTable("Customer"),
                    buildTitleForTable("LOT No."),
                    buildTitleForTable("Quantity"),
                    buildTitleForTable("Weight"),
                    buildTitleForTable("Rate"),
                    buildTitleForTable("Supplier"),
                  ],
                ),
                for(int i = startIndex ;i < endIndex ; i++)
                  TableRow(
                    decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                    children: [
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].billDate!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].custAccountName!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].remark!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].qty!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].weight!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].rate!),
                      buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].suppAccountName!),
                    ],
                  ),
              ],
            )
          ],
        ));
      }

      if(endIndex<weightListPdf.length){
        startIndex = startIndex + 10;
        endIndex = endIndex + modeValue;
      }

      pdf.addPage(MultiPage(
        pageFormat: PdfPageFormat.letter,
        header: (context) =>
        startIndex ==0?
        buildHeader("Weight List Report",cont,weightListPdf[0].custAccountName!): Opacity(opacity: 0.0),
        build: (context) => [
          SizedBox(height: 0.2 * PdfPageFormat.cm),
          Table(
            border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
            defaultColumnWidth: const IntrinsicColumnWidth(),
            children: [
              TableRow(
                decoration: BoxDecoration(color: PdfColor.fromHex("#808080")),
                children: [
                  buildTitleForTable("Bill Date"),
                  buildTitleForTable("Customer"),
                  buildTitleForTable("LOT No."),
                  buildTitleForTable("Quantity"),
                  buildTitleForTable("Weight"),
                  buildTitleForTable("Rate"),
                  buildTitleForTable("Supplier"),
                ],
              ),
              for(int i = startIndex ;i < endIndex ; i++)
                TableRow(
                  decoration: BoxDecoration(color: PdfColor.fromHex("#E5E4E2")),
                  children: [
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].billDate!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].custAccountName!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].remark!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].qty!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].weight!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].rate!),
                    buildRowTextForTable(weightListPdf.isEmpty ? "" : weightListPdf[i].suppAccountName!),
                  ],
                ),
            ],
          ),
          SizedBox(height: 0.2 * PdfPageFormat.cm),
        ],
      ));
    }
    return PdfApi.saveDocument(name: 'Weight List Report.pdf', pdf: pdf);
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
}