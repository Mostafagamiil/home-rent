import 'package:cloud_firestore/cloud_firestore.dart';

import 'local_source.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<CategoryItem>> fetchCategoryItems(String categoryName,
      {DocumentSnapshot? lastDocument, int limit = 10}) async {
    Query query = _db
        .collection('categories')
        .doc(categoryName)
        .collection('items')
        .orderBy('title')
        .limit(limit);

    if (lastDocument != null) {
      query = query.startAfterDocument(lastDocument);
    }

    QuerySnapshot snapshot = await query.get();
    List<CategoryItem> items = snapshot.docs
        .map((doc) => CategoryItem.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
    return items;
  }

  Future<List<CategoryItem>> fetchRandomItemsFromAllCategories(List<String> categories, {int limitPerCategory = 2}) async {
    List<CategoryItem> allItems = [];
    for (String category in categories) {
      try {
        QuerySnapshot snapshot = await _db.collection('categories')
          .doc(category)
          .collection('items')
          .limit(limitPerCategory)
          .get();
        List<CategoryItem> fetchedItems = snapshot.docs.map((doc) => CategoryItem.fromJson(doc.data() as Map<String, dynamic>)).toList();
        print("Fetched ${fetchedItems.length} items from $category");
        allItems.addAll(fetchedItems);
      } catch (e) {
        print("Error fetching items from $category: $e");
      }
    }
    print("Total items fetched: ${allItems.length}");
    allItems.shuffle(); // Randomize the list
    return allItems;
  }
}

