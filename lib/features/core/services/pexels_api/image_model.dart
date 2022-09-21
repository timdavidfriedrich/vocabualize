class ImageModel {
  ImageModel({
    required this.id,
    required this.width,
    required this.height,
    required this.url,
    required this.photographer,
    this.photographerUrl,
    this.photographerID,
    this.avgColor,
    required this.src,
  });

  int id;
  int width;
  int height;
  String url;
  String photographer;
  String? photographerUrl;
  int? photographerID;
  String? avgColor;
  Map<String, dynamic> src;

  static String fallbackUrl = "https://raw.githubusercontent.com/koehlersimon/fallback/master/Resources/Public/Images/placeholder.jpg";

  factory ImageModel.fallback() => ImageModel(
        id: 0,
        width: 0,
        height: 0,
        url: fallbackUrl,
        photographer: "fallback",
        photographerUrl: "",
        photographerID: 0,
        avgColor: "#000000",
        src: {
          "original": fallbackUrl,
          "large2x": fallbackUrl,
          "large": fallbackUrl,
          "medium": fallbackUrl,
          "small": fallbackUrl,
          "portrait": fallbackUrl,
          "landscape": fallbackUrl,
          "tiny": fallbackUrl,
        },
      );

  factory ImageModel.fromJson(Map<String, dynamic> json) => ImageModel(
        id: json["id"],
        width: json["width"],
        height: json["height"],
        url: json["url"],
        photographer: json["photographer"],
        photographerUrl: json["photographerUrl"],
        photographerID: json["photographerID"],
        avgColor: json["avg_color"],
        src: json["src"],
      );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "width": width,
      "height": height,
      "url": url,
      "photographer": photographer,
      "photographerUrl": photographerUrl,
      "photographerID": photographerID,
      "avgColor": avgColor,
      "src": src,
    };
  }
}
