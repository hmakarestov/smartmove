import 'package:flutter/material.dart';

class IconsHelper {
  static IconData getIconByName(String? name) {
    switch (name) {
      case "blocks":
        return Icons.apartment;
      case "faq":
        return Icons.question_answer_outlined;
      case "pacman":
        return Icons.games;
      case "location":
        return Icons.place;
      case "info":
        return Icons.info;
      default:
        return Icons.device_unknown;
    }
  }
}
