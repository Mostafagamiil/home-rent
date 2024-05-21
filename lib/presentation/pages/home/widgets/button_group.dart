// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:home_rent/presentation/components/button.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import 'package:home_rent/presentation/themes/config.dart';

class ButtonGroup__widget extends StatefulWidget {
  final Function(String) onCategoryTap;

  const ButtonGroup__widget({Key? key, required this.onCategoryTap})
      : super(key: key);

  @override
  _ButtonGroup__widgetState createState() => _ButtonGroup__widgetState();
}

class _ButtonGroup__widgetState extends State<ButtonGroup__widget> {
  String _selectedCategory = 'Home';

  void _handleCategoryTap(String category) {
    setState(() {
      _selectedCategory = category;
    });
    widget.onCategoryTap(category);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          child: ScrollConfiguration(
            behavior: const ScrollBehavior(),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: Row(
                  children: <Widget>[
                    _buildCategoryButton('Home'),
                    kSizedBoxWidth_8,
                    _buildCategoryButton('Apartment'),
                    kSizedBoxWidth_8,
                    _buildCategoryButton('Hotel'),
                    kSizedBoxWidth_8,
                    _buildCategoryButton('Villa'),
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColorScaffold,
                  kColorScaffold.withOpacity(0.0),
                ],
                stops: [0.0, 0.5],
              ),
            ),
            width: 40,
            height: 50,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  kColorScaffold.withOpacity(0.0),
                  kColorScaffold,
                ],
                stops: [0.0, 0.6],
              ),
            ),
            width: 40,
            height: 50,
          ),
        ),
      ],
    );
  }

  Widget _buildCategoryButton(String category) {
    final bool isSelected = _selectedCategory == category;
    final Color buttonColor = isSelected ? kButtonAccentColor : Colors.grey;

    return Accent__Button__Small(
      text: category,
      leftIconVisibility: false,
      rightIconVisibility: false,
      onTap: () => _handleCategoryTap(category),
      backgroundColor: buttonColor,
    );
  }
}
