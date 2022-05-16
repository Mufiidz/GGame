import 'info.dart';

class MinimumSystemRequirements {
  String os;
  String processor;
  String memory;
  String graphics;
  String storage;

  MinimumSystemRequirements({
    this.os = '',
    this.processor = '',
    this.memory = '',
    this.graphics = '',
    this.storage = '',
  });

  factory MinimumSystemRequirements.fromJson(Map<String, dynamic> json) =>
      MinimumSystemRequirements(
        os: json["os"],
        processor: json["processor"],
        memory: json["memory"],
        graphics: json["graphics"],
        storage: json["storage"],
      );

  Map<String, dynamic> toJson() => {
        "os": os,
        "processor": processor,
        "memory": memory,
        "graphics": graphics,
        "storage": storage,
      };

  List<Info> toListRequire() => [
        Info(title: "OS", desc: os),
        Info(title: "Processor", desc: processor),
        Info(title: "Memory", desc: memory),
        Info(title: "Graphics", desc: graphics),
        Info(title: "Storage", desc: storage),
        Info(
          title: "Additional Notes",
          desc: "Specifications may change during development",
        ),
      ];
}
