import 'package:flutter/material.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/disp.dart';

class vieww extends StatefulWidget {
  int index;
  List name;
  List img;

  vieww(this.index, this.name, this.img);

  @override
  State<vieww> createState() => _viewwState();
}

class _viewwState extends State<vieww> {
  List a = [];
  List<bool> temp = [];
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
    "😁 😆 😉 😐 🤨 🙄",
    "💕 💖 💗 💙 💚 💛 ",
    " 🧡 💜 🖤 💝 💞 💟",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    switch (widget.index) {
      case 0:
        a = data_class.perna;
        break;
      case 1:
        a = data_class.jiv;
        break;
      case 2:
        a = data_class.moh;
        break;
      case 3:
        a = data_class.yaad;
        break;
      case 4:
        a = data_class.otr;
        break;
      case 5:
        a = data_class.poli;
        break;
      case 6:
        a = data_class.love;
        break;
      case 7:
        a = data_class.sad;
        break;
    }
    temp= List.filled(a.length, false);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Text("${widget.name[widget.index]}")),
      body: ListView.builder(
        itemCount: a.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return dispy(index, a);
                },
              ));
             temp[index]=false;
              setState(() {});
            },
            onTapCancel: () {
              temp[index]=true;
              setState(() {});
            },
            onTapDown: (details) {
              temp[index]=true;
              setState(() {});
            },
            child: Card(
                child: ListTile(
              tileColor:(temp[index])?Colors.pinkAccent :null,
              leading: Image.asset("${widget.img[widget.index]}", height: 35),
              trailing:
                  Icon(Icons.keyboard_arrow_right_rounded, color: Colors.black),
              subtitle: Text(
                "${a[index]}",
                style: TextStyle(color: Colors.black),
                maxLines: 1,
              ),
              title: Text("${emoji_list[index]}"),
            )),
          );
        },
      ),
    );
  }
}
