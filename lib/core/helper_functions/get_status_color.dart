import 'package:flutter/material.dart';

Color getStatusColor(String status, BuildContext context) {
  String statusLower = status.toLowerCase();

  switch (statusLower) {
    case 'declined':
      return Theme.of(context).brightness == Brightness.dark
          ? Color(0xFFEF5350) // lighter red for dark mode (Red 400)
          : Color(0xFFD32F2F); // darker red for light mode (Red 700)
    case 'open':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF2196F3) // Sky Blue for Open (Light Theme)
          : const Color(0xFF1976D2); // Darker Blue for Open (Dark Theme)
    case 'in progress':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFFFF9800) // Amber for InProgress (Light Theme)
          : const Color(0xFFF57C00); // Darker Amber for InProgress (Dark Theme)
    case 'fixed':
      return Theme.of(context).brightness == Brightness.light
          ? const Color(0xFF4CAF50) // Emerald Green for Resolved (Light Theme)
          : const Color(0xFF388E3C); // Darker Green for Resolved (Dark Theme)
    default:
      return Colors.grey; // Fallback for unknown status
  }
}
