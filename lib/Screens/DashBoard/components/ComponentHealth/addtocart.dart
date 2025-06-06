import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// CartScreen - StatelessWidget Implementation
class CartScreen extends StatelessWidget {
  final Map<String, dynamic> medicine;

  CartScreen({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    var Provider;
    final cartProvider = Provider.of<CartProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Medicine Cart'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text(medicine['name']),
            subtitle: Text('₹${medicine['price']}'),
            // trailing: ElevatedButton(
            //   onPressed: () {
            //     cartProvider.addToCart(medicine);
            //     ScaffoldMessenger.of(context).showSnackBar(
            //       const SnackBar(content: Text('Added to Cart!')),
            //     );
            //   },
            //   child: const Text('Add to Cart'),
            // ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: cartProvider.cartItems.length,
              itemBuilder: (context, index) {
                final item = cartProvider.cartItems[index];
                return ListTile(
                  title: Text(item['name']),
                  subtitle: Text('₹${item['price']}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
// CartProvider Class
class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cartItems = [];

  List<Map<String, dynamic>> get cartItems => _cartItems;

  void addToCart(Map<String, dynamic> medicine) {
    _cartItems.add(medicine);
    notifyListeners(); // UI update ke liye
  }
}

// Main Function
// void main() {
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => CartProvider()),
//       ],
//       child: const MaterialApp(
//         home: CartScreen(
//           medicine: {
//             'name': 'Paracetamol',
//             'price': '50',
//           },
//         ),
//       ),
//     ),
//   );
// }
