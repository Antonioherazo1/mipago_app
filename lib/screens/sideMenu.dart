import 'package:flutter/material.dart';


class SideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Drawer(
      child: ListView(
        children:<Widget>[
          new UserAccountsDrawerHeader(
            accountName: Text('Antonio Herazo',style: TextStyle(color: Colors.white)),
            accountEmail: Text('antonioherazo7@hotmail.com', style: TextStyle(color: Colors.white)),
            decoration: BoxDecoration(
              image: DecorationImage(image: NetworkImage("https://ichef.bbci.co.uk/news/660/cpsprodpb/6AFE/production/_102809372_machu.jpg"))
            ),
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: Text("HOME"),
              trailing: Icon(Icons.arrow_forward_ios),
          ),
          new ListTile(
              leading: Icon(Icons.home),
              title: Text("HOME"),
              trailing: Icon(Icons.arrow_forward_ios),
          )  
        ],
      ),
    );
  }
}