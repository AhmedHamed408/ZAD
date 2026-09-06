import 'package:flutter/material.dart';

enum AssistantCategoryType {
  account,
  money,
  internet,
  qr,
  history,
  chat,
  settings,
  theme,
  language,
  responsible,
  security,
  demo,
}

class AssistantStepModel {
  final int stepNumber;
  final String title;
  final String description;
  final IconData icon;

  const AssistantStepModel({
    required this.stepNumber,
    required this.title,
    required this.description,
    required this.icon,
  });
}

class AssistantTopicModel {
  final String id;
  final String titleKey;
  final String subtitleKey;
  final IconData icon;
  final Color themeColor;
  final AssistantCategoryType category;
  final List<String> keywords;
  final List<AssistantStepModel> steps;
  final String? routeToNavigate;
  final String? actionButtonTextKey;
  final bool isDemoNotice;

  const AssistantTopicModel({
    required this.id,
    required this.titleKey,
    required this.subtitleKey,
    required this.icon,
    required this.themeColor,
    required this.category,
    required this.keywords,
    required this.steps,
    this.routeToNavigate,
    this.actionButtonTextKey,
    this.isDemoNotice = false,
  });
}

class AssistantCategoryModel {
  final AssistantCategoryType type;
  final String titleKey;
  final IconData icon;
  final Color color;

  const AssistantCategoryModel({
    required this.type,
    required this.titleKey,
    required this.icon,
    required this.color,
  });
}
