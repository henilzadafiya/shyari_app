import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/forth.dart';

class thi extends StatefulWidget {
  List a;
  int index;

  thi(this.a, this.index);

  @override
  State<thi> createState() => _thiState();
}

class _thiState extends State<thi> {
  int ind = 0;
  bool clr_status = false;
  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Love Shayari")),
        body: Column(
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (context) {
                        return Container(
                          child: GridView.builder(
                            itemCount: data_class.clr.length - 1,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    mainAxisSpacing: 5,
                                    crossAxisSpacing: 5),
                            itemBuilder: (context, index) {
                              return InkWell(
                                  onTap: () {
                                    ind = index;
                                    clr_status = true;
                                    Navigator.pop(context);
                                    setState(() {});
                                  },
                                  child: PageView.builder(
                                    onPageChanged: (value) {
                                      widget.index = value;
                                      setState(() {});
                                    },
                                    controller: controller,
                                    itemCount: widget.a.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(colors: [
                                          data_class.clr[index],
                                          data_class.clr[index + 1]
                                        ])),
                                      );
                                    },
                                  ));
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Image.asset(height: 40, "myasset/image/expand.png")),
              Text("${widget.index + 1}/${widget.a.length}",
                  style: TextStyle(fontSize: 20)),
              InkWell(
                  onTap: () {
                    clr_status = true;
                    data_class.clr.shuffle();
                    setState(() {});
                  },
                  child: Image.asset(height: 40, "myasset/image/reload.png")),
            ]),
            SizedBox(
              width: 200,
              height: 200,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                    width: 300,
                    height: 300,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: (clr_status == false) ? Colors.red : null,
                        gradient: LinearGradient(colors: [
                          data_class.clr[ind],
                          data_class.clr[ind + 1]
                        ])),
                    child: Text("${widget.a[widget.index]}")),
              ],
            ),
            SizedBox(height: 50,),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(onTap: () {
                  Clipboard.setData(ClipboardData(text: "${widget.a[widget.index]}"));
                },child: Icon(Icons.copy)),
                InkWell(onTap: () {
                  if(widget.index!=0){
                    widget.index--;
                    // controller!.jumpToPage(widget.index);
                    setState(() {});
                  }
                },child: Icon(Icons.chevron_left_rounded)),
                InkWell(onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return forth(widget.index, widget.a);
                  },));
                },child: Icon(Icons.edit)),
                InkWell(onTap: () {
                  if(widget.index <widget.a.length-1){
                    widget.index++;
                    // controller!.jumpToPage(widget.index);
                    setState(() {});
                  }
                },child: Icon(Icons.chevron_right_rounded)),
                Icon(Icons.share),
              ],
            )
          ],
        ));
  }
}
