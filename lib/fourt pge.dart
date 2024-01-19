import 'dart:io';
import 'dart:typed_data';
import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shyari_app/dataa.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

class edit_page extends StatefulWidget {
  int index;
  List a;
  // int ind1;
  // int ind2;

  edit_page(this.a, this.index);

  @override
  State<edit_page> createState() => _edit_pageState();
}

class _edit_pageState extends State<edit_page> {

  double b = 20;
  Color col = Colors.red;
  bool clr_sts = true;
  int pos = 0;
  bool emji = true;
  int emogi_index = 0;
  List emoji_list = [
    "🧐 🤓 😎 🥸 🤩 🥳",
    "🥱 😴 🤤 😪 😵 😵‍",
    "👋 🤚 🖐 ✋ 🖖 👌",
    "🧒 👦 👩 🧑 👨 🦱",
    "🤚🏻 🏻 ✋🏻 🖖🏻 👌🏻 🤌🏻",
    "👿 👹 👺 🤡 💩 👻",
    "😁 😆 😉 😐 🤨 🙄",
    "💕 💖 💗 💙 💚 💛 ",
    " 🧡 💜 🖤 💝 💞 💟",
    "🙄 😏 😣 😥 😮 🤐",
    "😺 😸 😹 😻 😼 😽",
    "👣 👀 👁 👁️‍️ 🧠 👅",
    "🌿 ☘ 🍀 🍁 🍂 🍃",
    "🍊 🍋 🍌 🍍 🍎 🍏",
    "🥞 🧀 🍖 🍗 🥩 🥓",
    "--without emoji--",
  ];
  Color font_color = Colors.black;
  String font_style = "";
  PageController? controller;
  WidgetsToImageController controller1 = WidgetsToImageController();
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
    double scr_size = MediaQuery.of(context).size.height;
    double status_bar = MediaQuery.of(context).padding.top;
    double app_bar = kToolbarHeight;
    double hight = scr_size - app_bar - status_bar - 505;
    double size = scr_size - status_bar - app_bar - 10;

