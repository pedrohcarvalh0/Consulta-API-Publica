class ProdutoModel {
  final String title;
  final String description;
  final double price;
  final double rating;
  final String brand;
  final String category;
  final String thumbnail;
  final List<String> images;

  ProdutoModel({
    required this.title,
    required this.description,
    required this.price,
    required this.rating,
    required this.brand,
    required this.category,
    required this.thumbnail,
    required this.images,
  });

  factory ProdutoModel.fromMap(Map<String, dynamic> map) {
    return ProdutoModel(
      title: map['title'] ?? 'Sem título',
      description: map['description'] ?? 'Sem descrição',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      rating: (map['rating'] as num?)?.toDouble() ?? 0.0,
      brand: map['brand'] ?? 'Sem marca',
      category: map['category'] ?? 'Sem categoria',
      thumbnail: map['thumbnail'] ?? '',
      images: List<String>.from(map['images'] ?? []),
    );
  }
}
