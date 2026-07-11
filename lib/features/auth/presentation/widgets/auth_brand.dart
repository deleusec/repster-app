import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Repster brand mark: a 64×64 translucent white cube with the SVG logo
/// centered inside.
class AuthBrand extends StatelessWidget {
  const AuthBrand({this.size = 64, this.logoSize = 28, super.key});

  final double size;
  final double logoSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withValues(alpha: 0.10)),
      ),
      alignment: Alignment.center,
      child: SvgPicture.asset(
        'assets/images/repster_logo.svg',
        width: logoSize,
        height: logoSize,
      ),
    );
  }
}
