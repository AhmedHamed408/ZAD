import 'package:flutter/material.dart';

class AppColors {
  // Brand Palette: Deep Navy & Emerald Green with Gold Accents
  static const Color primary = Color(0xFF0F172A);         // Deep Slate Navy
  static const Color primaryDark = Color(0xFF0A0E1A);     // Midnight Navy
  static const Color accent = Color(0xFF10B981);          // Emerald Green
  static const Color accentDark = Color(0xFF059669);      // Dark Emerald
  static const Color accentLight = Color(0xFFD1FAE5);     // Soft Emerald Tint
  static const Color gold = Color(0xFFF59E0B);             // Gold Accent
  static const Color goldLight = Color(0xFFFEF3C7);        // Soft Gold Tint

  // Light Mode Colors
  static const Color lightBackground = Color(0xFFF8FAFC); // Soft Slate 50
  static const Color lightSurface = Color(0xFFFFFFFF);
  static const Color lightCard = Color(0xFFFFFFFF);
  static const Color lightTextPrimary = Color(0xFF0F172A);
  static const Color lightTextSecondary = Color(0xFF64748B);
  static const Color lightBorder = Color(0xFFE2E8F0);

  // Dark Mode Colors
  static const Color darkBackground = Color(0xFF0A0E1A);  // Midnight Dark
  static const Color darkSurface = Color(0xFF131B2E);     // Deep Surface Slate
  static const Color darkCard = Color(0xFF1E293B);        // Surface Card Slate
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFF94A3B8);
  static const Color darkBorder = Color(0xFF283548);

  // Functional Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Legacy compatibility helpers
  static const Color gold1 = Color(0xFFFFD700);
  static const Color gold2 = Color(0xFFFFA500);
}
