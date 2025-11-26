import 'package:flutter/material.dart';

class Responsive {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1200;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1200;
  }

  static double getWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static double getHeight(BuildContext context) {
    return MediaQuery.of(context).size.height;
  }

  // Retorna padding horizontal baseado no tamanho da tela
  static double getHorizontalPadding(BuildContext context) {
    final width = getWidth(context);
    if (isMobile(context)) {
      return 16.0;
    } else if (isTablet(context)) {
      return width * 0.08;
    } else {
      return width * 0.12;
    }
  }

  // Retorna padding vertical baseado no tamanho da tela
  static double getVerticalPadding(BuildContext context) {
    final height = getHeight(context);
    if (isMobile(context)) {
      return 14.0;
    } else if (isTablet(context)) {
      return height * 0.04;
    } else {
      return height * 0.06;
    }
  }

  // Retorna tamanho de fonte baseado no tamanho da tela
  static double getFontSize(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.3;
    } else {
      return desktop ?? mobile * 1.6;
    }
  }

  // Retorna tamanho de ícone baseado no tamanho da tela
  static double getIconSize(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.2;
    } else {
      return desktop ?? mobile * 1.4;
    }
  }

  // Retorna espaçamento baseado no tamanho da tela
  static double getSpacing(BuildContext context, {
    required double mobile,
    double? tablet,
    double? desktop,
  }) {
    if (isMobile(context)) {
      return mobile;
    } else if (isTablet(context)) {
      return tablet ?? mobile * 1.3;
    } else {
      return desktop ?? mobile * 1.6;
    }
  }

  // Retorna largura máxima para conteúdo centralizado
  static double getMaxContentWidth(BuildContext context) {
    final width = getWidth(context);
    if (isMobile(context)) {
      return width;
    } else if (isTablet(context)) {
      return 800;
    } else {
      return 1200;
    }
  }

  // Retorna número de colunas para grid baseado no tamanho da tela
  static int getGridColumns(BuildContext context) {
    if (isMobile(context)) {
      return 2;
    } else if (isTablet(context)) {
      return 3;
    } else {
      return 4;
    }
  }
}

