import 'package:croco/src/services/commonCache.dart';
import 'package:croco/src/services/enums/M3UcontentType.dart';
import 'package:flutter/material.dart';

class Sidebar extends StatefulWidget {
  Sidebar({Key? key, required this.commonCache}) : super(key: key);

  CommonCache commonCache;

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
}
