import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pdf_creator/Screens/pdf_view_screen.dart';
import 'package:pdf_creator/Services/image_service.dart';
import 'package:pdf_creator/Services/pdf_service.dart';
import 'package:pdf_creator/main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> images = [];

  void _openCamera() async {
    final capturedImage = await ImageService.captureImage();

    if (capturedImage != null) {
      final croppedImage = await ImageService.cropImage(capturedImage);

      if (croppedImage != null) {
        setState(() {
          images.add(croppedImage);
        });
      }
    }
  }

  void _openGallery() async {
    final selectedImage = await ImageService.selectImage();

    if (selectedImage != null) {
      final croppedImage = await ImageService.cropImage(selectedImage);

      if (croppedImage != null) {
        setState(() {
          images.add(croppedImage);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Flutter Pdf Creator',
          style: TextStyle(fontSize: 18),
        ),
        actions: [
          IconButton(
            onPressed: images.isEmpty
                ? () {
                    ScaffoldMessenger.of(context).clearSnackBars();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text(
                          'Please pick some images',
                          style: TextStyle(color: Colors.black),
                        ),
                        backgroundColor: kPrimaryColor,
                      ),
                    );
                  }
                : () async {
                    final createdPdf = await PdfService.createPDF(images);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ViewPdfScreen(pdf: createdPdf)));
                  },
            icon: const Icon(
              Icons.picture_as_pdf,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: images.isEmpty
          ? Center(
              child: Text(
              'Choose Images to create pdf',
              style: TextStyle(color: Colors.white.withOpacity(0.5)),
            ))
          : GridView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: images.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemBuilder: (context, index) => Stack(
                children: [
                  Image.file(
                    images[index],
                    height: double.infinity,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () {
                        setState(() {
                          images.removeAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.remove_circle,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              ),
            ),
      floatingActionButton: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ElevatedButton(
            onPressed: _openCamera,
            child: const Icon(
              Icons.add_a_photo,
              color: Colors.black,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          ElevatedButton(
            onPressed: _openGallery,
            child: const Icon(
              Icons.image,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
