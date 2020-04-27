import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Information_About_Event extends StatelessWidget {
  final IconData icon;
  final String description;
  final String info;

  Information_About_Event({this.icon, this.description, this.info});


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: <Widget>[
          Icon(icon, size: 30, color: Colors.white),
          Container(
            margin: EdgeInsets.only(top: 10, left: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Text(info,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Text(description,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.white30,
                    ),
                  ),
                )
              ],
            )
          )
        ],
      )
    );
  }

}