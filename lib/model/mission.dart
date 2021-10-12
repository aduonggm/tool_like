import 'dart:convert';

class MissionModel {
  final String idPost;
  final String link;
  final List<String>? content;

  MissionModel({required this.idPost, required this.link, this.content});

  MissionModel.fromJson(dynamic map)
      : idPost = map['idpost'] ?? map['UID'] ,
        content = map['nd'] == null ? null : json.decode(map['nd']).map<String>((e) => e.toString()).toList(),
        link = map['link'];
}
