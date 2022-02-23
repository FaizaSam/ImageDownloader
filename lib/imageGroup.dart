import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_downloader/image_downloader.dart';

class ImageGroup extends StatefulWidget {
  ImageGroup({Key key}) : super(key: key);

  @override
  State<ImageGroup> createState() => _ImageGroupState();
}

class _ImageGroupState extends State<ImageGroup> {
  List images = [
    "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/bigsize.jpg",
    "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.jpg",
    "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter_transparent.png",
    "https://raw.githubusercontent.com/wiki/ko2ic/flutter_google_ad_manager/images/sample.gif",
    "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter_no.png",
    "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png",
  ];
  List<File> filesnew = [];
  List<File> _mulitpleFiles = [];
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                DownloadImages(images);
                setState(() {
                  _mulitpleFiles.addAll(filesnew);
                });
              },
              child: Text("Download")),
          Container(
            child: GridView.count(
              crossAxisCount: 4,
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: List.generate(_mulitpleFiles.length, (index) {
                return SizedBox(
                  width: 50,
                  height: 50,
                  child: Image.file(File(_mulitpleFiles[index].path)),
                );
              }),
            ),
          )
        ],
      ),
    );
  }

  opnImage(files) {
    List<File> files1 = files;
    files1.forEach((element) {
      ImageDownloader.open('element');
    });
  }

  DownloadImages(images) async {
    List imgList = images;
    List<File> files = [];

    for (var url in imgList) {
      try {
        var imageId = await ImageDownloader.downloadImage(url);
        var path = await ImageDownloader.findPath(imageId);
        files.add(File(path));
      } catch (error) {
        print(error);
      }
    }
    filesnew = files;
  }
}
