
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/viewcart.dart';
// import 'package:sheknows_app/Services/database.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';
//
// class BuyDetails extends StatefulWidget {
//   final String uidOfUser;
//   final String uidOfMedicine;
//   final String name;
//   final String price;
//   final List<String> imageUrl;
//   final String category;
//   final String description;
//
//   BuyDetails({
//     Key? key,
//     required this.uidOfUser,
//     required this.uidOfMedicine,
//     required this.name,
//     required this.price,
//     required this.imageUrl,
//     required this.category,
//     required this.description,
//   }) : super(key: key);
//
//   @override
//   State<BuyDetails> createState() => _BuyDetailsState();
// }
//
// class _BuyDetailsState extends State<BuyDetails> {
//   final _formKey = GlobalKey<FormState>();
//
//   var quantites = [
//     "2 tablets",
//     "3 tablets",
//     "4 tablets",
//     "5 tablets",
//     "6 tablets",
//     "7 tablets",
//     "8 tablets",
//     "9 tablets",
//     "10 tablets",
//     "15 tablets",
//     "20 tablets",
//     "1 bottle"
//   ];
//   var currentQuantitySelected = "2 tablets";
//   var multiplier = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
//   var currentMultiplierSelected = "1";
//   String typeSelected = "";
//   FirebaseAuth auth = FirebaseAuth.instance;
//   String? uid1;
//   int amount = 0;
//
//   late Razorpay _razorpay;
//   late DatabaseService db;
//
//   void uidOfUser() async {
//     User? user = auth.currentUser;
//     if (user != null) {
//       setState(() {
//         uid1 = user.uid;
//       });
//     }
//   }
//
//   String totalQuantity() {
//     if (currentQuantitySelected[1] != " ") {
//       typeSelected =
//       currentQuantitySelected.contains("b") ? "tablets" : "bottles";
//       return (int.parse(currentQuantitySelected.substring(0, 2)) *
//           int.parse(currentMultiplierSelected))
//           .toString();
//     }
//
//     typeSelected =
//     currentQuantitySelected.contains("b") ? "bottles" : "tablets";
//
//     if (currentQuantitySelected[0] == '1' && currentMultiplierSelected == '1') {
//       typeSelected =
//       currentQuantitySelected.contains("b") ? "bottle" : "tablet";
//     }
//     return (int.parse(currentQuantitySelected[0]) *
//         int.parse(currentMultiplierSelected))
//         .toString();
//   }
//
//   @override
//   void initState() {
//     super.initState();
//     uidOfUser();
//     db = DatabaseService(uid: widget.uidOfUser);
//     _razorpay = Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
//   }
//
//   @override
//   void dispose() {
//     _razorpay.clear();
//     super.dispose();
//   }
//
//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_A4kztyzrYRBwyp',
//       'amount': amount * 100,
//       'name': 'K.Prakash_Bharat_Pharma',
//       'description': 'Test Payment',
//       'prefill': {
//         'contact': '9823862448',
//         'email': 'test@example.com',
//       },
//       'theme': {'color': '#F37254'},
//       'external': {
//         'wallets': ['paytm'],
//       },
//     };
//
//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       print(e.toString());
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error opening payment: $e")),
//       );
//     }
//   }
//
//   void _handlePaymentSuccess(PaymentSuccessResponse response) async {
//     Fluttertoast.showToast(
//       msg: "Payment Success: ${response.paymentId}",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.white,
//       textColor: Colors.black,
//       fontSize: 20.0,
//     );
//
//     // Save the order to Firestore after successful payment
//     try {
//       if (uid1 == null) return;
//
//       // Save to 'orders' collection (for MyOrders screen)
//       await db.addToOrders(
//         uid1!,
//         {
//           'name': widget.name,
//           'price': widget.price,
//           'imageUrl': widget.imageUrl.first,
//           'orderDate': DateTime.now().toString(),
//           'quantity': currentQuantitySelected,
//           'multiplier': currentMultiplierSelected,
//         },
//       );
//
//       // Save to 'store_orders' collection (for additional tracking)
//       await db.addToStoreOrders(
//         uid1!,
//         widget.uidOfMedicine,
//         widget.name,
//         amount.toString(),
//         currentQuantitySelected,
//         currentMultiplierSelected,
//         widget.category,
//         widget.imageUrl.first,
//         widget.description,
//       );
//
//       // Navigate back to ViewCart after successful payment
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => ViewCart()),
//       );
//     } catch (e) {
//       print("Error saving order: $e");
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Error saving order: $e")),
//       );
//     }
//   }
//
//   void _handlePaymentError(PaymentFailureResponse response) {
//     Fluttertoast.showToast(
//       msg: "Error occurred: ${response.code} ${response.message}",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.redAccent[100],
//       textColor: Colors.white,
//       fontSize: 20.0,
//     );
//   }
//
//   void _handleExternalWallet(ExternalWalletResponse response) {
//     Fluttertoast.showToast(
//       msg: "External Wallet: ${response.walletName}",
//       toastLength: Toast.LENGTH_LONG,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: Colors.white,
//       textColor: Colors.black,
//       fontSize: 20.0,
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 50,
//         title: Text(
//           "Buy Medicine",
//           style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Card(
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12.0)),
//                 elevation: 5,
//                 child: Padding(
//                   padding: EdgeInsets.all(16.0),
//                   child: Column(
//                     children: [
//                       widget.imageUrl.isNotEmpty
//                           ? Image.asset(
//                         widget.imageUrl.first,
//                         fit: BoxFit.cover,
//                         height: 200,
//                         width: double.infinity,
//                       )
//                           : Image.asset(
//                         'assets/images/placeholder.png',
//                         fit: BoxFit.cover,
//                         height: 200,
//                         width: double.infinity,
//                       ),
//                       SizedBox(height: 10),
//                       Text(widget.name,
//                           style: TextStyle(
//                               fontSize: 22, fontWeight: FontWeight.bold)),
//                       SizedBox(height: 5),
//                       Text("Price: ₹${widget.price}",
//                           style: TextStyle(fontSize: 18)),
//                       SizedBox(height: 5),
//                       Text("Category: ${widget.category}",
//                           style: TextStyle(fontSize: 16)),
//                       SizedBox(height: 20),
//                       Text(
//                         "Description: ${widget.description}",
//                         style: TextStyle(
//                             fontSize: 18, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               buildDropdown(
//                   "Select Quantity", quantites, currentQuantitySelected,
//                       (value) {
//                     setState(() {
//                       currentQuantitySelected = value!;
//                     });
//                   }),
//               SizedBox(height: 10),
//               buildDropdown(
//                   "Select Multiplier", multiplier, currentMultiplierSelected,
//                       (value) {
//                     setState(() {
//                       currentMultiplierSelected = value!;
//                     });
//                   }),
//               SizedBox(height: 10),
//               Text("Total: ${totalQuantity()} $typeSelected",
//                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//               Text(
//                   "Bill: ₹${(int.parse(totalQuantity()) * int.parse(widget.price))}",
//                   style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green)),
//               SizedBox(height: 20),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     ),
//                     onPressed: () {
//                       if (uid1 != null) {
//                         db.addToCart(
//                           uid1!,
//                           widget.uidOfMedicine,
//                           widget.name,
//                           (int.parse(totalQuantity()) * int.parse(widget.price))
//                               .toString(),
//                           widget.imageUrl.first,
//                           widget.category,
//                           currentQuantitySelected,
//                           currentMultiplierSelected,
//                           widget.description,
//                         );
//                         Fluttertoast.showToast(
//                           msg: "Added to Cart Successfully",
//                           toastLength: Toast.LENGTH_SHORT,
//                           gravity: ToastGravity.BOTTOM,
//                           backgroundColor: Colors.green,
//                           textColor: Colors.white,
//                           fontSize: 16.0,
//                         );
//                       }
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => ViewCart()),
//                       );
//                     },
//                     child: Text(
//                       "Add to Cart",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                     ),
//                     onPressed: () {
//                       amount = int.parse(totalQuantity()) * int.parse(widget.price);
//                       if (uid1 != null) {
//                         openCheckout();
//                       } else {
//                         ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(content: Text("Please log in to continue")),
//                         );
//                       }
//                     },
//                     child: Text(
//                       "Make Payment",
//                       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget buildDropdown(String label, List<String> items, String selectedItem,
//       ValueChanged<String?> onChanged) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(label,
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
//         DropdownButton<String>(
//           value: selectedItem,
//           isExpanded: true,
//           onChanged: onChanged,
//           items: items
//               .map((e) => DropdownMenuItem(child: Text(e), value: e))
//               .toList(),
//         ),
//       ],
//     );
//   }
// }
//
//
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/viewcart.dart';
import 'package:sheknows_app/Services/database.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class BuyDetails extends StatefulWidget {
  final String uidOfUser;
  final String uidOfMedicine;
  final String name;
  final String price;
  final List<String> imageUrl;
  final String category;
  final String description;

  BuyDetails({
    Key? key,
    required this.uidOfUser,
    required this.uidOfMedicine,
    required this.name,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.description,
  }) : super(key: key);

  @override
  State<BuyDetails> createState() => _BuyDetailsState();
}

