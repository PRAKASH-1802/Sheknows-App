
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/buydetails.dart';
// import 'package:sheknows_app/Services/database.dart';
// import 'package:sheknows_app/loading.dart';
//
// class ViewCart extends StatefulWidget {
//   @override
//   State<ViewCart> createState() => _ViewCartState();
// }
//
// class _ViewCartState extends State<ViewCart> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String? uid1;
//   late DatabaseService db;
//
//   List<dynamic> cartItems = [];
//   List<dynamic> filteredItems = [];
//   bool isLoading = true;
//
//   Future<void> getCartItems() async {
//     try {
//       setState(() {
//         isLoading = true;
//       });
//       var firestore = FirebaseFirestore.instance;
//       User? user = auth.currentUser;
//       if (user != null) {
//         uid1 = user.uid;
//         QuerySnapshot qn = await firestore
//             .collection("users")
//             .doc(uid1!)
//             .collection("cart")
//             .get();
//
//         setState(() {
//           cartItems = qn.docs.map((doc) {
//             var data = doc.data() as Map<String, dynamic>;
//             return {
//               'name': data['name'] ?? '',
//               'price': data['price']?.toString() ?? '',
//               'imageUrl': data['imageUrl'] ?? '',
//               'category': (data['category'] is List)
//                   ? List<String>.from(data['category'])
//                   : [],
//               'description': (data['description'] is List)
//                   ? List<String>.from(data['description'])
//                   : [],
//               'uid': doc.id,
//             };
//           }).toList();
//           filteredItems = cartItems;
//         });
//       }
//     } catch (e) {
//       print("Error fetching cart items: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Failed to load cart: $e")),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   void searchMedicine(String query) {
//     setState(() {
//       filteredItems = cartItems
//           .where((item) =>
//           item['name'].toLowerCase().contains(query.toLowerCase()))
//           .toList();
//     });
//   }
//
//   Future<void> removeMedicine(String medicineId) async {
//     await db.removeFromCart(uid1!, medicineId);
//     await getCartItems();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     User? user = auth.currentUser;
//     if (user != null) {
//       uid1 = user.uid;
//       db = DatabaseService(uid: uid1!);
//     }
//     getCartItems();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 50,
//         title: Text(
//           "My Cart",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: TextField(
//               onChanged: searchMedicine,
//               decoration: InputDecoration(
//                 hintText: "Search Medicine...",
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//               ),
//             ),
//           ),
//           Expanded(
//             child: isLoading
//                 ? Loading()
//                 : filteredItems.isEmpty
//                 ? Center(child: Text("Cart is empty"))
//                 : ListView.builder(
//               itemCount: filteredItems.length,
//               itemBuilder: (context, index) {
//                 var cartItem = filteredItems[index];
//
//                 return Card(
//                   margin: EdgeInsets.all(15.0),
//                   elevation: 15.0,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white70, width: 1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       Container(
//                         child: Column(
//                           children: [
//                             Row(
//                               children: [
//                                 cartItem['imageUrl'] != null &&
//                                     cartItem['imageUrl'].isNotEmpty
//                                     ? Image.asset(
//                                   cartItem['imageUrl'],
//                                   width: 100,
//                                   height: 100,
//                                   fit: BoxFit.cover,
//                                 )
//                                     : Image.asset(
//                                   'assets/images/placeholder.png',
//                                   width: 100,
//                                   height: 100,
//                                 ),
//                                 SizedBox(width: 50),
//                                 Column(
//                                   crossAxisAlignment:
//                                   CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "NAME:  ${cartItem['name'] ?? 'N/A'}",
//                                       style: TextStyle(
//                                           fontSize: 24.0,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black),
//                                     ),
//                                     SizedBox(height: 10),
//                                     Text(
//                                       "PRICE:  ₹${cartItem['price'] ?? 'N/A'}",
//                                       style: TextStyle(
//                                           fontSize: 20.0,
//                                           fontWeight: FontWeight.w700,
//                                           color: Colors.black),
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Row(
//                         mainAxisAlignment:
//                         MainAxisAlignment.spaceEvenly,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               try {
//                                 if (uid1 == null) {
//                                   ScaffoldMessenger.of(context)
//                                       .showSnackBar(
//                                     SnackBar(
//                                       content: Text(
//                                           'User not logged in!'),
//                                       backgroundColor: Colors.red,
//                                     ),
//                                   );
//                                   return;
//                                 }
//
//                                 // Navigate to BuyDetails for quantity selection
//                                 await Navigator.of(context)
//                                     .push(
//                                   MaterialPageRoute(
//                                     builder: (context) =>
//                                         BuyDetails(
//                                           uidOfUser: uid1!,
//                                           uidOfMedicine:
//                                           cartItem['uid'],
//                                           name:
//                                           cartItem['name'] ?? '',
//                                           price: cartItem['price']
//                                               ?.toString() ??
//                                               '',
//                                           imageUrl: [
//                                             cartItem['imageUrl'] ?? ''
//                                           ],
//                                           category: (cartItem[
//                                           'category']
//                                           is List)
//                                               ? (cartItem['category']
//                                           as List)
//                                               .join(", ")
//                                               : '',
//                                           description: (cartItem[
//                                           'description']
//                                           is List)
//                                               ? (cartItem[
//                                           'description']
//                                           as List)
//                                               .join(", ")
//                                               : '',
//                                         ),
//                                   ),
//                                 )
//                                     .then((_) {
//                                   // Refresh cart items after returning from BuyDetails
//                                   getCartItems();
//                                 });
//                               } catch (e) {
//                                 print("Error: $e");
//                                 ScaffoldMessenger.of(context)
//                                     .showSnackBar(
//                                   SnackBar(
//                                     content: Text('Error: $e'),
//                                     backgroundColor: Colors.red,
//                                   ),
//                                 );
//                               }
//                             },
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.white,
//                               elevation: 10,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10.0)),
//                               ),
//                             ),
//                             icon: Icon(Icons.shopping_basket,
//                                 color: Colors.black),
//                             label: Text(
//                               'Buy Now',
//                               style: TextStyle(color: Colors.black),
//                             ),
//                           ),
//                           ElevatedButton.icon(
//                             onPressed: () =>
//                                 removeMedicine(cartItem['uid']),
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: Colors.red,
//                               elevation: 10,
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.all(
//                                     Radius.circular(10.0)),
//                               ),
//                             ),
//                             icon: Icon(Icons.delete, color: Colors.white),
//                             label: Text(
//                               'Remove',
//                               style: TextStyle(color: Colors.white),
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/buydetails.dart';
import 'package:sheknows_app/Services/database.dart';
import 'package:sheknows_app/loading.dart';

class ViewCart extends StatefulWidget {
  @override
  State<ViewCart> createState() => _ViewCartState();
}

class _ViewCartState extends State<ViewCart> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? uid;
  late DatabaseService db;

  List<Map<String, dynamic>> cartItems = [];
  List<Map<String, dynamic>> filteredItems = [];
  bool isLoading = true;

  // Fetch cart items from Firestore
  Future<void> getCartItems() async {
    try {
      setState(() {
        isLoading = true;
      });

      User? user = auth.currentUser;
      if (user != null) {
        uid = user.uid;
        QuerySnapshot qn = await FirebaseFirestore.instance
            .collection("users")
            .doc(uid!)
            .collection("cart")
            .get();

        setState(() {
          cartItems = qn.docs.map((doc) {
            var data = doc.data() as Map<String, dynamic>;
            return {
              'name': data['name'] ?? '',
              'price': data['price']?.toString() ?? '',
              'imageUrl': data['imageUrl'] ?? '',
              'category': (data['category'] is List)
                  ? List<String>.from(data['category'])
                  : [],
              'description': (data['description'] is List)
                  ? List<String>.from(data['description'])
                  : [],
              'uid': doc.id, // Store the document ID for removal
            };
          }).toList();
          filteredItems = cartItems;
        });
      }
    } catch (e) {
      print("Error fetching cart items: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to load cart: $e")),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Search function to filter cart items
  void searchMedicine(String query) {
    setState(() {
      filteredItems = cartItems
          .where((item) =>
          item['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  // Remove an item from the cart
  Future<void> removeMedicine(String medicineId) async {
    try {
      await db.removeFromCart(uid!, medicineId);
      await getCartItems(); // Refresh the cart after removal
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Item removed from cart"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      print("Error removing item: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to remove item: $e")),
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
    getCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Cart",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.purpleAccent.shade100,
        elevation: 4,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: TextField(
              onChanged: searchMedicine,
              decoration: InputDecoration(
                hintText: 'Search cart items...',
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
          "Please log in to view your cart",
          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        ),
      )
          : isLoading
          ? Loading()
          : filteredItems.isEmpty
          ? Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(fontSize: 20, color: Colors.grey[700]),
        ),
      )
          : ListView.builder(
        padding: EdgeInsets.all(16.0),
        itemCount: filteredItems.length,
        itemBuilder: (context, index) {
          var cartItem = filteredItems[index];

          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            margin: EdgeInsets.only(bottom: 16.0),
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: cartItem['imageUrl'] != null &&
                            cartItem['imageUrl'].isNotEmpty
                            ? Image.asset(
                          cartItem['imageUrl'],
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
                      // Item Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            // Medicine Name
                            Text(
                              cartItem['name'] ?? 'N/A',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            SizedBox(height: 8.0),
                            // Price
                            Text(
                              "₹${cartItem['price'] ?? 'N/A'}",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.green[700],
                              ),
                            ),
                            SizedBox(height: 4.0),
                            // Category
                            Text(
                              "Category: ${cartItem['category'].isNotEmpty ? cartItem['category'].join(", ") : 'N/A'}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey[800],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  // Action Buttons
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () async {
                          try {
                            if (uid == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'User not logged in!'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                              return;
                            }

                            // Navigate to BuyDetails for quantity selection
                            await Navigator.of(context)
                                .push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    BuyDetails(
                                      uidOfUser: uid!,
                                      uidOfMedicine:
                                      cartItem['uid'],
                                      name:
                                      cartItem['name'] ?? '',
                                      price: cartItem['price']
                                          ?.toString() ??
                                          '',
                                      imageUrl: [
                                        cartItem['imageUrl'] ?? ''
                                      ],
                                      category: (cartItem[
                                      'category']
                                      is List)
                                          ? (cartItem['category']
                                      as List)
                                          .join(", ")
                                          : '',
                                      description: (cartItem[
                                      'description']
                                      is List)
                                          ? (cartItem[
                                      'description']
                                      as List)
                                          .join(", ")
                                          : '',
                                    ),
                              ),
                            )
                                .then((_) {
                              // Refresh cart items after returning from BuyDetails
                              getCartItems();
                            });
                          } catch (e) {
                            print("Error: $e");
                            ScaffoldMessenger.of(context)
                                .showSnackBar(
                              SnackBar(
                                content: Text('Error: $e'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.purpleAccent,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        icon: Icon(Icons.shopping_basket,
                            color: Colors.white),
                        label: Text(
                          'Buy Now',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () =>
                            removeMedicine(cartItem['uid']),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          elevation: 5,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                                Radius.circular(10.0)),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                        ),
                        icon: Icon(Icons.delete, color: Colors.white),
                        label: Text(
                          'Remove',
                          style: TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ],
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