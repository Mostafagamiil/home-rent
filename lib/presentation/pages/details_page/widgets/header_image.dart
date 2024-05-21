// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:home_rent/gen/assets.gen.dart';
import 'package:home_rent/presentation/components/text.dart';
import 'package:home_rent/presentation/themes/colors.dart';

import '../../../themes/config_files/values.dart';

const double _stackPadding = 20.0;

// ignore: camel_case_types
class HeaderImage__widget extends StatelessWidget {
  final String imageUrl; // URL for the image
  final String title; // Title to display
  final String description; // Description to display

  const HeaderImage__widget(
      {Key? key,
      required this.imageUrl,
      required this.title,
      required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AspectRatio(
          aspectRatio: 5 / 4,
          child: Container(
            decoration: BoxDecoration(
              color: kColorText3,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(
                  fit: BoxFit.cover, image: NetworkImage(imageUrl)),
            ),
          ),
        ),
        AspectRatio(
          aspectRatio: 5 / 4,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [0.2, 1.0],
                colors: [
                  kColorBlack.withOpacity(0.7),
                  kColorWhite.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
        Positioned(
          top: _stackPadding,
          left: _stackPadding,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: RoundIconButton__widget(
              icon: Assets.icons.back.svg,
            ),
          ),
        ),
        Positioned(
          top: _stackPadding,
          right: _stackPadding,
          child: GestureDetector(
            onTap: () {},
            child: RoundIconButton__widget(
              icon: Assets.icons.bookmark.svg,
            ),
          ),
        ),
        Positioned(
          left: _stackPadding,
          bottom: _stackPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TitleLarge__text(text: title, color: kColorWhite),
              kSizedBoxHeight_8,
              BodySmall__text(text: description, color: kColorText3),
              kSizedBoxHeight_16,
              BedAndBathSection()
            ],
          ),
        ),
      ],
    );
  }
}

class BedAndBathSection extends StatelessWidget {
  const BedAndBathSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Row(
          children: [
            SquareIconButton__widget(icon: Assets.icons.bed.svg),
            kSizedBoxWidth_8,
            const BodySmall__text(text: '6 Bedroom', color: kColorText3),
          ],
        ),
        kSizedBoxWidth_32,
        Row(
          children: [
            SquareIconButton__widget(icon: Assets.icons.bath.svg),
            kSizedBoxWidth_8,
            const BodySmall__text(text: '4 Bathroom', color: kColorText3),
          ],
        ),
      ],
    );
  }
}

class RoundIconButton__widget extends StatelessWidget {
  const RoundIconButton__widget({
    Key? key,
    required this.icon,
    this.iconColor,
    this.bgColor,
  }) : super(key: key);

  final icon;
  final iconColor;
  final bgColor;

  static const double _size = 36.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: bgColor ?? kColorBlack.withOpacity(0.25),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: icon(height: 24.0, width: 24.0, color: iconColor ?? kColorWhite),
      ),
    );
  }
}

class SquareIconButton__widget extends StatelessWidget {
  const SquareIconButton__widget({
    Key? key,
    required this.icon,
    this.iconColor,
    this.bgColor,
    this.onTap,
  }) : super(key: key);

  // ignore: prefer_typing_uninitialized_variables
  final icon;
  final iconColor;
  final bgColor;
  final VoidCallback? onTap;

  static const double _size = 28.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _size,
      height: _size,
      decoration: BoxDecoration(
        color: bgColor ?? kColorWhite.withOpacity(0.20),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: icon(height: 24.0, width: 24.0, color: iconColor ?? kColorWhite),
      ),
    );
  }
}
class SquareIconButton2__widget extends StatelessWidget {
  final Widget icon;
  final Color bgColor;
  final VoidCallback onTap; // This needs to be defined to handle taps

  const SquareIconButton2__widget({
    Key? key,
    required this.icon,
    required this.bgColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell( // Use InkWell to handle taps
      onTap: onTap,
      child: Container(
        width: 40, // Or any other suitable size
        height: 40,
        decoration: BoxDecoration(
          color: bgColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(child: icon),
      ),
    );
  }
}