import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:pdf_creator/Services/pdf_service.dart';

class ViewPdfScreen extends StatefulWidget {
  const ViewPdfScreen({super.key, required this.pdf});

  final File pdf;

  @override
  State<ViewPdfScreen> createState() => _ViewPdfScreenState();
}

class _ViewPdfScreenState extends State<ViewPdfScreen> {
  int pageNo = 0;
  int totalPages = 0;

  String getPdfName() {
    try {
      var filePath = widget.pdf.path;
      var splitPath = filePath.split('/');
      var fileName = splitPath.last;
      return fileName;
    } catch (e) {
      return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          getPdfName(),
          style: const TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: () {
              PdfService.sharePdf(widget.pdf);
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Center(
        child: PDFView(
          filePath: widget.pdf.path,
          onPageChanged: (page, total) {
            if (page != null && total != null) {
              setState(() {
                pageNo = page;
                totalPages = total;
              });
            }
          },
        ),
      ),
      bottomNavigationBar: Container(
        height: 50,
        alignment: Alignment.center,
        color: Colors.white,
        child: Text('Page ${pageNo + 1} of $totalPages'),
      ),
    );
  }
}
