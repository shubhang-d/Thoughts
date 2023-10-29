import 'package:Thoughts/Data/ImageData.dart';
import 'package:Thoughts/Screens/wallpaper_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_editor_plus/image_editor_plus.dart';

class ImageEditorExample extends StatefulWidget {
  const ImageEditorExample({super.key, required this.imageDataList});

  final ImageData imageDataList;
  @override
  createState() => _ImageEditorExampleState();
}

class _ImageEditorExampleState extends State<ImageEditorExample> {
  Uint8List? imageData;

  @override
  void initState() {
    super.initState();

    loadAsset(widget.imageDataList.imagePath);
  }

  void loadAsset(String name) async {
    var data = await rootBundle.load(name);
    setState(() => imageData = data.buffer.asUint8List());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Image"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              // _saveImage(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          wallpaperSet(imageData: imageData)));
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.memory(
            imageData!,
            width: 500,
            height: 500,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            child: const Text("Single image editor"),
            onPressed: () async {
              var editedImage = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ImageEditor(
                    image: imageData,
                  ),
                ),
              );

              // replace with edited image
              if (editedImage != null) {
                imageData = editedImage;
                setState(() {});
              }
            },
          ),
        ],
      ),
    );
  }
}
