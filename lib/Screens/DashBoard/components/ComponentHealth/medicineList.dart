// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/buydetails.dart';
// import 'package:sheknows_app/Services/database.dart';
//
// class MedicinesList extends StatefulWidget {
//   final String categoryName;
//
//   MedicinesList(this.categoryName);
//
//   @override
//   _MedicinesListState createState() => _MedicinesListState();
// }
//
// class _MedicinesListState extends State<MedicinesList> {
//   FirebaseAuth auth = FirebaseAuth.instance;
//   late String uid1;
//
//   List<String> medicinesName = [];
//   List<String> medicinesPrice = [];
//   List<String> medicinesImageUrl = [];
//   List<String> medicinesCategory = [];
//   List<String> medicinesUid = [];
//
//   void uidOfUser() async {
//     User? user = auth.currentUser;
//     if (user != null) {
//       uid1 = user.uid;
//     }
//   }
//
//   //function for searching data
//   DataSearch(
//       List<String> medicinesName,
//       List<String> medicinesPrice,
//       List<String> medicinesCategory,
//       List<String> medicinesImageUrl,
//       List<String> medicinesUid) {}
//
//
//   Future getMedicines() async {
//     print("category uid: ${widget.categoryName}");
//     var firestore = FirebaseFirestore.instance;
//     QuerySnapshot qn = await firestore
//         .collection("medicines")
//         .where('category', isEqualTo: widget.categoryName)
//         .get();
//     return qn.docs;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         actions: [
//           IconButton(
//             icon: Icon(Icons.search),
//             onPressed: () {
//               showSearch(
//                   context: context,
//                   delegate: DataSearch(medicinesName, medicinesPrice,
//                       medicinesCategory, medicinesImageUrl, medicinesUid));
//             },
//           )
//         ],
//         elevation: 50,
//         title: Text(
//           "Choose Medicine",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: FutureBuilder(
//         future: getMedicines(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return Center(child: CircularProgressIndicator());
//           }
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(child: Text("No Medicines Available"));
//           }
//           var data = snapshot.data as List<QueryDocumentSnapshot>;
//           return ListView.builder(
//             itemCount: data.length,
//             itemBuilder: (context, index) {
//               var doc = data[index].data() as Map<String, dynamic>;
//               medicinesName.add(doc['name']);
//               medicinesPrice.add(doc['price']);
//               medicinesUid.add(doc['uid']);
//               medicinesImageUrl.add(doc['imageUrl']);
//               medicinesCategory.add(doc['category']);
//
//               return GestureDetector(
//                 onTap: () {
//                   Navigator.of(context)
//                       .push(MaterialPageRoute(builder: (context) {
//                     return BuyDetails(uid1, doc['uid'], doc['name'],
//                         doc['price'], doc['imageUrl'], doc['category']);
//                   }));
//                 },
//                 child: Card(
//                   margin: EdgeInsets.all(15.0),
//                   elevation: 15.0,
//                   shape: RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.white70, width: 1),
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Image.network(
//                             doc['imageUrl'],
//                             width: 200,
//                             height: 200,
//                           ),
//                           SizedBox(width: 50),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "NAME: ${doc['name']}",
//                                 style: TextStyle(
//                                     fontSize: 24.0,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.black),
//                               ),
//                               SizedBox(height: 10),
//                               Text(
//                                 "PRICE: ₹${doc['price']}",
//                                 style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.w700,
//                                     color: Colors.black),
//                               )
//                             ],
//                           )
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           ElevatedButton.icon(
//                             onPressed: () async {
//                               User? user = auth.currentUser;
//                               if (user != null) {
//                                 uid1 = user.uid;
//                                 DatabaseService db = DatabaseService(uid: '');
//                                 var result = await db.addToCart(
//                                     uid1,
//                                     doc['uid'],
//                                     doc['name'],
//                                     doc['price'],
//                                     doc['imageUrl'],
//                                     doc['category']);
//
//                                 if (result == null) {
//                                   Fluttertoast.showToast(
//                                       msg:
//                                           "Error in adding to cart..Try Again!!",
//                                       toastLength: Toast.LENGTH_LONG,
//                                       gravity: ToastGravity.BOTTOM,
//                                       backgroundColor: Colors.redAccent[100],
//                                       textColor: Colors.white,
//                                       fontSize: 16.0);
//                                 } else {
//                                   Fluttertoast.showToast(
//                                       msg: "Added to Cart",
//                                       toastLength: Toast.LENGTH_LONG,
//                                       gravity: ToastGravity.BOTTOM,
//                                       backgroundColor: Colors.green,
//                                       textColor: Colors.white,
//                                       fontSize: 16.0);
//                                 }
//                               }
//                             },
//                             icon:
//                                 Icon(Icons.shopping_cart, color: Colors.white),
//                             label: Text('Add to Cart'),
//                           ),
//                           SizedBox(width: 20),
//                           ElevatedButton.icon(
//                             onPressed: () {
//                               Navigator.of(context)
//                                   .push(MaterialPageRoute(builder: (context) {
//                                 return BuyDetails(
//                                     uid1,
//                                     doc['uid'],
//                                     doc['name'],
//                                     doc['price'],
//                                     doc['imageUrl'],
//                                     doc['category'],
//                                    );
//                               }));
//                             },
//                             icon: Icon(Icons.shopping_basket,
//                                 color: Colors.white),
//                             label: Text('Buy Now'),
//                           ),
//                         ],
//                       ),
//                       SizedBox(height: 10),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
//
