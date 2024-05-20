import 'dart:convert';

import 'package:assignment_module_12/src/views/single_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../data_model/gallery_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _getImageListInProgress = false;
  List<GalleryModel> galleryData = [];
  @override
  void initState() {
    super.initState();
    _getImageList();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Photo Gallery App',
        ),
      ),
      body: RefreshIndicator(
        onRefresh: _getImageList,
        child: Visibility(
          visible: _getImageListInProgress == false,
          replacement: const Center(
            child: CircularProgressIndicator(),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: ListView.builder(
              itemCount: galleryData.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                    onTap: () {
                      print('Tapppppppppppp');
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return SingleImageScreen(
                            galleryItem: galleryData[index],
                          );
                        },
                      ));
                    },
                    child: _buildProductItem(
                        galleryData[index], screenWidth)); // n(1)
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProductItem(GalleryModel gallery, screenWidth) {
    return Container(
      height: 130,
      width: screenWidth,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 0.5,
                spreadRadius: 0.5,
                offset: const Offset(0.5, 1))
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(gallery.thumbnailUrl ?? 'Unknown'),
                    fit: BoxFit.fill)),
          ),
          //SizedBox(width: 10),
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text(
              '${gallery.title}',
              style: const TextStyle(fontSize: 16),
            ),
          ))
        ],
      ),
    );
  }

  Future<void> _getImageList() async {
    _getImageListInProgress = true;
    setState(() {});
    galleryData.clear();
    const String productListUrl = 'https://jsonplaceholder.typicode.com/photos';
    Uri uri = Uri.parse(productListUrl);
    Response response = await get(uri);
    print(response.statusCode);
    print(response.body);

    if (response.statusCode == 200) {
      final decodedData = jsonDecode(response.body);

      for (Map<String, dynamic> json in decodedData) {
        GalleryModel galleryModel = GalleryModel.fromJson(json);
        galleryData.add(galleryModel);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Image loading failed! Try again.')),
      );
    }

    _getImageListInProgress = false;
    setState(() {});
  }
}
