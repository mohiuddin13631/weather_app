class DataModel{
  String name;
  String email;
  String body;

//<editor-fold desc="Data Methods">
  DataModel({
    required this.name,
    required this.email,
    required this.body,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataModel &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          email == other.email &&
          body == other.body);

  @override
  int get hashCode => name.hashCode ^ email.hashCode ^ body.hashCode;

  @override
  String toString() {
    return 'DataModel{' +
        ' name: $name,' +
        ' email: $email,' +
        ' body: $body,' +
        '}';
  }

  DataModel copyWith({
    String? name,
    String? email,
    String? body,
  }) {
    return DataModel(
      name: name ?? this.name,
      email: email ?? this.email,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'email': this.email,
      'body': this.body,
    };
  }

  factory DataModel.fromMap(Map<String, dynamic> map) {
    return DataModel(
      name: map['name'] as String,
      email: map['email'] as String,
      body: map['body'] as String,
    );
  }

//</editor-fold>
}