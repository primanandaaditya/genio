import 'package:flutter/material.dart';

class ItemList extends StatelessWidget {
  String imageAsset;
  String title;
  String subtitle;

  ItemList(this.imageAsset, this.title, this.subtitle);

  @override
  Widget build(BuildContext context) {
    return Card(
        child: Container(
          padding: EdgeInsets.all(10),
          child:  Row(
            children: <Widget>[
              Image.asset(imageAsset, height: 50, width: 50,),
              Padding(padding: EdgeInsets.only(left: 5, right: 5),),
              Expanded(
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(title, style: TextStyle(
                          fontWeight: FontWeight.bold
                      ),),
                      Text(subtitle,
                        style: TextStyle(
                            fontSize: 12
                        ),
                      )
                    ],
                  )
              )
            ],
          ),
        )
    );
  }
}
