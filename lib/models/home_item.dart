class HomeItems {
  bool? ok;
  String? message;
  List<Posts>? posts;
  int? cPage;
  int? totalCount;

  HomeItems({this.ok, this.message, this.posts, this.cPage, this.totalCount});

  HomeItems.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    message = json['message'];
    if (json['posts'] != null) {
      posts = <Posts>[];
      json['posts'].forEach((v) {
        posts!.add(Posts.fromJson(v));
      });
    }
    cPage = json['c_page'];
    totalCount = json['totalCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    data['message'] = message;
    if (posts != null) {
      data['posts'] = posts!.map((v) => v.toJson()).toList();
    }
    data['c_page'] = cPage;
    data['totalCount'] = totalCount;
    return data;
  }
}

class Posts {
  String? announcementId;
  String? slug;
  String? title;
  List<String>? thumb;
  String? city;
  String? district;
  String? address;
  String? type;
  String? description;
  int? price;
  String? priceType;
  bool? status;
  bool? confirm;
  int? likeCount;
  int? viewCount;
  bool? rec;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Posts(
      {this.announcementId,
        this.slug,
        this.title,
        this.thumb,
        this.city,
        this.district,
        this.address,
        this.type,
        this.description,
        this.price,
        this.priceType,
        this.status,
        this.confirm,
        this.likeCount,
        this.viewCount,
        this.rec,
        this.createdAt,
        this.updatedAt,
        this.userId});

  Posts.fromJson(Map<String, dynamic> json) {
    announcementId = json['announcement_id'];
    slug = json['slug'];
    title = json['title'];
    thumb = json['thumb'].cast<String>();
    city = json['city'];
    district = json['district'];
    address = json['address'];
    type = json['type'];
    description = json['description'];
    price = json['price'];
    priceType = json['price_type'];
    status = json['status'];
    confirm = json['confirm'];
    likeCount = json['likeCount'];
    viewCount = json['viewCount'];
    rec = json['rec'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['announcement_id'] = announcementId;
    data['slug'] = slug;
    data['title'] = title;
    data['thumb'] = thumb;
    data['city'] = city;
    data['district'] = district;
    data['address'] = address;
    data['type'] = type;
    data['description'] = description;
    data['price'] = price;
    data['price_type'] = priceType;
    data['status'] = status;
    data['confirm'] = confirm;
    data['likeCount'] = likeCount;
    data['viewCount'] = viewCount;
    data['rec'] = rec;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }
}


class GetItemBySlug {
  bool? ok;
  Announcement? announcement;
  User? user;

  GetItemBySlug({this.ok, this.announcement, this.user});

  GetItemBySlug.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    announcement = json['announcement'] != null
        ? new Announcement.fromJson(json['announcement'])
        : null;
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ok'] = this.ok;
    if (this.announcement != null) {
      data['announcement'] = this.announcement!.toJson();
    }
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class Announcement {
  String? announcementId;
  String? slug;
  String? title;
  List<String>? thumb;
  String? city;
  String? district;
  String? address;
  String? type;
  String? description;
  int? price;
  String? priceType;
  bool? status;
  bool? confirm;
  int? likeCount;
  int? viewCount;
  bool? rec;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Announcement(
      {this.announcementId,
        this.slug,
        this.title,
        this.thumb,
        this.city,
        this.district,
        this.address,
        this.type,
        this.description,
        this.price,
        this.priceType,
        this.status,
        this.confirm,
        this.likeCount,
        this.viewCount,
        this.rec,
        this.createdAt,
        this.updatedAt,
        this.userId});

  Announcement.fromJson(Map<String, dynamic> json) {
    announcementId = json['announcement_id'];
    slug = json['slug'];
    title = json['title'];
    thumb = json['thumb'].cast<String>();
    city = json['city'];
    district = json['district'];
    address = json['address'];
    type = json['type'];
    description = json['description'];
    price = json['price'];
    priceType = json['price_type'];
    status = json['status'];
    confirm = json['confirm'];
    likeCount = json['likeCount'];
    viewCount = json['viewCount'];
    rec = json['rec'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['announcement_id'] = this.announcementId;
    data['slug'] = this.slug;
    data['title'] = this.title;
    data['thumb'] = this.thumb;
    data['city'] = this.city;
    data['district'] = this.district;
    data['address'] = this.address;
    data['type'] = this.type;
    data['description'] = this.description;
    data['price'] = this.price;
    data['price_type'] = this.priceType;
    data['status'] = this.status;
    data['confirm'] = this.confirm;
    data['likeCount'] = this.likeCount;
    data['viewCount'] = this.viewCount;
    data['rec'] = this.rec;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['user_id'] = this.userId;
    return data;
  }
}

class User {
  String? userId;
  String? fullName;
  String? phone;

  User({this.userId, this.fullName, this.phone});

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    fullName = json['full_name'];
    phone = json['phone'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['full_name'] = this.fullName;
    data['phone'] = this.phone;
    return data;
  }
}
