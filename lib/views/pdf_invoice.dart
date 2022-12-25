import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:library_managment_system/models/book_model.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

Future<Uint8List> generateInvoice(
    // PdfPageFormat pageFormat,
    BookModel bookModel,
    String issuedBy,
    String uniqueCode,
    String borrowerName,
    String borrowerEmail,
    DateTime issuedDate,
    DateTime dueDate) async {

  final invoice = Invoice(
    issueDate: issuedDate,
    duedate: dueDate,
    uniqueCode: uniqueCode,
    issuedBy: issuedBy,
    book: bookModel,
    customerName: borrowerName,
    customerEmail: borrowerEmail,
    baseColor: PdfColors.teal,
    accentColor: PdfColors.blueGrey900,
  );

  return await invoice.buildPdf(
    // pageFormat
  );
}

class Invoice {
  Invoice({
    required this.issueDate,
    required this.duedate,
    required this.issuedBy,
    required this.book,
    required this.customerName,
    required this.customerEmail,
    required this.uniqueCode,
    required this.baseColor,
    required this.accentColor,
  });

  final BookModel book;
  final String customerName;
  final String customerEmail;
  final String issuedBy;
  final String uniqueCode;
  final PdfColor baseColor;
  final PdfColor accentColor;
  final DateTime issueDate;
  final DateTime duedate;

  static const _darkColor = PdfColors.blueGrey800;
  static const _lightColor = PdfColors.white;

  // PdfColor get _baseTextColor =>
  //     baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfColor get _accentTextColor =>
      baseColor.luminance < 0.5 ? _lightColor : _darkColor;

  PdfImage ? _logo;
  Uint8List ? appLogo;

  Future<Uint8List> buildPdf(
      // PdfPageFormat pageFormat
      ) async {
    final doc = pw.Document();
    PdfPageFormat pageFormat = PdfPageFormat.a4;
  //  final font1 = ;
    final font = await rootBundle.load('assets/roboto1.ttf');
    appLogo = (await rootBundle.load('assets/library_icon.png')).buffer.asUint8List();

 //   final Uint8List fontData = File(font2).readAsBytesSync();

    final ttf = pw.Font.ttf(font);


    _logo = PdfImage.file(
      doc.document,
      bytes: (await rootBundle.load('assets/library_icon.png')).buffer.asUint8List(),
    );

    doc.addPage(
      pw.MultiPage(
        pageTheme: _buildTheme(
          pageFormat,
          ttf,
          ttf,
          ttf,
        ),
        header: _buildHeader,
        build: (context) => [
          _contentHeader(context),
          _contentTable(context),
          pw.SizedBox(height: 20),
          _contentFooter(context),
          pw.SizedBox(height: 20),
          _termsAndConditions(context),
        ],
      ),
    );

    // Return the PDF file content
    return doc.save();
  }

