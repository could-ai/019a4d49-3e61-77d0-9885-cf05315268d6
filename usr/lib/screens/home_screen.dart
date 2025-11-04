import 'package:flutter/material.dart';
import '../models/product.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> products = Product.mockProducts;

  void _addNewProduct(String name, int available, int sold, int upcoming) {
    setState(() {
      products.add(Product(
        name: name,
        availableStock: available,
        soldStock: sold,
        upcomingStock: upcoming,
      ));
    });
  }

  void _showAddProductDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController availableController = TextEditingController();
    final TextEditingController soldController = TextEditingController();
    final TextEditingController upcomingController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Product'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Product Name'),
            ),
            TextField(
              controller: availableController,
              decoration: const InputDecoration(labelText: 'Available Stock'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: soldController,
              decoration: const InputDecoration(labelText: 'Sold Stock'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: upcomingController,
              decoration: const InputDecoration(labelText: 'Upcoming Stock'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              final name = nameController.text;
              final available = int.tryParse(availableController.text) ?? 0;
              final sold = int.tryParse(soldController.text) ?? 0;
              final upcoming = int.tryParse(upcomingController.text) ?? 0;
              if (name.isNotEmpty) {
                _addNewProduct(name, available, sold, upcoming);
                Navigator.of(context).pop();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RK Perfumes Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Available Stock'),
              Tab(text: 'Sold Stock'),
              Tab(text: 'Upcoming Stock'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStockList(products, 'Available'),
            _buildStockList(products, 'Sold'),
            _buildStockList(products, 'Upcoming'),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _showAddProductDialog,
          tooltip: 'Add Product',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Widget _buildStockList(List<Product> products, String type) {
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final stockValue = type == 'Available'
            ? product.availableStock
            : type == 'Sold'
                ? product.soldStock
                : product.upcomingStock;
        return ListTile(
          title: Text(product.name),
          subtitle: Text('$type Stock: $stockValue'),
          trailing: const Icon(Icons.arrow_forward_ios),
        );
      },
    );
  }
}