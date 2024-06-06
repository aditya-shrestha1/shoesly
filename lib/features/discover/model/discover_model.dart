class DiscoverData {
  List<DiscoverModel> discoverData;

  DiscoverData({required this.discoverData});

  factory DiscoverData.fromJson(Map<String, dynamic> json) {
    List<DiscoverModel> discoverData = (json["shoes"] as List)
        .map((item) => DiscoverModel.fromJson(item))
        .toList();
    return DiscoverData(
      discoverData: discoverData,
    );
  }

  Map<String, dynamic> toJson() => {
        'shoes': discoverData.map((model) => model.toJson()).toList(),
      };
}

class DiscoverModel {
  String name;
  double price;
  String size;
  String imageUrl;
  String brandLogoUrl;
  String brandName;
  String description;
  List<Review> reviewData;

  DiscoverModel({
    required this.name,
    required this.price,
    required this.size,
    required this.imageUrl,
    required this.brandLogoUrl,
    required this.brandName,
    required this.description,
    required this.reviewData,
  });

  factory DiscoverModel.fromJson(Map<String, dynamic> json) => DiscoverModel(
        name: json["name"] ?? '',
        price: json["price"] ?? '',
        size: json["size"] ?? '',
        imageUrl: json['image_url'] ?? '',
        brandLogoUrl: json['brand_logo_url'] ?? '',
        brandName: json['brand_name'] ?? '',
        description: json['description'] ?? '',
        reviewData: (json['reviews'] ?? [])
            .map((item) => Review.fromJson(item))
            .toList()
            .cast<Review>(),
      );

  Map<String, dynamic> toJson() => {
        name: name,
        price.toString(): price,
        size: size,
        imageUrl: imageUrl,
        brandLogoUrl: brandLogoUrl,
        brandName: brandName,
        description: description,
        reviewData.toString(): reviewData,
      };
}

class Review {
  final String name;
  final double rating;
  final String reviewMessage;
  final String imageUrl;

  Review(
      {required this.name,
      required this.rating,
      required this.reviewMessage,
      required this.imageUrl});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        name: json["name"] ?? '',
        rating: json["rating"] ?? '',
        reviewMessage: json["review"] ?? '',
        imageUrl: json['image_url'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        name: name,
        rating.toString(): rating,
        reviewMessage: reviewMessage,
        imageUrl: imageUrl,
      };
}
