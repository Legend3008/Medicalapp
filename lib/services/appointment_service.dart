import 'package:flutter/material.dart';

class AppointmentService {
  Future<List<TimeOfDay>> getAvailableSlots(DateTime date) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 10, minute: 0),
      const TimeOfDay(hour: 11, minute: 0),
      const TimeOfDay(hour: 14, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
    ];
  }

  Future<bool> bookAppointment(String doctorId, DateTime date, TimeOfDay time) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }
} 