  pw.Widget _buildHeader(pw.Context context) {
    return pw.Column(
      children: [
        pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Expanded(
              child: pw.Column(
                children: [
                  pw.Container(
                    height: 50,
                    padding: const pw.EdgeInsets.only(left: 20),
                    alignment: pw.Alignment.centerLeft,
                    child: pw.Text(
                      'ISSUED',
                      style: pw.TextStyle(
                        color: baseColor,
                        fontWeight: pw.FontWeight.bold,
                        fontSize: 40,
                      ),
                    ),
                  ),
                  pw.Container(
                    decoration: pw.BoxDecoration(
                      borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
                      color: accentColor,
                    ),
                    padding: const pw.EdgeInsets.only(
                        left: 40, top: 10, bottom: 10, right: 20),
                    alignment: pw.Alignment.centerLeft,
                    height: 50,
                    child: pw.DefaultTextStyle(
                      style: pw.TextStyle(
                        color: _accentTextColor,
                        fontSize: 12,
                      ),
                      child: pw.GridView(
                        crossAxisCount: 2,
                        children: [
                          pw.Text('Invoice #'),
                          pw.Text(uniqueCode),
                          pw.Text('Issue Date:'),
                          pw.Text(_formatDate(this.issueDate)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            pw.Expanded(
              child: pw.Column(
                mainAxisSize: pw.MainAxisSize.min,
                children: [
                  pw.Container(
                    alignment: pw.Alignment.topRight,
                    padding: const pw.EdgeInsets.only(bottom: 8, left: 30),
                    height: 72,
                    child: _logo != null ? pw.Image(pw.MemoryImage(appLogo!)) : pw.PdfLogo(),
                  ),
                ],
              ),
            ),
          ],
        ),
        if (context.pageNumber > 1) pw.SizedBox(height: 20)
      ],
    );
  }

  pw.PageTheme _buildTheme(
      PdfPageFormat pageFormat, pw.Font base, pw.Font bold, pw.Font italic) {
    return pw.PageTheme(
      pageFormat: pageFormat,
      theme: pw.ThemeData.withFont(
        base: base,
        bold: bold,
        italic: italic,
      ),
      buildBackground: (context) => pw.FullPage(
        ignoreMargins: true,
        child: pw.Stack(
          children: [
            pw.Positioned(
              bottom: 0,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 2,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [baseColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              bottom: 20,
              left: 0,
              child: pw.Container(
                height: 20,
                width: pageFormat.width / 4,
                decoration: pw.BoxDecoration(
                  gradient: pw.LinearGradient(
                    colors: [accentColor, PdfColors.white],
                  ),
                ),
              ),
            ),
            pw.Positioned(
              top: pageFormat.marginTop + 72,
              left: 0,
              right: 0,
              child: pw.Container(
                height: 3,
                color: baseColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  pw.Widget _contentHeader(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          child: pw.Container(
            margin: const pw.EdgeInsets.symmetric(horizontal: 20),
            height: 70,
            child: pw.FittedBox(
              child: pw.Text(
                'Due : ' + _formatDate(this.duedate),
                style: pw.TextStyle(
                  color: baseColor,
                  fontStyle: pw.FontStyle.italic,
                ),
              ),
            ),
          ),
        ),
        pw.Expanded(
          child: pw.Row(
            children: [
              pw.Container(
                margin: const pw.EdgeInsets.only(left: 10, right: 10),
                height: 70,
                child: pw.Text(
                  'Invoice to:',
                  style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Container(
                  height: 70,
                  child: pw.RichText(
                      text: pw.TextSpan(
                          text: '$customerName\n',
                          style: pw.TextStyle(
                            color: _darkColor,
                            fontWeight: pw.FontWeight.bold,
                            fontSize: 12,
                          ),
                          children: [
                            const pw.TextSpan(
                              text: '\n',
                              style: pw.TextStyle(
                                fontSize: 5,
                              ),
                            ),
                            pw.TextSpan(
                              text: customerEmail,
                              style: pw.TextStyle(
                                fontWeight: pw.FontWeight.normal,
                                fontSize: 10,
                              ),
                            ),
                            // const pw.TextSpan(
                            //   text: '\n',
                            //   style: pw.TextStyle(
                            //     fontSize: 5,
                            //   ),
                            // ),
                            // pw.TextSpan(
                            //   text: customerPhone,
                            //   style: pw.TextStyle(
                            //     fontWeight: pw.FontWeight.normal,
                            //     fontSize: 10,
                            //   ),
                            // ),
                          ])),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _contentFooter(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Expanded(
          flex: 2,
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                'Thank you for Visiting',
                style: pw.TextStyle(
                    color: _darkColor,
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 20),
              ),
              pw.Container(
                margin: const pw.EdgeInsets.only(top: 20, bottom: 8),
                child: pw.Text(
                  "Issued By",
                  style: pw.TextStyle(
                    fontSize: 15,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                issuedBy,
                style: const pw.TextStyle(
                  fontSize: 12,
                  lineSpacing: 5,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  pw.Widget _termsAndConditions(pw.Context context) {
    return pw.Row(
      crossAxisAlignment: pw.CrossAxisAlignment.end,
      children: [
        pw.Expanded(
          child: pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                decoration: pw.BoxDecoration(


                ),
                padding: const pw.EdgeInsets.only(top: 10, bottom: 4),
                child: pw.Text(
                  'Terms & Conditions',
                  style: pw.TextStyle(
                    fontSize: 15,
                    color: baseColor,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
              ),
              pw.Text(
                "* Return On Time",
                textAlign: pw.TextAlign.justify,
                style: const pw.TextStyle(
                  fontSize: 12,
                  lineSpacing: 2,
                  color: _darkColor,
                ),
              ),
            ],
          ),
        ),
        pw.Expanded(
          child: pw.SizedBox(),
        ),
      ],
    );
  }

  pw.Widget _contentTable(pw.Context context) {
    return pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(
            "Book Details ",
            style: pw.TextStyle(
              color: baseColor,
              fontWeight: pw.FontWeight.bold,
              fontSize: 30,
            ),
          ),
          pw.Text(
            "Name        : " + book.bookName,
            style: pw.TextStyle(
              color: PdfColors.cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
          pw.Text(
            "Author       :" + book.bookAuthor,
            style: pw.TextStyle(
              color: PdfColors.cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
          pw.Text(
            "Genre        : " + book.categories,
            style: pw.TextStyle(
              color: PdfColors.cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
          pw.Text(
            "Unique ID : " + book.bookCode,
            style: pw.TextStyle(
              color: PdfColors.cyan,
              fontWeight: pw.FontWeight.bold,
              fontSize: 15,
            ),
          ),
        ]);
  }
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}
