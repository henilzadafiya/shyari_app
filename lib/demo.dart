import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

void main() {
  runApp(MaterialApp(
    home: demo(),
  ));
}

class demo extends StatefulWidget {
  // const demo({Key? key}) : super(key: key);

  @override
  State<demo> createState() => _demoState();
}

class _demoState extends State<demo> {
  WidgetsToImageController controller = WidgetsToImageController();

  Uint8List? bytes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    get_permision();
  }
  get_permision() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.location,
        Permission.storage,
      ].request();
    }
    print(status);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
            Row(mainAxisAlignment: MainAxisAlignment.center,
              children: [

                WidgetsToImage(child: Container(
                    height: 200,
                    width: 200,
                    color: Colors.red,
                    child: Text(" hi  goood moorning")), controller: controller)

              ],
            ),
          ElevatedButton(
              onPressed: () async {
                bytes = await controller.capture();

                // create a path
                var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/m";
                Directory dir = Directory(path);
                if(!await dir.exists())
                  {
                    dir.create();
                  }

                //crete image
                String img_name="${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}myimg.jpg";

                File file = File("${dir.path}/${img_name}");
                file.writeAsBytes(bytes!);
                 Share.shareFiles(['${file.path}'], text: 'Great picture');
              },
              child: Text("share"))
        ]),
      ),
    );
  }
}
