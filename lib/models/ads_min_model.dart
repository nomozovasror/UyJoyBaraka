class Ad {
  bool ok;
  Ads2 ads;

  Ad({required this.ok, required this.ads});

  factory Ad.fromJson(Map<String, dynamic> json) {
    return Ad(
      ok: json['ok'] as bool,
      ads: Ads2.fromJson(json['ads'] as Map<String, dynamic>),
    );
  }
}

class Ads2 {
  String id;
  String imgMob;
  String link;

  Ads2({required this.id, required this.imgMob, required this.link});

  factory Ads2.fromJson(Map<String, dynamic> json) {
    return Ads2(
      id: json['id'] as String,
      imgMob: json['img_mob'] as String,
      link: json['link'] as String,
    );
  }
}
