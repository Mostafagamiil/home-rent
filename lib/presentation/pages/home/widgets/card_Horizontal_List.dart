// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:home_rent/core/utils/navigator.dart';
import 'package:home_rent/gen/assets.gen.dart';
import 'package:home_rent/presentation/components/text.dart';
import 'package:home_rent/presentation/pages/details_page/view/details1.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:home_rent/presentation/themes/config.dart';
import '../../../../data/sources/api_source.dart';
import '../../../../data/sources/local_source.dart';

class CardHorizontalList__widget extends StatefulWidget {
  const CardHorizontalList__widget({Key? key}) : super(key: key);

  @override
  _CardHorizontalList__widgetState createState() =>
      _CardHorizontalList__widgetState();
}

class _CardHorizontalList__widgetState
    extends State<CardHorizontalList__widget> {
  List<CategoryItem> items = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      print("Fetching items...");
      items = await FirebaseService().fetchCategoryItems('apartments');
      print("Items fetched: ${items.length}");
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print("Error fetching items: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final cardWidth = screenWidth * 0.6; // Adjust this value as needed
    final cardHeight = cardWidth * 0.75; // Adjust this value as needed

    if (isLoading) {
      return const Center(
          child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(kButtonAccentColor),
      ));
    }

    return ScrollConfiguration(
      behavior: const ScrollBehavior(),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Row(
          children: items
              .map((item) => GestureDetector(
                    onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => ScreenDetails(item: item),
                    )),
                    child: Container(
                      width: cardWidth,
                      height: cardHeight,
                      margin: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(item.image),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 10,
                            left: 10,
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Positioned(
                            bottom: 30,
                            left: 10,
                            child: Text(
                              item.description,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            left: 10,
                            child: Text(
                              item.distance,
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                          Positioned(
                            top: 10,
                            right: 10,
                            child: Text(
                              "${item.price} EGP",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 12),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class DistanceChips extends StatelessWidget {
  const DistanceChips({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
      decoration: BoxDecoration(
        color: kColorBlack.withOpacity(0.25),
        borderRadius: BorderRadius.circular(50),
      ),
      child: Row(
        children: <Widget>[
          Assets.icons.location.svg(color: kColorWhite),
          BodySmall__text(text: text, color: kColorWhite),
        ],
      ),
    );
  }
}

class CardListItem extends StatelessWidget {
  const CardListItem({
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
            width: 200,
            height: 250,
            decoration: BoxDecoration(
              color: kColorText3,
              image:
                  DecorationImage(fit: BoxFit.cover, image: AssetImage(image)),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          Container(
            width: 200,
            height: 250,
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
