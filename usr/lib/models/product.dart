class Product {
  final String name;
  final int availableStock;
  final int soldStock;
  final int upcomingStock;

  Product({
    required this.name,
    required this.availableStock,
    required this.soldStock,
    required this.upcomingStock,
  });

  // Mock data for demonstration
  static List<Product> mockProducts = [
    Product(name: 'Lavender Dream', availableStock: 50, soldStock: 20, upcomingStock: 30),
    Product(name: 'Rose Elegance', availableStock: 40, soldStock: 15, upcomingStock: 25),
    Product(name: 'Citrus Fresh', availableStock: 60, soldStock: 10, upcomingStock: 20),
    Product(name: 'Vanilla Bliss', availableStock: 35, soldStock: 25, upcomingStock: 40),
  ];
}