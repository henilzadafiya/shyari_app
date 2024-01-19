import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shyari_app/dataa.dart';
import 'package:shyari_app/second.dart';

void main() {
  runApp(MaterialApp(home: hom()));
}

class hom extends StatefulWidget {
  const hom({Key? key}) : super(key: key);

  @override
  State<hom> createState() => _homState();
}

class _homState extends State<hom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("love sharyri"),
      ),
      body: ListView.builder(
        itemCount: data_class.name.length,
        itemBuilder: (context, index) {
         return InkWell(onTap: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) {
             return sec(data_class.name, index,data_class.img);
           },));
         },
           child: Card(
              child: ListTile(
                  leading: CircleAvatar(
                    child: Image.asset("${data_class.img[index]}"),
                  ),
                  title: Text("${data_class.name[index]}")),
            ),
         );
        },
      ),
    );
  }
}
