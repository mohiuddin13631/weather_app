class PhotoModel{
  /*
  type should be matched with api type and variable name hate to be same as like api key
  */
  final String id;
  final String color;
  final Map urls;

//<editor-fold desc="Data Methods">
  const PhotoModel({
    required this.id,
    required this.color,
    required this.urls,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PhotoModel &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          color == other.color &&
          urls == other.urls);

  @override
  int get hashCode => id.hashCode ^ color.hashCode ^ urls.hashCode;

  @override
  String toString() {
    return 'PhotoModel{' +
        ' id: $id,' +
        ' color: $color,' +
        ' urls: $urls,' +
        '}';
  }

  PhotoModel copyWith({
    String? id,
    String? color,
    Map? urls,
  }) {
    return PhotoModel(
      id: id ?? this.id,
      color: color ?? this.color,
      urls: urls ?? this.urls,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'color': this.color,
      'urls': this.urls,
    };
  }

  factory PhotoModel.fromMap(Map<String, dynamic> map) {
    return PhotoModel(
      id: map['id'] as String,
      color: map['color'] as String,
      urls: map['urls'] as Map,
    );
  }

//</editor-fold>
}