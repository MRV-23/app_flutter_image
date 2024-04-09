import 'package:flutter/material.dart';
import '../controllers/app_controller.dart';
import '../models/model_image.dart';
import 'package:insta_image_viewer/insta_image_viewer.dart';

class SearchUser extends SearchDelegate {
  FetchImageList _Imagelist = FetchImageList();

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<List<Imagelist>>(
        future: _Imagelist.getImagelist(query: query),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<Imagelist>? data = snapshot.data;
          return ListView.builder(
              itemCount: data?.length,
              itemBuilder: (context, index) {
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                  height: 110,
                  width: double.infinity,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
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
                  ),
                );
              });
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text('Search User'),
    );
  }
}