class _BuyDetailsState extends State<BuyDetails> {
  final _formKey = GlobalKey<FormState>();

  var quantites = [
    "2 tablets",
    "3 tablets",
    "4 tablets",
    "5 tablets",
    "6 tablets",
    "7 tablets",
    "8 tablets",
    "9 tablets",
    "10 tablets",
    "15 tablets",
    "20 tablets",
    "1 bottle",
    "1 tablet"
  ];
  var currentQuantitySelected = "2 tablets";
  var multiplier = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"];
  var currentMultiplierSelected = "1";
  String typeSelected = "";
  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid1;
  int amount = 0;

  late Razorpay _razorpay;
  late DatabaseService db;

  void uidOfUser() async {
    User? user = auth.currentUser;
    if (user != null) {
      setState(() {
        uid1 = user.uid;
      });
    }
  }

  String totalQuantity() {
    if (currentQuantitySelected[1] != " ") {
      typeSelected =
      currentQuantitySelected.contains("b") ? "tablets" : "bottles";
      return (int.parse(currentQuantitySelected.substring(0, 2)) *
          int.parse(currentMultiplierSelected))
          .toString();
    }

    typeSelected =
    currentQuantitySelected.contains("b") ? "bottles" : "tablets";

    if (currentQuantitySelected[0] == '1' && currentMultiplierSelected == '1') {
      typeSelected =
      currentQuantitySelected.contains("b") ? "bottle" : "tablet";
    }
    return (int.parse(currentQuantitySelected[0]) *
        int.parse(currentMultiplierSelected))
        .toString();
  }

