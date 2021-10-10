import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tool_tang_tuong_tac/routes/app_pages.dart';
import 'package:tool_tang_tuong_tac/util/common_widget.dart';
import 'package:tool_tang_tuong_tac/util/util.dart';

class KiemXuView extends StatelessWidget {
  const KiemXuView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(title: Text('Kiếm xu')),
        Expanded(
          child: overScrollView(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _item(missionType: MissionType.LikeFb),
                  _item(missionType: MissionType.CamXucFb),
                  _item(missionType: MissionType.CamXucBinhLuan),
                  _item(missionType: MissionType.CommentFB),
                  _item(missionType: MissionType.TheoDoi),
                  _item(missionType: MissionType.Share),
                  _item(missionType: MissionType.LikePage),
                  _item(missionType: MissionType.Rate),
                  _item(missionType: MissionType.TymTT),
                  _item(missionType: MissionType.CommentTT),
                  _item(missionType: MissionType.FollowTT),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _item({required MissionType missionType}) {
    return ListTile(
      onTap: () {
        Get.toNamed("${Get.currentRoute}${Routes.MISSION}", arguments: missionType);
      },
      title: Text(missionType.getTitle),
      leading: Image.asset('assets/icons/${getImage(missionType)}.png', width: 24),
      trailing: Image.asset('assets/icons/${getTrailing(missionType)}.png', width: 24),
    );
  }

  String getImage(MissionType missionType) {
    switch (missionType) {
      case MissionType.LikeFb:
        return "like";
      case MissionType.CamXucFb:
        return "heart";
      case MissionType.CamXucBinhLuan:
        return "heart";
      case MissionType.CommentFB:
        return "comment";
      case MissionType.TheoDoi:
        return "follow";
      case MissionType.Share:
        return "share";
      case MissionType.LikePage:
        return "like";
      case MissionType.Join:
        return "join";
      case MissionType.Rate:
        return "star";
      case MissionType.TymTT:
        return "heart";
      case MissionType.CommentTT:
        return "comment";
      case MissionType.FollowTT:
        return "follow";
      default:
        return "";
    }
  }

  String getTrailing(MissionType missionType) {
    switch (missionType) {
      case MissionType.LikeFb:
      case MissionType.CamXucFb:
      case MissionType.CamXucBinhLuan:
      case MissionType.CommentFB:
      case MissionType.TheoDoi:
      case MissionType.Share:
      case MissionType.LikePage:
      case MissionType.Join:
      case MissionType.Rate:
        return "face_book";
      case MissionType.TymTT:
      case MissionType.CommentTT:
      case MissionType.FollowTT:
        return "tik_tok";
      default:
        return "";
    }
  }
}
