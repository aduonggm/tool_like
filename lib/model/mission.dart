import 'dart:convert';

class MissionModel {
  final String idPost;
  final String link;
  final List<String>? content;

  MissionModel({required this.idPost, required this.link, this.content});

  MissionModel.fromJson(dynamic map)
      : idPost = map['idpost'],
        content = map['nd'] == null ? null : json.decode(map['nd']) as List<String>,
        link = map['link'];
}
