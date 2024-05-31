import 'package:flutter/material.dart';
import 'package:home_rent/presentation/components/button.dart';
import 'package:home_rent/presentation/components/text.dart';
import 'package:home_rent/presentation/pages/details_page/view/payment_details.dart';
import 'package:home_rent/presentation/pages/details_page/widgets/header_image.dart';
import 'package:home_rent/presentation/pages/details_page/widgets/image_gallery.dart';
import 'package:home_rent/presentation/pages/details_page/widgets/map.dart';
import 'package:home_rent/presentation/pages/details_page/widgets/user_profile.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:home_rent/presentation/themes/config.dart';

import '../../../../data/sources/local_source.dart';

class ScreenDetails extends StatelessWidget {
  final CategoryItem item;

  const ScreenDetails({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);
    return Scaffold(
      backgroundColor: kColorScaffold,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
              left: 16, right: 16, bottom: 24), // Updated bottom padding
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 16),
              HeaderImage__widget(
                imageUrl: item.image,
                title: item.title,
                description: item.description,
              ),
              SizedBox(height: 24),
              const LabelSmall__text(text: 'Description'),
              SizedBox(height: 16),
              Text(item.description, style: kBodySmallTextstyle),
              SizedBox(height: 24),
              UserProfile__widget(item: item), // Pass the entire item
              SizedBox(height: 24),
              const LabelSmall__text(text: 'Gallery'),
              SizedBox(height: 16),
              const ImageGallery__widget(),
              SizedBox(height: 32),
              // const Map__widget(), // Uncomment if Map widget is to be used
              buildPriceAndRentButton(context, item),
            ],
          ),
        ),
      ),
    );
  }

Widget buildPriceAndRentButton(BuildContext context, CategoryItem item) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
    decoration: BoxDecoration(
      color: kColorWhite,
      gradient: LinearGradient(
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
        colors: [kColorWhite, kColorWhite.withOpacity(0.0)],
      ),
    ),
    child: Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const BodyMedium__text(text: 'Price', color: kColorText2),
            SizedBox(height: 8),
            LabelMedium__text(text: 'EGP ${item.price} / Year'),
          ],
        ),
        Spacer(),
        Accent__Button__Medium(
          text: 'Rent Now',
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PaymentScreen(item: item),
            ),
          ),
          leftIconVisibility: false,
          rightIconVisibility: false,
        ),
      ],
    ),
  );
}

}
