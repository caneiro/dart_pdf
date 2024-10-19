import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import '../data.dart';

Future<Uint8List> generateLOTOdraft(PdfPageFormat format, CustomData data) async {
  final pdf = pw.Document(title: 'LOTO Draft');

  // Load the first logo as an image from assets
  final Uint8List logoBytes1 = (await rootBundle.load('assets/loto-logo.png')).buffer.asUint8List();
  final pw.MemoryImage logoImage1 = pw.MemoryImage(logoBytes1);

  // Load the second logo as an image from assets
  final Uint8List logoBytes2 = (await rootBundle.load('assets/loto-logo-amazon.png')).buffer.asUint8List();
  final pw.MemoryImage logoImage2 = pw.MemoryImage(logoBytes2);

  // Load SVG as a string from assets
  final String svgHeader = await rootBundle.loadString('assets/loto-header-bars.svg');

  pdf.addPage(
    pw.MultiPage(
      pageFormat: format,  // Use the format passed to the function
      margin: pw.EdgeInsets.all(12),
      header: (pw.Context context) {
        return pw.Container(
          alignment: pw.Alignment.center,
          child: pw.Stack(
            children: [
              pw.Column(
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  // First logo positioned at the top-left
                  pw.Image(
                    logoImage1,
                    width: 100,  // Adjust the width as needed
                    height: 100, // Adjust the height as needed
                  ),
                  pw.SizedBox(height: 10),  // Spacing between logo and SVG

                  // SVG header below the first logo
                  pw.SvgImage(
                    svg: svgHeader,  // Use the loaded SVG string
                    fit: pw.BoxFit.contain,
                    width: double.infinity,  // Adjust the width as needed
                    height: 100,  // Adjust the height as needed
                  ),
                ],
              ),
              // Second logo on top-right of the header
              pw.Positioned(
                right: 0,
                top: 0,
                child: pw.Image(
                  logoImage2,
                  width: 100,  // Adjust the width as needed
                  height: 100, // Adjust the height as needed
                ),
              ),
              // Text in the center of the header/SVG
              pw.Positioned(
                left: 0,
                right: 0,
                top: 50,  // Adjust the vertical positioning of the text
                child: pw.Center(
                  child: pw.Text(
                    'LOTO SAFETY PROCEDURE',
                    style: pw.TextStyle(
                      fontSize: 20,  // Adjust the font size as needed
                      fontWeight: pw.FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
      build: (pw.Context context) {
        return <pw.Widget>[
          // Your page content goes here
          pw.Text('BLABLABLALBLA'), // Example of using CustomData
        ];
      },
    ),
  );

  // Return the generated PDF as bytes
  return pdf.save();
}