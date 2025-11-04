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
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('RK Perfumes Management'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Available Stock'),
              Tab(text: 'Sold Stock'),
              Tab(text: 'Upcoming Stock'),
              Tab(text: 'Payments'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildStockList(products, 'Available'),
            _buildStockList(products, 'Sold'),
            _buildStockList(products, 'Upcoming'),
            _buildPaymentOptions(),
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

  Widget _buildPaymentOptions() {
    final List<Map<String, dynamic>> paymentMethods = [
      {'name': 'UPI', 'icon': Icons.account_balance_wallet, 'description': 'Unified Payments Interface - Pay via GPay, PhonePe, etc.'},
      {'name': 'Net Banking', 'icon': Icons.account_balance, 'description': 'Pay through your bank\'s online portal'},
      {'name': 'Debit Card', 'icon': Icons.credit_card, 'description': 'Pay using your debit card'},
      {'name': 'Credit Card', 'icon': Icons.credit_card, 'description': 'Pay using your credit card'},
      {'name': 'Paytm', 'icon': Icons.payment, 'description': 'Paytm Wallet payment option'},
      {'name': 'PhonePe', 'icon': Icons.smartphone, 'description': 'PhonePe UPI payment option'},
      {'name': 'Google Pay', 'icon': Icons.g_mobiledata, 'description': 'Google Pay UPI payment option'},
      {'name': 'Cash on Delivery', 'icon': Icons.local_shipping, 'description': 'Pay cash when product is delivered'},
    ];

    return ListView.builder(
      itemCount: paymentMethods.length,
      itemBuilder: (context, index) {
        final method = paymentMethods[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(method['icon'] as IconData, size: 40),
            title: Text(method['name'] as String),
            subtitle: Text(method['description'] as String),
            trailing: ElevatedButton(
              onPressed: () {
                _showPaymentDialog(method['name'] as String);
              },
              child: const Text('Select'),
            ),
          ),
        );
      },
    );
  }

  void _showPaymentDialog(String paymentMethod) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Payment via $paymentMethod'),
        content: const Text('This is a mock payment integration. In a real app, this would connect to the payment gateway.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // Mock payment success
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Payment successful via $paymentMethod!')),
              );
              Navigator.of(context).pop();
            },
            child: const Text('Confirm Payment'),
          ),
        ],
      ),
    );
  }
}