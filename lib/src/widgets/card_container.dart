import 'package:flutter/material.dart';

/// 创建时间：2022/7/7
/// 作者：LinMingQuan
/// 描述：


class CardContainer extends StatelessWidget {
  const CardContainer({
    Key? key,
    this.color,
    this.shadowColor,
    this.elevation,
    this.shape,
    this.borderOnForeground = true,
    this.margin,
    this.clipBehavior,
    this.child,
    this.semanticContainer = true,
  }) : assert(elevation == null || elevation >= 0.0),
        super(key: key);

  factory CardContainer.shadow({required Widget child}){
    return CardContainer(
      child: child,
      margin: EdgeInsets.only(
        bottom: 10,
      ),
    );
  }

  final Color? color;

  final Color? shadowColor;

  final double? elevation;

  final ShapeBorder? shape;

  final bool borderOnForeground;

  final Clip? clipBehavior;

  final EdgeInsetsGeometry? margin;

  final bool semanticContainer;

  final Widget? child;

  static const double _defaultElevation = 1.0;
  static const double _defaultElevationPx = 4.0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final CardTheme cardTheme = CardTheme.of(context);

    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin ?? cardTheme.margin ?? const EdgeInsets.all(4.0),
        child: Material(
          type: MaterialType.card,
          shadowColor: shadowColor,
          // color: color ?? Colours.blockBgColor,
          elevation: 4,
          shape: shape ?? cardTheme.shape ?? const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          borderOnForeground: borderOnForeground,
          clipBehavior: clipBehavior ?? cardTheme.clipBehavior ?? Clip.none,
          child: Semantics(
            explicitChildNodes: !semanticContainer,
            child: child,
          ),
        ),
      ),
    );
  }
}


class DividerContainer extends StatelessWidget {
  const DividerContainer({
    Key? key,
    this.child,
    this.color,
    this.margin,
    this.semanticContainer = true,
  }) : super(key: key);
  final Widget? child;
  final Color? color;
  final EdgeInsetsGeometry? margin;
  final bool semanticContainer;
  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: semanticContainer,
      child: Container(
        margin: margin,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: Divider.createBorderSide(context, color: Colors.black.withOpacity(0.2), width: 0.5),
          ),
        ),
        child: Semantics(
          explicitChildNodes: !semanticContainer,
          child: child,
        ),
      ),
    );
  }
}