    return Scaffold(
      appBar: AppBar(
          title: Text("photo pe shari likhe"), backgroundColor: Colors.green),
      body: Column(children: [
        Flexible(
            flex: 3,
            child: Padding(
                padding: EdgeInsets.only(top: 50, right: 10, left: 10),
                child: WidgetsToImage(
                    child: Container(
                        decoration: BoxDecoration(
                            color: (clr_sts == true) ? col : null,
                            gradient: (clr_sts == false)
                                ? LinearGradient(colors: [
                                    data_class.clr[pos],
                                    data_class.clr[pos + 1],
                                  ])
                                : null),
                        width: double.infinity,
                        height: 400,
                        child: Center(
                          child: Text(
                              (emji == true)
                                  ? widget.a[widget.index]
                                  : (emji == false)
                                      ? "${emoji_list[emogi_index]}\n${widget.a[widget.index]}\n${emoji_list[emogi_index]}"
                                      : null,
                              style: TextStyle(
                                  fontSize: b,
                                  color: font_color,
                                  fontFamily: "$font_style")),
                        )),
                    controller: controller1))),
        SizedBox(height: 180),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
              ),
            ),
          ],
        ),
        Container(
          color: Colors.black87,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
                top: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 150,
                    decoration: BoxDecoration(
                        color: Colors.white, border: Border.all(width: 2)),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                              onTap: () {
                                clr_sts = false;
                                data_class.clr.shuffle();
                                setState(() {});
                              },
                              child: Image.asset(
                                  height: 40, "myasset/image/reload.png")),
                          // SizedBox(width: 40),
                          InkWell(
                            onTap: () {
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                isScrollControlled: true,
                                context: context,
                                builder: (context) {
                                  return Container(
                                    height: size,
                                    color: Colors.transparent,
                                    child: GridView.builder(
                                      itemCount: data_class.clr.length - 1,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 2,
                                              mainAxisSpacing: 10,
                                              crossAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            clr_sts = false;
                                            pos = index;
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            alignment: Alignment.center,
                                            child: Text(
                                                "${widget.a[widget.index]}",
                                                style: TextStyle(fontSize: 15),
                                                maxLines: 1),
                                            // width: double.infinity,
                                            decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                    colors: [
                                                  data_class.clr[index],
                                                  data_class.clr[index + 1]
                                                ])),
                                          ),
                                        );
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Image.asset(
                              height: 40,
                              "myasset/image/expand.png",
                            ),
                          )
                        ]),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        isDismissible: false,
                        isScrollControlled: true,
                        context: context,
                        builder: (context) {
                          return Container(
                            height: hight,
                            child: Row(
                              children: [
                                Expanded(
                                  child: GridView.builder(
                                    itemCount: data_class.clr.length,
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount: 8,
                                            crossAxisSpacing: 10,
                                            mainAxisSpacing: 10),
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          col = data_class.clr[index];
                                          clr_sts = true;
                                          setState(() {});
                                        },
                                        child: Container(
                                          color: data_class.clr[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topRight,
                                  child: IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: Image.asset(
                                          "myasset/image/close.png")),
                                ),
                              ],
                            ),
                          );
                          setState(() {});
                        },
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Background",
                            style:
                                TextStyle(color: Colors.white, fontSize: 13)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: GridView.builder(
                                      itemCount: data_class.clr.length,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: 8,
                                              crossAxisSpacing: 10,
                                              mainAxisSpacing: 10),
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () {
                                            font_color = data_class.clr[index];
                                            Navigator.pop(context);
                                            setState(() {});
                                          },
                                          child: Container(
                                            child: Text(
                                              "${widget.a[widget.index]}",
                                              style: TextStyle(
                                                  color: data_class.clr[index]),
                                            ),
                                            color: data_class.clr[index],
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                            "myasset/image/close.png")),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Text Color",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        bytes = await controller1.capture();
                        // directory
                        var path = await ExternalPath
                                .getExternalStoragePublicDirectory(
                                    ExternalPath.DIRECTORY_DOWNLOADS) +
                            "/shari app";
                        Directory dir = Directory(path);
                        if (!await dir.exists()) {
                          dir.create();
                          // create image
                        }


                        String img_name =
                            "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}${DateTime.now().hour}${DateTime.now().minute}${DateTime.now().second}${DateTime.now().millisecond}myimg.jpg";

                        File file = File("${dir.path}/${img_name}");
                        file.writeAsBytes(bytes!);
                        Share.shareFiles(['${file.path}'],
                            text: 'Great picture');
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Share",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          isScrollControlled: true,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                            color: Colors.transparent,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "one";
                                                        Navigator.pop(context);
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
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "two";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("two",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "two",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "three";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("three",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "three",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "four";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("four",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "four",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "five";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("five",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "five",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "six";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("six",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "six",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "seven";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("seven",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "seven",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: InkWell(
                                                      onTap: () {
                                                        font_style = "eghit";
                                                        Navigator.pop(context);
                                                        setState(() {});
                                                      },
                                                      child: Container(
                                                        alignment:
                                                            Alignment.center,
                                                        height: 25,
                                                        width: 75,
                                                        color: Colors.grey,
                                                        child: Text("eghit",
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    "eghit",
                                                                fontSize: 15)),
                                                      )),
                                                ),
                                                // InkWell(onTap: () {font_style="one";Navigator.pop(context);setState(() {});},child: Container(height: 25,width: 75,color: Colors.grey,child: Text("",style: TextStyle(fontFamily: "one")),)),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                            "myasset/image/close.png")),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Font",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          barrierColor: Colors.transparent,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return InkWell(
                                              onTap: () {
                                                if (index == 15) {
                                                  emji = true;
                                                } else {
                                                  emji = false;
                                                  emogi_index = index;
                                                }
                                                setState(() {});
                                              },
                                              child: Text(
                                                "${emoji_list[index]}",
                                                style: TextStyle(fontSize: 30),
                                              ));
                                        },
                                        separatorBuilder: (context, index) {
                                          return Divider(
                                            color: Colors.red,
                                          );
                                        },
                                        itemCount: emoji_list.length),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                            "myasset/image/close.png")),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Emoji",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        showModalBottomSheet(
                          isDismissible: false,
                          context: context,
                          builder: (context) {
                            return Container(
                              height: hight,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: StatefulBuilder(
                                      builder: (context, setState1) {
                                        return Slider(
                                          min: 10,
                                          max: 40,
                                          value: b,
                                          onChanged: (value) {
                                            b = value;
                                            setState(() {});
                                            setState1(() {});
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topRight,
                                    child: IconButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        icon: Image.asset(
                                            "myasset/image/close.png")),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40,
                        width: 82,
                        child: Text("Text Size",
                            style:
                                TextStyle(color: Colors.white, fontSize: 15)),
                        color: Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
      ]),
    );
  }
}
