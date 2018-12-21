import 'package:flutter/material.dart';

class NavigationIconView {
  Widget icon;
  Widget title;
  TickerProvider vsync;
  
  final BottomNavigationBarItem item;
  final AnimationController controller;

  NavigationIconView({
    this.icon,
    this.title,
    this.vsync,
  }):
    item = BottomNavigationBarItem(
      icon: icon,
      title: title,
    ),
    controller = AnimationController(
      duration: kThemeAnimationDuration,
      vsync: vsync
    );
}