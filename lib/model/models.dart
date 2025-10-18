class UserModels {
  final String id;
  final String email;
  final String name;
  final String employeeID;
  final int? department;
  UserModels(
      {required this.id,
      required this.employeeID,
      required this.department,
      required this.email,
      required this.name});
  factory UserModels.fromJson(Map<String, dynamic> date) {
    return UserModels(
        id: date['id'],
        employeeID: date['employeeID'],
        department: date['department'],
        email: date['email'],
        name: date['name']);
  }
}
