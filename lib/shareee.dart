import 'dart:io';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class image_share extends StatefulWidget {
  const image_share({super.key});

  @override
  State<image_share> createState() => _image_shareState();
}

class _image_shareState extends State<image_share> {
  WidgetsToImageController controller = WidgetsToImageController();
  
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }

  get() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            WidgetsToImage(
              controller: controller,
              child: Container(
                height: 200,
                width: 200,
                alignment: Alignment.center,
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () async {
                  final bytes = await controller.capture();
                  var path =
                      await ExternalPath.getExternalStoragePublicDirectory(
                          ExternalPath.DIRECTORY_DOWNLOADS) +
                          "/pic1";

                  print(path);

                  Directory dir = Directory(path);
                  if (!await dir.exists()) {
                    dir.create();
                  }

                  String img_name =
                      "${DateTime
                      .now()
                      .year}${DateTime
                      .now()
                      .month}${DateTime
                      .now()
                      .day}${DateTime
                      .now()
                      .hour}${DateTime
                      .now()
                      .minute}${DateTime
                      .now()
                      .second}.jpg";

                  File file = File("${dir.path}/$img_name");
                  await file.writeAsBytes(bytes!);

                  Share.shareXFiles([XFile('${file.path}')], text: 'Great picture');
                },
                child: Text("share"))
          ]),
    );
  }
}
