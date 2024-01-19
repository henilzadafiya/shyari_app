import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/fourt%20pge.dart';

class dispy extends StatefulWidget {
  int index;
  List a;

  dispy(this.index, this.a);

  @override
  State<dispy> createState() => _dispyState();
}

class _dispyState extends State<dispy> {
  bool clr_sts = false;
  int ind1 = 0;
  int ind2 = 1;


  int r = 0;
  PageController? controller;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    double scr_hi = MediaQuery
        .of(context)
        .size
        .height;
    double stats_bar = MediaQuery
        .of(context)
        .padding
        .top;
    double App_bar = kToolbarHeight;
    double size = scr_hi - stats_bar - App_bar - 10;
    return Scaffold(
      appBar: AppBar(title: Text("love shayri")),
      body: Column(
        children: [
          Flexible(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
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
                                      ind1 = index;
                                      clr_sts = true;
                                      Navigator.pop(context);
                                      setState(() {});
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      child: Text("${widget.a[widget.index]}",
                                          style: TextStyle(fontSize: 15),
                                          maxLines: 1),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          data_class.clr[index],
                                          data_class.clr[index + 1]
                                        ]),),
                                    ),
                                  );
                                },
                              ),
                            );
                          },
                        );
                      },
                      child:
                      Image.asset(height: 40, "myasset/image/expand.png")),
                  Text("${widget.index + 1}/${widget.a.length}"),
                  InkWell(
                      onTap: () {
                        clr_sts = true;
                        data_class.clr.shuffle();
                        setState(() {});
                      },
                      child:
                      Image.asset(height: 40, "myasset/image/reload.png")),
                ]),
          ),
          Expanded(
            flex: 4,
            child: PageView.builder(
              onPageChanged: (value) {
                widget.index = value;
                setState(() {});
              },
              controller: controller,
              itemCount: widget.a.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: (clr_sts == false) ? Colors.red : null,
                      gradient: LinearGradient(colors: [
                        data_class.clr[ind1],
                        data_class.clr[ind1 + 1]
                      ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18),
                      child: Text(
                        "${widget.a[index]}",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            flex: 5,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: "${widget.a[widget.index]}"));
                    },
                    icon: Icon(Icons.copy)),
                IconButton(
                    onPressed: () {
                      if (widget.index != 0) {
                        widget.index--;
                        controller!.jumpToPage(widget.index);
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.chevron_left_rounded)),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return edit_page(widget.a, widget.index);
                          },
                        ));
                      },
                      child:
                      Image.asset(height: 30, "myasset/image/pencil2.png")),
                ),
                IconButton(
                    onPressed: () {
                      if (widget.index < widget.a.length - 1) {
                        widget.index++;
                        controller!.jumpToPage(widget.index);
                        setState(() {});
                      }
                    },
                    icon: Icon(Icons.chevron_right_sharp)),
                IconButton(
                    onPressed: () {
                      Share.share("${widget.a[widget.index]}");
                    },
                    icon: Icon(Icons.share)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
