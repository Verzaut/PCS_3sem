class Restaurant {
  String id;
  String name;
  String description;
  double rating;
  List<String> imagePaths;
  DateTime visitDate;
  String address;
  String cuisineType;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    this.rating = 0.0,
    this.imagePaths = const [],
    required this.visitDate,
    this.address = '',
    this.cuisineType = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'rating': rating,
      'imagePaths': imagePaths,
      'visitDate': visitDate.toIso8601String(),
      'address': address,
      'cuisineType': cuisineType,
    };
  }

  factory Restaurant.fromMap(Map<String, dynamic> map) {
    return Restaurant(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      rating: map['rating'],
      imagePaths: List<String>.from(map['imagePaths']),
      visitDate: DateTime.parse(map['visitDate']),
      address: map['address'],
      cuisineType: map['cuisineType'],
    );
  }
}
