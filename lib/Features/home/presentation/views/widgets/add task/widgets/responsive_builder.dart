import 'package:flutter/material.dart';
import 'package:to_do/Features/home/presentation/views/widgets/add%20task/utils/responsive_utils.dart';

class ResponsiveWidget extends StatelessWidget {
  final Widget mobile;
  final Widget? tablet;
  final Widget? tabletLarge;
  final Widget? desktop;

  const ResponsiveWidget({
    super.key,
    required this.mobile,
    this.tablet,
    this.tabletLarge,
    this.desktop,
  });

  @override
  Widget build(BuildContext context) {
    if (ResponsiveUtils.isMobile(context)) {
      return mobile;
    }

    if (ResponsiveUtils.isTablet(context)) {
      return tablet ?? mobile;
    }

    if (ResponsiveUtils.isTabletLarge(context)) {
      return tabletLarge ?? tablet ?? mobile;
    }

    if (ResponsiveUtils.isDesktop(context)) {
      return desktop ?? tablet ?? mobile;
    }

    return mobile;
  }
}