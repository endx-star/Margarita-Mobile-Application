
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:page_animation_transition/animations/fade_animation_transition.dart';
import 'package:page_animation_transition/animations/left_to_right_transition.dart';
import 'package:page_animation_transition/page_animation_transition.dart';

double width(context) {
  return MediaQuery.of(context).size.width;
}

double height(context) {
  return MediaQuery.of(context).size.height;
}

void navigate(context, String to, {arguments}) {
  Navigator.of(context).pushNamed(to, arguments: arguments);
}

void nav(context, to, {arguments}) {
  Navigator.of(context).push(PageAnimationTransition(
      page: to, pageAnimationType: FadeAnimationTransition()));
}

navandThen(context, to, back, {arguments}) {
  Navigator.of(context)
      .push(PageAnimationTransition(
          page: to, pageAnimationType: FadeAnimationTransition()))
      .then((value) => back);
}
navandThenNav(context, to, back, {arguments}) {
  Navigator.of(context)
      .push(PageAnimationTransition(
          page: to, pageAnimationType: FadeAnimationTransition()))
      .then((value) =>  Navigator.of(context)
      .push(PageAnimationTransition(
          page: back, pageAnimationType: FadeAnimationTransition())));
}
void navigateAndRemove(context, to, {arguments}) {
  Navigator.of(context)
      .push(PageAnimationTransition(
          page: to, pageAnimationType: FadeAnimationTransition()))
      .then((value) => exit(0));
}

void pop(context) {
  Navigator.of(context).pop('');
}

void _navigateToNextScreen(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) => screen));
}
