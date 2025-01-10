class BannerModel {
  final int id;
  final String mobileBanner;
  final String webBanner;
  final String type;
  final bool isVisible;

  BannerModel({
    required this.id,
    required this.mobileBanner,
    required this.webBanner,
    required this.type,
    required this.isVisible,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) {
    return BannerModel(
      id: json['id'] ?? 0,
      mobileBanner: json['mobile_banner'] ?? '',
      webBanner: json['web_banner'] ?? '',
      type: json['type'] ?? '',
      isVisible: json['is_visible'] ?? false,
    );
  }
}