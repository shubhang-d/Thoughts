import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:async_wallpaper/async_wallpaper.dart';
import 'package:path_provider/path_provider.dart';

class wallpaperSet extends StatefulWidget {
  wallpaperSet({super.key, required this.imageData});
  Uint8List? imageData;

  @override
  State<wallpaperSet> createState() => _wallpaperSet();
}

class _wallpaperSet extends State<wallpaperSet> {
  String _platformVersion = 'Unknown';
  String _wallpaperFileHome = 'Unknown';
  String _wallpaperFileLock = 'Unknown';
  String _wallpaperFileBoth = 'Unknown';

  late bool goToHome;

  @override
  void initState() {
    super.initState();
    goToHome = false;
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await AsyncWallpaper.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileHome() async {
    setState(() {
      _wallpaperFileHome = 'Loading';
    });
    String result;
    final tempDir = await getTemporaryDirectory();
    var file2 = await File('${tempDir.path}/image.png').create();
    file2.writeAsBytes(widget.imageData as List<int>);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file2.path,
        wallpaperLocation: AsyncWallpaper.HOME_SCREEN,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFileHome = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileLock() async {
    setState(() {
      _wallpaperFileLock = 'Loading';
    });
    String result;
    final tempDir = await getTemporaryDirectory();
    var file2 = await File('${tempDir.path}/image.png').create();
    file2.writeAsBytes(widget.imageData as List<int>);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file2.path,
        wallpaperLocation: AsyncWallpaper.LOCK_SCREEN,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFileLock = result;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> setWallpaperFromFileBoth() async {
    setState(() {
      _wallpaperFileBoth = 'Loading';
    });
    String result;
    final tempDir = await getTemporaryDirectory();
    var file2 = await File('${tempDir.path}/image.png').create();
    file2.writeAsBytes(widget.imageData as List<int>);
    // file2.writeAsBytes(widget.imageData);
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await AsyncWallpaper.setWallpaperFromFile(
        filePath: file2.path,
        wallpaperLocation: AsyncWallpaper.BOTH_SCREENS,
        goToHome: goToHome,
        toastDetails: ToastDetails.success(),
        errorToastDetails: ToastDetails.error(),
      )
          ? 'Wallpaper set'
          : 'Failed to get wallpaper.';
    } on PlatformException {
      result = 'Failed to get wallpaper.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _wallpaperFileBoth = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Set Wallpaper'),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Center(
                child: Text('Running on: $_platformVersion\n'),
              ),
              SwitchListTile(
                  title: const Text('This will Redirect You to Home'),
                  value: goToHome,
                  onChanged: (value) {
                    setState(() {
                      goToHome = value;
                    });
                  }),
              ElevatedButton(
                onPressed: setWallpaperFromFileHome,
                child: _wallpaperFileHome == 'Loading'
                    ? const CircularProgressIndicator()
                    : const Text('Set wallpaper from file home'),
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperFileHome\n'),
              ),
              ElevatedButton(
                onPressed: setWallpaperFromFileLock,
                child: _wallpaperFileLock == 'Loading'
                    ? const CircularProgressIndicator()
                    : const Text('Set wallpaper from file lock'),
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperFileLock\n'),
              ),
              ElevatedButton(
                onPressed: setWallpaperFromFileBoth,
                child: _wallpaperFileBoth == 'Loading'
                    ? const CircularProgressIndicator()
                    : const Text('Set wallpaper from file both'),
              ),
              Center(
                child: Text('Wallpaper status: $_wallpaperFileBoth\n'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
