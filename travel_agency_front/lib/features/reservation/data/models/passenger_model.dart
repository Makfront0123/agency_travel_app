import '../../domain/entities/passenger.dart';

class PassengerModel extends Passenger {
  const PassengerModel({
    super.id,
    super.passengerId,
    required super.fullName,
    required super.email,
    super.createdAt,
    super.updatedAt,
  });

  factory PassengerModel.fromJson(Map<String, dynamic> json) {
    return PassengerModel(
      id: json['id'],
      passengerId: json['passengerId'],
      fullName: json['fullName'],
      email: json['email'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'passengerId': passengerId,
      'fullName': fullName,
      'email': email,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }
}
