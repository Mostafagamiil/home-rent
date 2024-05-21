import 'package:flutter/material.dart';
import 'package:home_rent/presentation/pages/home/widgets/appbar.dart';
import 'package:home_rent/presentation/pages/home/widgets/button_group.dart';
import 'package:home_rent/presentation/pages/home/widgets/card_horizontal_list.dart';
import 'package:home_rent/presentation/pages/home/widgets/card_vertical_list.dart';
import 'package:home_rent/presentation/pages/home/widgets/search_and_filter.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:home_rent/presentation/themes/config.dart';

import '../widgets/card_Horizontal_List 2.dart';
import '../widgets/card_Horizontal_List 3.dart';
import '../widgets/card_Horizontal_List 4.dart';
import '../widgets/title_bar.dart';

class ScreenHome extends StatefulWidget {
  const ScreenHome({Key? key}) : super(key: key);

  @override
  _ScreenHomeState createState() => _ScreenHomeState();
}

class _ScreenHomeState extends State<ScreenHome> {
  String _selectedCategory = 'Home';

  void _onCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenConfig().init(context);

    return Scaffold(
      backgroundColor: kColorScaffold,
      appBar: appbar__widget(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SearchAndFilter(),
              ButtonGroup__widget(onCategoryTap: _onCategoryTap),
              kSizedBoxHeight_8,
              TitleBar__widget(
                  title: 'Selected: $_selectedCategory', ontap: () {}),
              if (_selectedCategory == 'Home') ...[
                const CardHorizontalList__widget(),
                kSizedBoxHeight_8,
                TitleBar__widget(title: 'Best for you', ontap: () {}),
                const CaerdVerticalList__widget(),
                kSizedBoxHeight_16,
              ] else if (_selectedCategory == 'Apartment') ...[
                const CardHorizontalList2(),
              ] else if (_selectedCategory == 'Hotel') ...[
                const CardHorizontalList3(),
              ] else if (_selectedCategory == 'Villa') ...[
                const CardHorizontalList4(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}
