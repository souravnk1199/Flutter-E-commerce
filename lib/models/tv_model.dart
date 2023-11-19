class TVModel {
  final int id;
  final List<String> imageUrls;
  final String name;
  final List<double> price;
  final List<double> discount;
  final double rating;
  final List<int> sizes;
  final int totalRating;
  final bool dealOfTheDay;
  final bool limitedTimeDeal;
  final bool bestSeller;
  final bool onPrime;
  final String offers;
  final String brand;
  final String seller;
  final List<int> stock;

  TVModel({
    required this.id,
    required this.imageUrls,
    required this.name,
    required this.price,
    required this.discount,
    required this.rating,
    required this.sizes,
    required this.totalRating,
    required this.dealOfTheDay,
    required this.limitedTimeDeal,
    required this.bestSeller,
    required this.onPrime,
    required this.offers,
    required this.brand,
    required this.seller,
    required this.stock,
  });

  factory TVModel.fromJson(Map<String, dynamic> json) {
    return TVModel(
      id: json['id'],
      imageUrls: List<String>.from(json['imageUrls']),
      name: json['name'],
      price: List<double>.from(json['price']),
      discount: List<double>.from(json['discount']),
      rating: json['rating'].toDouble(),
      sizes: List<int>.from(json['sizes']),
      totalRating: json['totalRating'],
      dealOfTheDay: json['dealOfTheDay'],
      limitedTimeDeal: json['limitedTimeDeal'],
      bestSeller: json['bestSeller'],
      offers: json['offers'],
      brand: json['brand'],
      seller: json['seller'],
      stock: List<int>.from(json['stock']),
      onPrime: json['onPrime'],
    );
  }
}
