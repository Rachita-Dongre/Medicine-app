import 'package:flutter/material.dart';

class Medicine {
  int id;
  String medicineName;
  String frequency;
  String dosageAmount;
  String medicineType;
  String instructions;

  Medicine({
    //this.id,
    this.id = 1,
    required this.medicineName,
    required this.frequency,
    required this.dosageAmount,
    required this.medicineType,
    required this.instructions,
  });

  Map<String, dynamic> toMap() {
    return {
      'Medicine name': medicineName,
      'Frequency': frequency,
      'dosage Amount': dosageAmount,
      'Medicine Type': medicineType,
      'Instructions': instructions
    };
  }
}
