import 'package:flutter/material.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/second%20page.dart';
import 'package:shyari_app/shareee.dart';
// import '../../revison/lib/slid.dart';

void main() {
  runApp(MaterialApp(
    home: home_page(),
    // home: image_share(),
    // home: slideble(),
    debugShowCheckedModeBanner: false,
  ));
}

class home_page extends StatefulWidget {
  const home_page({Key? key}) : super(key: key);

  @override
  State<home_page> createState() => _home_pageState();
}

class _home_pageState extends State<home_page> {
  List<bool> temp = List.filled(data_class.name.length, false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.green,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Love Shayari"),
              // Row(
              //   children: [
              //     Padding(
              //       padding: const EdgeInsets.only(right: 25),
              //       child: Icon(Icons.share),
              //     ),
              //     Icon(Icons.menu)
              //   ],
              // )
            ],
          )),
      body: ListView.builder(
        itemCount: data_class.name.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index < data_class.name.length) {
                temp[index] = true;
              }
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return vieww(index, data_class.name, data_class.img);
                },
              ));
              setState(() {});
              temp[index] = false;
            },
            onTapDown: (details) {
              temp[index] = true;
              setState(() {});
            },
            onTapCancel: () {
              temp[index] = false;
              setState(() {});
            },
            child: Card(
                child: ListTile(
                    tileColor: (temp[index] == true) ? Colors.pinkAccent : null,
                    trailing: Icon(Icons.chevron_right, color: Colors.white),
                    leading: CircleAvatar(child: Image.asset("${data_class.img[index]}"),),
                    title: Text("${data_class.name[index]}")
              )
            ),
          );
        },
      ),
    );
  }
}
