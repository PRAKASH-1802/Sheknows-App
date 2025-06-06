
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheknows_app/Services/database.dart';
import 'package:sheknows_app/loading.dart';

class MyOrders extends StatefulWidget {
  @override
  _MyOrdersState createState() => _MyOrdersState();
}

class _MyOrdersState extends State<MyOrders> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;
  late DatabaseService db;

  List<Map<String, dynamic>> orders = [];
  List<Map<String, dynamic>> filteredOrders = [];

  Future<void> fetchOrders() async {
    try {
      orders = await db.getOrders();
      filteredOrders = List.from(orders);
      setState(() {});
    } catch (e) {
      print("Error fetching orders: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load orders: $e")),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    User? user = auth.currentUser;
    if (user != null) {
      uid = user.uid;
      db = DatabaseService(uid: uid!);
    }
    fetchOrders();
  }

  void filterOrders(String query) {
    setState(() {
      filteredOrders = orders
          .where((order) => order['name']
          .toString()
          .toLowerCase()
          .contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Orders",
          style: TextStyle(
            fontSize: 28, // Increased font size for the title
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purpleAccent.shade100, // Consistent color scheme
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: filterOrders,
              decoration: InputDecoration(
                hintText: 'Search orders...',
                hintStyle: TextStyle(fontSize: 18, color: Colors.grey[600]),
                prefixIcon: Icon(Icons.search, color: Colors.purpleAccent),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 15),
              ),
            ),
          ),
        ),
      ),
      body: uid == null
          ? Center(
        child: Text(
          "Please log in to view orders",
          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        ),
      )
          : filteredOrders.isEmpty
          ? Center(
        child: Text(
          "No orders found",
          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0), // Added padding to the list
        itemCount: filteredOrders.length,
        itemBuilder: (context, index) {
          var order = filteredOrders[index];
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: order['imageUrl'] != null &&
                        order['imageUrl'].isNotEmpty
                        ? Image.asset(
                      order['imageUrl'],
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    )
                        : Image.asset(
                      'assets/images/placeholder.png',
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(width: 16.0),
                  // Order Details
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Medicine Name
                        Text(
                          order['name'] ?? 'N/A',
                          style: TextStyle(
                            fontSize: 22, // Increased font size
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Price
                        Text(
                          "₹${order['price'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 18, // Increased font size
                            fontWeight: FontWeight.w600,
                            color: Colors.green[700],
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // Quantity and Multiplier
                        Text(
                          "Quantity: ${order['quantity'] ?? 'N/A'} x ${order['multiplier'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 16, // Adjusted font size
                            color: Colors.grey[800],
                          ),
                        ),
                        SizedBox(height: 4.0),
                        // Order Date
                        Text(
                          "Date: ${order['orderDate'] ?? 'N/A'}",
                          style: TextStyle(
                            fontSize: 14, // Adjusted font size
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.0),
                        // Status Badge
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 6.0),
                          decoration: BoxDecoration(
                            color: Colors.green[100],
                            borderRadius: BorderRadius.circular(20.0),
                            border: Border.all(
                                color: Colors.green[400]!, width: 1),
                          ),
                          child: Text(
                            "Status: Active",
                            style: TextStyle(
                              fontSize: 14, // Adjusted font size
                              fontWeight: FontWeight.w600,
                              color: Colors.green[800],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}