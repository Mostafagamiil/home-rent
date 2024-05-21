import 'package:flutter/material.dart';
import 'package:home_rent/gen/assets.gen.dart';
import 'package:home_rent/presentation/components/text.dart';
import 'package:home_rent/presentation/pages/details_page/widgets/header_image.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../data/sources/local_source.dart';
import 'package:permission_handler/permission_handler.dart';

class UserProfile__widget extends StatelessWidget {
  final CategoryItem item;

  const UserProfile__widget({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 40.0,
          width: 40.0,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: kColorText3,
            image: DecorationImage(
              image: AssetImage(Assets.images.avatar.path),
            ),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            LabelMedium__text(
                text:
                    'Mohamed Shams'), // Example name, replace with actual data if available
            const SizedBox(height: 4),
            BodySmall__text(
                text:
                    'Owner'), // Example title, replace with actual data if available
          ],
        ),
        const Spacer(),
        IconButton(
          icon: Icon(Icons.phone, color: kColorAccent),
          onPressed: () => _launchPhone(item.phone),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

void _checkAndRequestPermission() async {
    var status = await Permission.phone.status;
    if (!status.isGranted) {
        print("Requesting permission...");
        final result = await Permission.phone.request();
        if (result.isGranted) {
            print("Permission granted. Attempting to launch dialer...");
            _launchPhone(item.phone);
        } else {
            print("Permission denied");
        }
    } else {
        print("Permission already granted. Launching dialer...");
        _launchPhone(item.phone);
    }
}

void _launchPhone(String number) async {
    final Uri url = Uri.parse('tel:$number');
    if (await canLaunchUrl(url)) {
        print('URL is launchable, attempting...');
        bool launched = await launchUrl(url);
        print('Launch status: $launched');
    } else {
        print('URL cannot be launched');
    }
}
_calling() async {
  const url = 'tel:+20 115 595 3690';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}

}
