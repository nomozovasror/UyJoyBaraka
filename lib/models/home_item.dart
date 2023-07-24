class HomeItem {
  bool? ok;
  String? message;
  List<Posts>? posts;
  int? cPage;
  int? totalCount;

  HomeItem({this.ok, this.message, this.posts, this.cPage, this.totalCount});

  HomeItem.fromJson(Map<String, dynamic> json) {
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
  String? phone;
  bool? status;
  bool? confirm;
  int? likeCount;
  int? viewCount;
  bool? rec;
  String? fullName;
  String? avatar;
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
        this.phone,
        this.status,
        this.confirm,
        this.likeCount,
        this.viewCount,
        this.rec,
        this.fullName,
        this.avatar,
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
    phone = json['phone'];
    status = json['status'];
    confirm = json['confirm'];
    likeCount = json['likeCount'];
    viewCount = json['viewCount'];
    rec = json['rec'];
    fullName = json['full_name'];
    avatar = json['avatar'];
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
    data['phone'] = phone;
    data['status'] = status;
    data['confirm'] = confirm;
    data['likeCount'] = likeCount;
    data['viewCount'] = viewCount;
    data['rec'] = rec;
    data['full_name'] = fullName;
    data['avatar'] = avatar;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['user_id'] = userId;
    return data;
  }
}
