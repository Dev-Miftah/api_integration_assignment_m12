import 'package:flutter/material.dart';
import '../data_model/gallery_model.dart';

class SingleImageScreen extends StatefulWidget {
  final GalleryModel galleryItem;

  const SingleImageScreen({super.key, required this.galleryItem});

  @override
  State<SingleImageScreen> createState() => _SingleImageScreenState();
}

class _SingleImageScreenState extends State<SingleImageScreen> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.blue,
        title: Text('Album ID: ${widget.galleryItem.albumId ?? 'Unknown'}'),
      ),
      body: OrientationBuilder(
          builder: (context, Orientation orientation) {
            if (orientation == Orientation.portrait){
              return portraitOrientation(screenWidth, screenHeight);
            } else {
              return landscapeOrientation(screenWidth, screenHeight);
            }
          }
      ),
    );
  }

  Widget portraitOrientation(double screenWidth, double screenHeight) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: screenWidth,
                          height: screenHeight * 0.5,
                          decoration: BoxDecoration(
                            color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 0.5,
                                    spreadRadius: 0.5,
                                    offset: const Offset(0.5, 1)
                                )
                              ],
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(image: NetworkImage(widget.galleryItem.thumbnailUrl.toString()), fit: BoxFit.fill)
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(widget.galleryItem.title ?? 'No Title',
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 10),
                        Text('ID: ${widget.galleryItem.id ?? 'Unknown'}',
                        style: const TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
        ),
      ),
    );
  }

  Widget landscapeOrientation(double screenWidth, double screenHeight) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: screenWidth * 0.5,
                        height: screenHeight * 0.7,
                        decoration: BoxDecoration(
                          color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 0.5,
                                  spreadRadius: 0.5,
                                  offset: const Offset(0.5, 1)
                              )
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(image: NetworkImage(widget.galleryItem.thumbnailUrl.toString()), fit: BoxFit.fill)
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.galleryItem.title ?? 'No Title',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 26),
                            ),
                            const SizedBox(height: 10),
                            Text('ID: ${widget.galleryItem.id ?? 'Unknown'}',
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      ),

                    ],
                  ),
      ),
    );
  }
}
