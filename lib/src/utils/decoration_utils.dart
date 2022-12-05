import 'package:flutter/material.dart';


class DecorationUtils{
  static Decoration assetBackground(String assetBg, {BoxFit fit = BoxFit.fill}){
    return BoxDecoration(
      image: DecorationImage(
        image: AssetImage(assetBg),
        fit: fit,
      ),
    );
  }

  static Decoration round({
    Color? bgColor = Colors.transparent,
    double? height,
    Color borderColor = Colors.transparent,
    double borderWidth = 0,
    double? radius,
    double? leftTopRadius,
    double? rightTopRadius,
    double? leftBottomRadius,
    double? rightBottomRadius,
  }){
    if(radius == null){
      if(height != null){
        radius = height/2;
      }else{
        radius = 4;
      }
    }
    BorderRadiusGeometry? borderRadius;
    if(radius > 0){
      borderRadius = BorderRadius.all(Radius.circular(radius));
    }
    if( (leftTopRadius != null && leftTopRadius > 0) ||
        (rightTopRadius != null && rightTopRadius > 0) ||
        (leftBottomRadius != null && leftBottomRadius > 0) ||
        (rightBottomRadius != null && rightBottomRadius > 0)
    ){
      borderRadius = BorderRadius.only(
        topLeft: Radius.circular(leftTopRadius ?? 0),
        topRight: Radius.circular(rightTopRadius ?? 0),
        bottomLeft: Radius.circular(leftBottomRadius ?? 0),
        bottomRight: Radius.circular(rightBottomRadius ?? 0),
      );
    }
    return BoxDecoration(
      border: Border.all(
          color: borderColor,
          width: borderWidth), // 边色与边宽度
      color: bgColor, // 底色
      borderRadius: borderRadius, // 也可控件一边圆角大小
    );
  }

  static Decoration border({
    double? height,
    Color bgColor = Colors.transparent,
    Color? borderColor,
    double borderWidth = 1,
    double? radius,
  }){
    if(radius == null){
      if(height != null){
        radius = height/2;
      }else{
        radius = 4;
      }
    }
    return BoxDecoration(
      border: Border.all(
          color: borderColor ?? Colors.grey.shade300,
          width: borderWidth), // 边色与边宽度
      color: bgColor, // 底色
      borderRadius: BorderRadius.all(Radius.circular(radius)), // 也可控件一边圆角大小
    );
  }


}