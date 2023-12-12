class SourceModel {
  final String? name;

  SourceModel({required this.name});

  factory SourceModel.fromJson(Map<String, dynamic> json) {
    return SourceModel(
      name: json['name'] ?? 'No name',
    );
  }
}
