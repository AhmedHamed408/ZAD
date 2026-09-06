import 'package:flutter/material.dart';

class ZadLogo extends StatelessWidget {
  final double? width;
  final double? height;
  final BoxFit fit;
  final String? semanticLabel;

  const ZadLogo({
    super.key,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.semanticLabel = 'ZAD Brand Logo',
  });

  static const String logoAssetPath = 'assets/images/LOGO.png';

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      logoAssetPath,
      width: width,
      height: height,
      fit: fit,
      semanticLabel: semanticLabel,
    );
  }
}
