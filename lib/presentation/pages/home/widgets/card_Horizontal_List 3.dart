import 'package:flutter/material.dart';
import 'package:home_rent/core/utils/navigator.dart';
import 'package:home_rent/presentation/pages/details_page/view/details1.dart';
import 'package:home_rent/presentation/themes/config.dart';

import '../../../../data/sources/api_source.dart';
import '../../../../data/sources/local_source.dart';

class CardHorizontalList3 extends StatefulWidget {
  const CardHorizontalList3({Key? key}) : super(key: key);

  @override
  _CardHorizontalList3State createState() => _CardHorizontalList3State();
}

class _CardHorizontalList3State extends State<CardHorizontalList3> {
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
      items = await FirebaseService().fetchCategoryItems('hotels');
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
    final cardWidth = screenWidth * 0.9; // Adjust this value as needed
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
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: items
              .map((item) => GestureDetector(
onTap: () => Navigator.of(context).push(MaterialPageRoute(
    builder: (context) => ScreenDetails(item: item),
  )),                    child: Container(
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
                              item.distance + " km",
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
                                  color: Colors.white, fontSize: 20),
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