import 'dart:io';
import 'package:adat/screens/customer/customer_model.dart';
import 'package:adat/screens/common/pdf_api.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

class PdfSubscriptionHistoryApi {

  static int startIndex = 0;
  static int endIndex = 0;
  //static int totalLength = 0;

  static Future<File> generate(List<WeightListDetails> weightListPdf, int totalLength) async {
    final pdf = Document();
    final font = await rootBundle.load("assets/font/Hindi.ttf");
    final ttf = pw.Font.ttf(font);

    int divideValue = weightListPdf.length ~/ 10;
    int modeValue = weightListPdf.length % 10;

    totalLength = divideValue + modeValue;

    for(int i = 0; i<=totalLength; i++ ) {
      startIndex = i == 0 ? startIndex = 0 : startIndex + 10;

      if(weightListPdf.length < endIndex){
        endIndex = startIndex + modeValue;
      }
      else{
        endIndex = endIndex + 10;
      }

      pdf.addPage(MultiPage(
      pageFormat: PdfPageFormat.letter,
      header: (context) => buildHeader(weightListPdf[0].billDate!,weightListPdf[0].custAccountName!),
      build: (context) => [
        SizedBox(height: 0.2 * PdfPageFormat.cm),
        Table(
          border:TableBorder.all(width: 0.1,color: PdfColor.fromHex("#9E9E9E")),
          defaultColumnWidth: const IntrinsicColumnWidth(),
          children: [
            TableRow(
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
            for(int i = startIndex ;i < endIndex ; i++)
              TableRow(
                children: [
                  buildRowTextForTable(weightListPdf.isEmpty ? "" : "${weightListPdf[i].billDate}"),
                  buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[i].custAccountName}"),
                  buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[i].remark}"),
                  buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[i].qty}"),
                  buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[i].weight}"),
                  buildRowTextForTable(weightListPdf.isEmpty ? "" :"${weightListPdf[i].rate}"),
                  buildRowTextForTableMarathi(weightListPdf.isEmpty ? "" :"${weightListPdf[i].suppAccountName}",ttf),
                ],
              ),
          ],
        )
      ],
      ));
    }
    return PdfApi.saveDocument(name: 'weight_list.pdf', pdf: pdf);
  }

  ///pdf header
  static Widget buildHeader(String billDate, String customerName) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Text(billDate),
          SizedBox(width: 100),
          Text(customerName),
        ],
      ),
      pw.SizedBox(height: 20),
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
      child: Text(title, style: TextStyle(fontSize: 13,color: PdfColor.fromHex("#546cb1")),textAlign: TextAlign.center,

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
