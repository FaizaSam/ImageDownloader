//import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_downloader/image_downloader.dart';
import 'package:image_downloader_eg/imageGroup.dart';
//import 'package:open_file/open_file.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: ImageGroup(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //int _counter = 0;
  List imageIDs = [];

  var length = 0;
  var pathNw;
  int _progress = 0;
  void initState() {
    super.initState();

    ImageDownloader.callback(onProgressUpdate: (String imageId, int progress) {
      setState(() {
        _progress = progress;
        pathNw != Null;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("IMage"),
      ),
      body: Column(children: [
        Center(
          child: ElevatedButton(
            onPressed: () {
              _downloadImage();
            },
            child: Text("Download Image"),
          ),
        ),
        // open(context)

        pathNw == ""
            ? Container()
            : Builder(
                builder: (context) => ElevatedButton(
                  onPressed: () async {
                    await ImageDownloader.open(pathNw).catchError((error) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content:
                            Text((error as PlatformException).message ?? ''),
                      ));
                    });
                  },
                  child: Text("Open"),
                ),
              ),
        // Container(child: Image.memory(pathNw))
      ]),
    );
  }

  _downloadImage() async {
    try {
      // Saved with this method.
      //check imageId if not exist
      var imageId = await ImageDownloader.downloadImage(
          "https://raw.githubusercontent.com/wiki/ko2ic/image_downloader/images/flutter.png",
          destination: AndroidDestinationType.directoryPictures
            ..subDirectory('flutter.png'));
      imageIDs.add(imageId);
      print("Image Downloaded Successfully");

      // Below is a method of obtaining saved image information.
      var fileName = await ImageDownloader.findName(imageId);

      var path = await ImageDownloader.findPath(imageId);

      var size = await ImageDownloader.findByteSize(imageId);
      // print(size);
      var mimeType = await ImageDownloader.findMimeType(imageId);
      if (path != null) {
        setState(() {
          pathNw = path;
        });
      }
    } on PlatformException catch (error) {
      print(error);
    }
  }
}
