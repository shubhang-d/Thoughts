import 'package:flutter/material.dart';
import 'package:wallpaper_app/Data/ImageData.dart';
import 'package:wallpaper_app/Screens/edit_image.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ImageData> imageDataList = [
    ImageData(
      imagePath: "images/380741.jpg",
    ),
    ImageData(imagePath: "images/whiteimage.jpg")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Background Image"),
        centerTitle: true,
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2),
          itemCount: imageDataList.length,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              child: Image(
                image: AssetImage(imageDataList[index].imagePath),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ImageEditorExample(
                              imageDataList: imageDataList[index],
                            )));
              },
            );
          },
        ),
      ),
    );
  }
}
