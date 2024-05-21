class CategoryItem {
  final String title;
  final String description;
  final String image; // URL of the image
  final String distance;
  final String price;
  final String phone;

  CategoryItem({
    required this.title,
    required this.description,
    required this.image,
    required this.phone,
    required this.price,
    required this.distance,
  });

  factory CategoryItem.fromJson(Map<String, dynamic> json) {
    return CategoryItem(
      title: json['title'] as String? ?? 'N/A',
      description:
          json['description'] as String? ?? 'No description available.',
      image: json['image'] as String? ??
          'default_image.png', // Provide a default image
      distance: json['distance'] as String? ?? 'Distance not available',
      price: json['price'] as String? ?? 'Price not available',
      phone: json['phone'] as String? ?? 'phone not available',
    );
  }
}