  @override
  void initState() {
    super.initState();
    uidOfUser();
    db = DatabaseService(uid: widget.uidOfUser);
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }

  void openCheckout() async {
    var options = {
      'key': 'rzp_test_A4kztyzrYRBwyp',
      'amount': amount * 100,
      'name': 'K.Prakash_Bharat_Pharma',
      'description': 'Test Payment',
      'prefill': {
        'contact': '9823862448',
        'email': 'test@example.com',
      },
      'theme': {'color': '#F37254'},
      'external': {
        'wallets': ['paytm'],
      },
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error opening payment: $e")),
      );
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    Fluttertoast.showToast(
      msg: "Payment Success: ${response.paymentId}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 20.0,
    );

    // Save the order to Firestore after successful payment
    try {
      if (uid1 == null) return;

      // Save to 'orders' collection (for MyOrders screen)
      await db.addToOrders(
        uid1!,
        {
          'name': widget.name,
          'price': widget.price,
          'imageUrl': widget.imageUrl.first,
          'orderDate': DateTime.now().toString(),
          'quantity': currentQuantitySelected,
          'multiplier': currentMultiplierSelected,
          'status': 'Active',
        },
      );

      // Save to 'store_orders' collection (for additional tracking)
      await db.addToStoreOrders(
        uid1!,
        widget.uidOfMedicine,
        widget.name,
        amount.toString(),
        currentQuantitySelected,
        currentMultiplierSelected,
        widget.category,
        widget.imageUrl.first,
        widget.description,
      );

      // Remove only the purchased tablet from the cart
      await db.removeFromCart(uid1!, widget.uidOfMedicine);

      // Navigate back to ViewCart after successful payment
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => ViewCart()),
      );
    } catch (e) {
      print("Error saving order: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error saving order: $e")),
      );
    }
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "Error occurred: ${response.code} ${response.message}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.redAccent[100],
      textColor: Colors.white,
      fontSize: 20.0,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "External Wallet: ${response.walletName}",
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: Colors.white,
      textColor: Colors.black,
      fontSize: 20.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 50,
        title: Text(
          "Buy Medicine",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                elevation: 5,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      widget.imageUrl.isNotEmpty
                          ? Image.asset(
                        widget.imageUrl.first,
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      )
                          : Image.asset(
                        'assets/images/placeholder.png',
                        fit: BoxFit.cover,
                        height: 200,
                        width: double.infinity,
                      ),
                      SizedBox(height: 10),
                      Text(widget.name,
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Price: ₹${widget.price}",
                          style: TextStyle(fontSize: 18)),
                      SizedBox(height: 5),
                      Text("Category: ${widget.category}",
                          style: TextStyle(fontSize: 16)),
                      SizedBox(height: 20),
                      Text(
                        "Description: ${widget.description}",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              buildDropdown(
                  "Select Quantity", quantites, currentQuantitySelected,
                      (value) {
                    setState(() {
                      currentQuantitySelected = value!;
                    });
                  }),
              SizedBox(height: 10),
              buildDropdown(
                  "Select Multiplier", multiplier, currentMultiplierSelected,
                      (value) {
                    setState(() {
                      currentMultiplierSelected = value!;
                    });
                  }),
              SizedBox(height: 10),
              Text("Total: ${totalQuantity()} $typeSelected",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Text(
                  "Bill: ₹${(int.parse(totalQuantity()) * int.parse(widget.price))}",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green)),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      if (uid1 != null) {
                        db.addToCart(
                          uid1!,
                          widget.uidOfMedicine,
                          widget.name,
                          (int.parse(totalQuantity()) * int.parse(widget.price))
                              .toString(),
                          widget.imageUrl.first,
                          widget.category,
                          currentQuantitySelected,
                          currentMultiplierSelected,
                          widget.description,
                        );
                        Fluttertoast.showToast(
                          msg: "Added to Cart Successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.BOTTOM,
                          backgroundColor: Colors.green,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                      }
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ViewCart()),
                      );
                    },
                    child: Text(
                      "Add to Cart",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    ),
                    onPressed: () {
                      amount = int.parse(totalQuantity()) * int.parse(widget.price);
                      if (uid1 != null) {
                        openCheckout();
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Please log in to continue")),
                        );
                      }
                    },
                    child: Text(
                      "Make Payment",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildDropdown(String label, List<String> items, String selectedItem,
      ValueChanged<String?> onChanged) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        DropdownButton<String>(
          value: selectedItem,
          isExpanded: true,
          onChanged: onChanged,
          items: items
              .map((e) => DropdownMenuItem(child: Text(e), value: e))
              .toList(),
        ),
      ],
    );
  }
}