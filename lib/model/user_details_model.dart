class UserDetailsModel {
  final String name, address;

  UserDetailsModel({
    required this.name,
    required this.address,
  });

  Map<String, dynamic> getJson() => {
        'name': name,
        'address': address,
      };

  factory UserDetailsModel.getModelFormJson(Map<String, dynamic> json) {
    return UserDetailsModel(name: json['name'], address: json['address']);
  }
}
