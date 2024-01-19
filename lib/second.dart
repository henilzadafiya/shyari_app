import 'package:flutter/material.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/third.dart';

class sec extends StatefulWidget {
  List name;
  int index;
  List img;

  sec(this.name, this.index,this.img);

  @override
  State<sec> createState() => _secState();
}

class _secState extends State<sec> {
  List a = [];

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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("${widget.name[widget.index]}")),
      body: ListView.builder(
        itemCount: a.length,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return  thi(a, index);
            },));
          },
            child: Card(
              child: ListTile(
                leading: CircleAvatar(child: Image.asset("${widget.img[widget.index]}",),),
                  title: Text(
                "${a[index]}",
                maxLines: 1,
              )),
            ),
          );
        },
      ),
    );
  }
}
