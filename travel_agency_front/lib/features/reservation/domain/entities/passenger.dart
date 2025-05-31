class Passenger {
  final int? id;
  final String? passengerId;
  final String fullName;
  final String email;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Passenger({
    this.id,
    this.passengerId,
    required this.fullName,
    required this.email,
    this.createdAt,
    this.updatedAt,
  });
}
