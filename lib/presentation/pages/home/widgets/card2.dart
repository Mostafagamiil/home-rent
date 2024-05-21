import 'package:flutter/material.dart';
import 'package:home_rent/presentation/pages/home/widgets/card_Horizontal_List.dart';

import '../../../components/text.dart';
import '../../../themes/colors.dart';
import '../../../themes/config_files/values.dart';

class CardListItem2 extends StatelessWidget {
  const CardListItem2({
    Key? key,
    required this.distance,
    required this.title,
    required this.description,
    required this.image,
    required this.ontap,
  }) : super(key: key);

  final String distance;
  final String title;
  final String description;
  final image;
  final ontap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Stack(
        children: [
          Container(
            width: 320,
            height: 200,
            decoration: BoxDecoration(
              color: kColorText3,
              image:
                  DecorationImage(fit: BoxFit.cover, image: NetworkImage(image),),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: 320,
            height: 200,
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
                )),
          ),
          Positioned(
            right: 16,
            top: 16,
            child: DistanceChips(
              text: distance,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                LabelSmall__text(text: title, color: kColorWhite),
                kSizedBoxHeight_8,
                BodySmall__text(text: description, color: kColorText3),
              ],
            ),
          )
        ],
      ),
    );
  }
}
