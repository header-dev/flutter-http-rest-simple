import 'package:app1401/api.dart';
import 'package:app1401/details.dart';
import 'package:flutter/material.dart';

void main() => runApp(App1401());

class App1401 extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: HomePage(),
      );
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<dynamic>> futurePhotos;

  var listPhotos = [];
  var _apiCalling = true;

  @override
  void initState() {
    super.initState();

    futurePhotos = apiGetPhotos();

    futurePhotos.then((value) {
      for (var p in value) {
        listPhotos.add(p);
      }
      setState(() {
        _apiCalling = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: (_apiCalling
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListView.separated(
                itemBuilder: (ctx, idx) => buildListTile(idx),
                separatorBuilder: (ctx, idx) => Divider(
                  thickness: 1,
                  color: Colors.indigo,
                ),
                itemCount: listPhotos.length,
              )),
      ),
    );
  }

  Widget buildListView() => ListView.separated(
        itemBuilder: (ctx, i) => buildListTile(i),
        separatorBuilder: (ctx, idx) => Divider(
          thickness: 1,
          color: Colors.indigo,
        ),
        itemCount: listPhotos.length,
      );

  Widget buildListTile(int index) => ListTile(
        contentPadding: EdgeInsets.only(
          top: 5,
          bottom: 5,
        ),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(listPhotos[index]['thumbnailUrl']),
        ),
        title: Text(listPhotos[index]['title']),
        trailing: Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailPage(
                photoId: listPhotos[index]['id'],
              ),
            ),
          );
        },
      );
}
