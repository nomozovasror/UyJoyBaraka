class LikePosts {
  bool? ok;
  String? title;
  List<LikeModel>? posts;
  int? totalCount;
  int? cPage;
  int? pPage;

  LikePosts(
      {this.ok,
        this.title,
        this.posts,
        this.totalCount,
        this.cPage,
        this.pPage});

  LikePosts.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    title = json['title'];
    if (json['posts'] != null) {
      posts = <LikeModel>[];
      json['posts'].forEach((v) {
        posts!.add(LikeModel.fromJson(v));
      });
    }
    totalCount = json['totalCount'];
    cPage = json['c_page'];
    pPage = json['p_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    data['title'] = title;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['totalCount'] = totalCount;
    data['c_page'] = cPage;
    data['p_page'] = pPage;
    return data;
  }
}

class LikeModel {
  String? likeId;
  String? userId;
  String? announcementId;
  String? date;
  String? createdAt;
  String? updatedAt;
  String? announcementAnnouncementId;
  String? announcementSlug;
  String? announcementTitle;
  List<String>? announcementThumb;
  String? announcementCity;
  String? announcementDistrict;
  String? announcementAddress;
  String? announcementType;
  String? announcementDescription;
  int? announcementPrice;
  String? announcementPriceType;
  String? announcementPhone;
  bool? announcementStatus;
  bool? announcementConfirm;
  int? announcementLikeCount;
  int? announcementViewCount;
  bool? announcementRec;
  String? announcementFullName;
  String? announcementAvatar;
  String? announcementCreatedAt;
  String? announcementUpdatedAt;
  String? announcementUserId;

  LikeModel(
      {this.likeId,
        this.userId,
        this.announcementId,
        this.date,
        this.createdAt,
        this.updatedAt,
        this.announcementAnnouncementId,
        this.announcementSlug,
        this.announcementTitle,
        this.announcementThumb,
        this.announcementCity,
        this.announcementDistrict,
        this.announcementAddress,
        this.announcementType,
        this.announcementDescription,
        this.announcementPrice,
        this.announcementPriceType,
        this.announcementPhone,
        this.announcementStatus,
        this.announcementConfirm,
        this.announcementLikeCount,
        this.announcementViewCount,
        this.announcementRec,
        this.announcementFullName,
        this.announcementAvatar,
        this.announcementCreatedAt,
        this.announcementUpdatedAt,
        this.announcementUserId});

  LikeModel.fromJson(Map<String, dynamic> json) {
    likeId = json['like_id'];
    userId = json['user_id'];
    announcementId = json['announcement_id'];
    date = json['date'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    announcementAnnouncementId = json['announcement.announcement_id'];
    announcementSlug = json['announcement.slug'];
    announcementTitle = json['announcement.title'];
    announcementThumb = json['announcement.thumb'].cast<String>();
    announcementCity = json['announcement.city'];
    announcementDistrict = json['announcement.district'];
    announcementAddress = json['announcement.address'];
    announcementType = json['announcement.type'];
    announcementDescription = json['announcement.description'];
    announcementPrice = json['announcement.price'];
    announcementPriceType = json['announcement.price_type'];
    announcementPhone = json['announcement.phone'];
    announcementStatus = json['announcement.status'];
    announcementConfirm = json['announcement.confirm'];
    announcementLikeCount = json['announcement.likeCount'];
    announcementViewCount = json['announcement.viewCount'];
    announcementRec = json['announcement.rec'];
    announcementFullName = json['announcement.full_name'];
    announcementAvatar = json['announcement.avatar'];
    announcementCreatedAt = json['announcement.createdAt'];
    announcementUpdatedAt = json['announcement.updatedAt'];
    announcementUserId = json['announcement.user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['like_id'] = likeId;
    data['user_id'] = userId;
    data['announcement_id'] = announcementId;
    data['date'] = date;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['announcement.announcement_id'] = announcementAnnouncementId;
    data['announcement.slug'] = announcementSlug;
    data['announcement.title'] = announcementTitle;
    data['announcement.thumb'] = announcementThumb;
    data['announcement.city'] = announcementCity;
    data['announcement.district'] = announcementDistrict;
    data['announcement.address'] = announcementAddress;
    data['announcement.type'] = announcementType;
    data['announcement.description'] = announcementDescription;
    data['announcement.price'] = announcementPrice;
    data['announcement.price_type'] = announcementPriceType;
    data['announcement.phone'] = announcementPhone;
    data['announcement.status'] = announcementStatus;
    data['announcement.confirm'] = announcementConfirm;
    data['announcement.likeCount'] = announcementLikeCount;
    data['announcement.viewCount'] = announcementViewCount;
    data['announcement.rec'] = announcementRec;
    data['announcement.full_name'] = announcementFullName;
    data['announcement.avatar'] = announcementAvatar;
    data['announcement.createdAt'] = announcementCreatedAt;
    data['announcement.updatedAt'] = announcementUpdatedAt;
    data['announcement.user_id'] = announcementUserId;
    return data;
  }
}
