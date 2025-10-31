import 'package:flutter/material.dart';

class JapanTheme {
  // Palette de couleurs inspirée du Japon
  static const Color primaryRed = Color(0xFFE53E3E); // Rouge japonais (aka)
  static const Color secondaryGold = Color(0xFFD69E2E); // Or (kin)
  static const Color accentBlue = Color(0xFF3182CE); // Bleu indigo (ai)
  static const Color forestGreen = Color(0xFF38A169); // Vert forêt (midori)
  static const Color sakuraPink = Color(0xFFED64A6); // Rose sakura
  static const Color darkCharcoal = Color(0xFF2D3748); // Charbon sumi
  static const Color lightPaper = Color(0xFFFAF5F0); // Papier washi
  static const Color softGray = Color(0xFFE2E8F0); // Gris doux
  static const Color warmWhite = Color(0xFFFFFBF7); // Blanc chaud

  // Gradients thématiques
  static const LinearGradient backgroundGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [lightPaper, warmWhite],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [warmWhite, Color(0xFFF7FAFC)],
  );

  // Ombres cohérentes
  static List<BoxShadow> get softShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> get mediumShadow => [
    BoxShadow(
      color: Colors.black.withOpacity(0.12),
      blurRadius: 20,
      offset: const Offset(0, 8),
    ),
  ];

  // Styles de texte
  static const TextStyle headingLarge = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: darkCharcoal,
    height: 1.2,
  );

  static const TextStyle headingMedium = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: darkCharcoal,
    height: 1.3,
  );

  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: darkCharcoal,
    height: 1.4,
  );

  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xFF4A5568),
    height: 1.4,
  );

  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: Color(0xFF718096),
    height: 1.3,
  );

  // Bordures arrondies cohérentes
  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;
  static const double radiusXLarge = 20.0;

  // Espacements cohérents
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 20.0;
  static const double spacingXL = 24.0;
  static const double spacingXXL = 32.0;

  // Couleurs par ville (cohérent avec daily_page)
  static const Map<String, Color> cityColors = {
    'Tokyo': primaryRed,
    'Kyoto': sakuraPink,
    'Osaka': secondaryGold,
    'Nara': forestGreen,
    'Kamakura': accentBlue,
    'Fuji': Color(0xFF8B5CF6),
    'Hakone': Color(0xFF06B6D4),
    'Ishigaki': Color(0xFF14B8A6),
    'Départ': Color(0xFF6366F1),
    'Retour': Color(0xFF6366F1),
  };

  // Composant Card cohérent
  static Widget buildCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
  }) {
    return Container(
      margin: margin ?? const EdgeInsets.all(spacingM),
      decoration: BoxDecoration(
        color: color ?? warmWhite,
        borderRadius: BorderRadius.circular(radiusLarge),
        boxShadow: softShadow,
      ),
      child: Padding(
        padding: padding ?? const EdgeInsets.all(spacingL),
        child: child,
      ),
    );
  }

  // Header cohérent
  static Widget buildHeader({
    required String title,
    String? subtitle,
    required String emoji,
    Color? backgroundColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(spacingL),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(spacingM),
            decoration: BoxDecoration(
              color: backgroundColor?.withOpacity(0.1) ?? primaryRed.withOpacity(0.1),
              borderRadius: BorderRadius.circular(radiusLarge),
            ),
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(width: spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: headingLarge),
                if (subtitle != null) ...[
                  const SizedBox(height: spacingXS),
                  Text(subtitle, style: bodyMedium),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bouton cohérent
  static Widget buildButton({
    required String text,
    required VoidCallback onPressed,
    Color? color,
    IconData? icon,
    bool isOutlined = false,
  }) {
    final buttonColor = color ?? primaryRed;
    
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(radiusMedium),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: spacingL,
            vertical: spacingM,
          ),
          decoration: BoxDecoration(
            color: isOutlined ? Colors.transparent : buttonColor,
            borderRadius: BorderRadius.circular(radiusMedium),
            border: Border.all(
              color: buttonColor,
              width: isOutlined ? 1.5 : 0,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: isOutlined ? buttonColor : warmWhite,
                  size: 18,
                ),
                const SizedBox(width: spacingS),
              ],
              Text(
                text,
                style: bodyLarge.copyWith(
                  color: isOutlined ? buttonColor : warmWhite,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Badge cohérent
  static Widget buildBadge({
    required String text,
    Color? color,
    bool isSmall = false,
  }) {
    final badgeColor = color ?? primaryRed;
    
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isSmall ? spacingS : spacingM,
        vertical: isSmall ? spacingXS : spacingS,
      ),
      decoration: BoxDecoration(
        color: badgeColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(isSmall ? 8 : 12),
      ),
      child: Text(
        text,
        style: (isSmall ? caption : bodyMedium).copyWith(
          color: badgeColor,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // AppBar cohérent
  static PreferredSizeWidget buildAppBar({
    required String title,
    List<Widget>? actions,
    Color? backgroundColor,
  }) {
    return AppBar(
      title: Text(
        title,
        style: headingMedium.copyWith(color: warmWhite),
      ),
      backgroundColor: backgroundColor ?? darkCharcoal,
      elevation: 0,
      centerTitle: true,
      actions: actions,
      iconTheme: const IconThemeData(color: warmWhite),
    );
  }

  // Container de fond cohérent
  static Widget buildBackground({required Widget child}) {
    return Container(
      decoration: const BoxDecoration(gradient: backgroundGradient),
      child: child,
    );
  }

  static ThemeData buildTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryRed,
        brightness: Brightness.light,
      ).copyWith(
        primary: primaryRed,
        secondary: secondaryGold,
        tertiary: sakuraPink,
        surface: Colors.grey[50],
        onSurface: Colors.grey[800],
      ),
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        backgroundColor: primaryRed,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.black,
        indicatorColor: primaryRed,
        height: 60,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: Colors.white, size: 28);
          }
          return IconThemeData(color: Colors.white.withOpacity(0.6), size: 24);
        }),
      ),
      cardTheme: CardThemeData(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      textTheme: TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Colors.grey[800],
        ),
        headlineMedium: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
        titleLarge: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.grey[800],
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: Colors.grey[800],
        ),
      ),
    );
  }
}