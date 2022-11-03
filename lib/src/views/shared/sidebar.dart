import 'package:croco/src/services/enums/M3UcontentType.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  Sidebar({Key? key}) : super(key: key);

  @override
  SidebarState createState() => SidebarState();
}

class SidebarState extends State<Sidebar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
/*
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: FutureBuilder<List<String>>(
        future: widget.commonCache.getGroupNames(M3UContentType.Movie),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              // Remove padding
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  child: Text('Croco'),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
                ...snapshot.data!
                    .map((e) => ListTile(
                        leading: Icon(Icons.category),
                        title: Text(e),
                        onTap: () => null))
                    .toList(),
              ],
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
  */
}
