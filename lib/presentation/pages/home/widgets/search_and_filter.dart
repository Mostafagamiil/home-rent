// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../gen/assets.gen.dart';
import '../../../themes/colors.dart';
import 'package:home_rent/presentation/themes/config.dart';

import '../../details_page/view/login.dart';

class SearchAndFilter extends StatelessWidget {
  const SearchAndFilter({
    Key? key,
  }) : super(key: key);

  void _showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Container(
          height: 200,
          
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Settings',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: kColorAccent,
                  onPrimary: kColorWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                onPressed: () async {
                  // Perform logout logic here
                  try {
                    // For example, using FirebaseAuth for logout
                    await FirebaseAuth.instance.signOut();
                    Navigator.pop(context); // Close bottom sheet
                    // Navigate to login or home screen after logout
                    // You can replace ScreenHome() with your login screen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Login()),
                    );
                  } catch (e) {
                    print('Error logging out: $e');
                    // Handle logout error
                  }
                },
                child: const Text('Log Out'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
      child: Row(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 16.0),
            decoration: BoxDecoration(
              color: kColorSecondary,
              borderRadius: BorderRadius.circular(12),
            ),
            width: getScreenWidthPercentage(77),
            height: 48,
            child: Row(
              children: <Widget>[
                Assets.icons.search.svg(),
                kSizedBoxWidth_8,
                const Expanded(
                  child: TextField(
                    style: kSearchTextStyle,
                    cursorColor: kColorPrimary,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search address, or near you',
                      hintStyle: kSearchTextStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              _showLogoutBottomSheet(context);
            },
            child: Container(
              padding: const EdgeInsets.all(12),
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                color: kColorAccent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Assets.icons.filter.svg(color: kColorWhite),
            ),
          ),
        ],
      ),
    );
  }
}

const kSearchTextStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.5,
);
