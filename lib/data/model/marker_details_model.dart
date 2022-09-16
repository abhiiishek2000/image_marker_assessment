class MarkerDetails {
  MarkerDetails({
    required this.name,
    required this.des,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    this.isMark=false
  });
  final String name;
  final String des;
  final String imgUrl;
  final String createdAt;
  final String updatedAt;
  final bool isMark;

  MarkerDetails.fromJson(Map<String, Object?> json)
      : this(
    name: json['name']! as String,
    des: json['des']! as String,
    imgUrl: json['imgUrl']! as String,
    createdAt: json['createdAt']! as String,
    updatedAt: json['updatedAt']! as String,
    isMark: json['isMark']! as bool,
  );



  Map<String, Object?> toJson() {
    return {
      'name': name,
      'des': des,
      'imgUrl':imgUrl,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'isMark':isMark
    };
  }
}