import 'package:flutter/material.dart';
import 'package:app_flutter/controllers/app_controller.dart';
import 'package:app_flutter/views/search.dart';
import 'package:app_flutter/models/model_image.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FetchImageList _Imagelist = FetchImageList();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('Unsplash Image List'),
            actions: [
              IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: SearchUser());
                },
                icon: Icon(Icons.search_sharp),
              )
            ],
          ),
          body: Container(
            padding: EdgeInsets.all(20),
            child: FutureBuilder<List<Imagelist>>(
                future: _Imagelist.getImagelist(),
                builder: (context, snapshot) {
                  var data = snapshot.data;
                  return ListView.builder(
                      itemCount: data?.length,
                      itemBuilder: (context, index) {
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        return Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 5),
                          height: 100,
                          width: double.infinity,
                          child: Row(
                            children: [
                              InstaImageViewer(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image(
                                      image: Image.network(
                                    '${data?[index].urls?.raw}',
                                    fit: BoxFit.cover,
                                  ).image),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                  child: Column(children: [
                                Text('${data![index].alt_description}'),
                              ]))
                            ],
                          ),
                        );
                      });
                }),
          )),
    );
  }
}
