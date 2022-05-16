class Platform {
  String platform;

  Platform({
    this.platform = '',
  });

  factory Platform.fromJson(Map<String, dynamic> json) =>
      Platform(platform: 'platform');

  Map<String, dynamic> toJon() => {
        'platform': platform,
      };
}