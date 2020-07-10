import 'dart:convert';
import 'package:http/http.dart' as http;
import 'itunes_model.dart';

class Search {

  List<Track> tracks = [];

  Future fetch(String query) async {
    tracks = [] ;
    final response = await http.get('https://itunes.apple.com/search?term=' + query + '&limit=200');
    if(response.statusCode==200) {
      print(response.body);
      final jsonData = jsonDecode(response.body);
      //print(jsonData);
      jsonData["results"].forEach((element){
        if(true) {
          Track track = Track.fromJson(element);
          tracks.add(track);
          //print('Added');
        }
      });
    }
  }

}