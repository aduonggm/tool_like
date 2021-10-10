
enum MissionType {
  LikeFb,
  CamXucFb,
  CamXucBinhLuan,
  CommentFB,
  TheoDoi,
  Share,
  LikePage,
  Join,
  Rate,
  TymTT,
  CommentTT,
  FollowTT
}

extension GetInfo on MissionType {
  String get getName {
    switch (this) {
      case MissionType.LikeFb:
        return "Like chéo";
      case MissionType.CamXucFb:
        return "Cảm xúc chéo";
      case MissionType.CamXucBinhLuan:
        return "Cảm xúc chéo bình luận ";
      case MissionType.CommentFB:
        return "Bình luận chéo ";
      case MissionType.TheoDoi:
        return "Theo dõi chéo ";
      case MissionType.Share:
        return "Chia sẻ chéo ";
      case MissionType.LikePage:
        return "Like page chéo ";
      case MissionType.Join:
        return "Tham gia nhóm chéo ";
      case MissionType.Rate:
        return "Đánh giá page chéo ";
      case MissionType.TymTT:
        return "Tim chéo TT";
      case MissionType.CommentTT:
        return "Bình luận chéo TT";
      case MissionType.FollowTT:
        return "Follow chéo TT";
      default:
        return "Bình luận FB";
    }
  }

  String get getListLink {
    switch (this) {
      case MissionType.LikeFb:
        return "kiemtien";
      case MissionType.CamXucFb:
        return "kiemtien/camxuccheo";
      case MissionType.CamXucBinhLuan:
        return "kiemtien/camxuccheobinhluan";
      case MissionType.CommentFB:
        return "kiemtien/cmtcheo";
      case MissionType.TheoDoi:
        return "kiemtien/subcheo";
      case MissionType.Share:
        return "kiemtien/sharecheo";
      case MissionType.LikePage:
        return "kiemtien/likepagecheo";
      case MissionType.Join:
        return "kiemtien/thamgianhomcheo";
      case MissionType.Rate:
        return "kiemtien/danhgiapage";
      case MissionType.TymTT:
        return "tiktok/kiemtien";
      case MissionType.CommentTT:
        return "tiktok/kiemtien/cmtcheo";
      case MissionType.FollowTT:
        return "tiktok/kiemtien/subcheo";
      default:
        return "";
    }
  }

  String get getImageName {
    switch (this) {
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

  String get getTrailingImage{
    switch (this) {
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


  String get getLinkTangLike {
    switch (this) {
      case MissionType.LikeFb:
        return "tanglike";
      case MissionType.CamXucFb:
        return "tangcamxuc";
      case MissionType.CamXucBinhLuan:
        return "tangcamxucbinhluan";
      case MissionType.CommentFB:
        return "tangcmt";
      case MissionType.TheoDoi:
        return "tangsub";
      case MissionType.Share:
        return "tangshare";
      case MissionType.LikePage:
        return "tanglikepage";
      case MissionType.Join:
        return "tangthanhviennhom";
      case MissionType.Rate:
        return "danhgiapage";
      case MissionType.TymTT:
        return "tiktok/tanglike";
      case MissionType.CommentTT:
        return "tiktok/tangcmt";
      case MissionType.FollowTT:
        return "tiktok/tangsub";
      default:
        return "";
    }
  }
}
