class MobileModel {
  final int id;
  final String brand;
  final String name;
  final String longName;
  final List<double> price;
  final List<double> discount;
  final double rating;
  final List<String> color;
  final Map<String, List<String>> imageUrls;
  final int totalRating;
  final List<String> sizes;
  final List<String> filterList;
  final bool dealOfTheDay;
  final bool limitedTimeDeal;
  final bool bestSeller;
  final String offers;
  final String seller;
  final List<int> stock;
  final bool onPrime;

  MobileModel({
    required this.id,
    required this.brand,
    required this.name,
    required this.longName,
    required this.price,
    required this.discount,
    required this.rating,
    required this.color,
    required this.imageUrls,
    required this.totalRating,
    required this.sizes,
    required this.filterList,
    required this.dealOfTheDay,
    required this.limitedTimeDeal,
    required this.bestSeller,
    required this.offers,
    required this.seller,
    required this.stock,
    required this.onPrime,
  });

  factory MobileModel.fromJson(Map<String, dynamic> json) {
    return MobileModel(
      id: json['id'],
      brand: json['brand'],
      name: json['name'],
      longName: json['longName'],
      price: List<double>.from(json['price'].map((value) {
        if (value is int) {
          return value.toDouble();
        } else if (value is double) {
          return value;
        } else {
          return 0.0; // Handle other cases as needed
        }
      })),
      discount: List<double>.from(json['discount'].map((value) {
        if (value is int) {
          return value.toDouble();
        } else if (value is double) {
          return value;
        } else {
          return 0.0; // Handle other cases as needed
        }
      })),
      rating: json['rating'].toDouble(),
      color: List<String>.from(json['color']),
      imageUrls: (json['imageUrls'] as Map<String, dynamic>)
          .map<String, List<String>>((String key, dynamic value) {
        if (value is List) {
          return MapEntry<String, List<String>>(key, value.cast<String>());
        } else {
          return MapEntry<String, List<String>>(key, <String>[]);
        }
      }),
      totalRating: json['totalRating'],
      sizes: List<String>.from(json['sizes']),
      filterList: List<String>.from(json['filterList']),
      dealOfTheDay: json['dealOfTheDay'],
      limitedTimeDeal: json['limitedTimeDeal'],
      bestSeller: json['bestSeller'],
      offers: json['offers'],
      seller: json['seller'],
      stock: List<int>.from(json['stock'].map((value) {
        if (value is int) {
          return value;
        } else if (value is double) {
          return value.toInt();
        } else {
          return 2; // Handle other cases as needed
        }
      })),
      onPrime: json['onPrime'],
    );
  }
}
