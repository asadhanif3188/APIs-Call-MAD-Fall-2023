class Doctor {
  final int id;
  final String name;
  final String specialization;
  final int experience;
  final String designation;
  final String gender;

  const Doctor({
    required this.id,
    required this.name,
    required this.specialization,
    required this.experience,
    required this.designation,
    required this.gender,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'id': int id,
      'name': String name,
      'specialization': String specialization,
      'experience': int experience,
      'designation': String designation,
      'gender': String gender,
      } =>
          Doctor(
            id: id,
            name: name,
            specialization: specialization,
            experience: experience,
            designation: designation,
            gender: gender,
          ),
      _ => throw const FormatException('Failed to load doctor.'),
    };
  }
}

