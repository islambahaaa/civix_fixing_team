class FixingMemberModel {
  final String name;
  final int age;
  final String jobTitle;
  final String phoneNumber;

  FixingMemberModel({
    required this.name,
    required this.age,
    required this.jobTitle,
    required this.phoneNumber,
  });

  factory FixingMemberModel.fromJson(Map<String, dynamic> json) {
    return FixingMemberModel(
      name: json['name'] ?? '',
      age: json['age'] ?? 0,
      jobTitle: json['jobTitle'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }
}
