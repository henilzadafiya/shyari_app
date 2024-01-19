import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shyari_app/dataa.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class forth extends StatefulWidget {
  int index = 0;
  List a;

  forth(this.index, this.a);

  @override
  State<forth> createState() => _forthState();
}

class _forthState extends State<forth> {
  bool clr_status = false;
  Color col = Colors.red;
  Color font_clr =Colors.black;
  int pos = 0;
  String font_style="";
  double b=10;
  WidgetsToImageController controller = WidgetsToImageController();
// to save image bytes of widget
  Uint8List? bytes;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    get();
  }
  get()
  async {
    var status = await Permission.storage.status;
    if(status .isDenied)
      {
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
      appBar: AppBar(title: Text("shayri app")),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WidgetsToImage(controller: controller,
              child: Container(
                height: 400,
                width: 200,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: (clr_status == false) ? col : null,
                    gradient: (clr_status == true)
                        ? LinearGradient(colors: [
                            data_class.clr[pos],
                            data_class.clr[pos + 1]
                          ])
                        : null),
                child: Text("${widget.a[widget.index]}",style: TextStyle(color: font_clr,fontFamily: font_style,fontSize: b)),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    clr_status = true;
                    data_class.clr.shuffle();
                    setState(() {});
                  },
                  child: Image.asset(height: 40, "myasset/image/reload.png"),
                ),
                InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 5,
                                  mainAxisSpacing: 5),
                          itemCount: data_class.clr.length - 1,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                clr_status = true;
                                pos = index;
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    gradient: LinearGradient(colors: [
                                  data_class.clr[index],
                                  data_class.clr[index + 1]
                                ])),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  child: Image.asset(height: 40, "myasset/image/expand.png"),
                ),
              ],
            ),
            Row(
              children: [
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            child: GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 8,
                                      mainAxisSpacing: 5,
                                      crossAxisSpacing: 5),
                              itemCount: data_class.clr.length,
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      col = data_class.clr[index];
                                      clr_status = false;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: data_class.clr[index]),
                                    ));
                              },
                            ),
                          );
                        },
                      );
                    },
                    child: Text("background")),
                TextButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return GridView.builder(
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 8,
                                      crossAxisSpacing: 5,
                                      mainAxisSpacing: 5),itemCount: data_class.clr.length,
                              itemBuilder: (context, index) {
                                return InkWell(onTap: () {
                                  font_clr = data_class.clr[index];

                                },child: Container(color: data_class.clr[index]));
                              },);
                        },
                      );
                    },
                    child: Text("text color")),
                TextButton(onPressed: () {
                  showModalBottomSheet(context: context, builder: (context) {
                    return SingleChildScrollView(scrollDirection: Axis.horizontal,child: Row(children: [
                      InkWell(onTap: () {
                        font_style = "one";
                        setState(() {});
                      },
                        child: Container(
                          alignment:
                          Alignment.center,
                          height: 25,
                          width: 75,
                          color: Colors.grey,
                          child: Text("shayri",
                              style: TextStyle(
                                  fontFamily:
                                  "one",
                                  fontSize: 15)),
                        ),
                      )
                    ]),);
                  },);
                }, child: Text("text style")),
                TextButton(onPressed: () {
                  showModalBottomSheet(context: context, builder: (context) {
                    return StatefulBuilder(builder: (context, setState1) {
                      return Slider(min: 5,max: 40,value: b, onChanged: (value) {
                        b = value;
                        setState1((){});
                        setState(() {});
                      },);
                    },);
                  },);
                }, child: Text("text size")),
                TextButton(onPressed: () async {
                  bytes = await controller.capture();
                  var path = await ExternalPath.getExternalStoragePublicDirectory(ExternalPath.DIRECTORY_DOWNLOADS)+"/shyaru";
                  Directory dir =Directory(path);
                  if(!await dir.exists())
                    {
                      dir.create();
                    }
                  String img_name = "${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}my.jpg";
                  File file = File("${dir.path}/${img_name}");
                  file.writeAsBytes(bytes!);
                  Share.shareFiles(['${file.path}/image.jpg'], text: 'Great picture');

                }, child: Text("share"))
              ],
            )

          ]),
    );
  }
}
