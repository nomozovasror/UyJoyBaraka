class Advertising {
  bool? ok;
  List<Ads>? ads;

  Advertising({this.ok, this.ads});

  Advertising.fromJson(Map<String, dynamic> json) {
    ok = json['ok'];
    if (json['ads'] != null) {
      ads = <Ads>[];
      json['ads'].forEach((v) {
        ads!.add( Ads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ok'] = ok;
    if (ads != null) {
      data['ads'] = ads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Ads {
  String? id;
  String? imgMob;
  String? link;

  Ads({this.id, this.imgMob, this.link});

  Ads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    imgMob = json['img_mob'];
    link = json['link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['img_mob'] = imgMob;
    data['link'] = link;
    return data;
  }
}
