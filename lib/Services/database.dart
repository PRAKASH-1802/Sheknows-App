import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseService {
  final String uid;
  DatabaseService({required this.uid});

  // Collection references
  final CollectionReference categoryCollection =
      FirebaseFirestore.instance.collection('category');
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference suggestionsCollection =
      FirebaseFirestore.instance.collection('suggestions');

  Future updateUserData(String name, email) async {
    return await usersCollection.doc(uid).set({
      'name': name,
      'email': email,
      'uid': uid,
    });
  }

  // Get category stream
  Stream<QuerySnapshot> get categories {
    return categoryCollection.snapshots();
  }

  Future addToCart(
      String uidOfUser,
      String uidOfMedicine,
      String name,
      String price,
      String imageUrl,
      String category,
      String quantity,
      String multiplier,
      String description) async {
    try {
      return await usersCollection
          .doc(uidOfUser)
          .collection('cart')
          .doc(uidOfMedicine)
          .set({
        'uid': uidOfMedicine,
        'name': name,
        'price': price,
        'imageUrl': imageUrl,
        'category': category,
        'quantity': quantity,
        'multiplier': multiplier,
        'description': description,
      });
    } catch (e) {
      return null;
    }
  }

  // Add Medicine to Orders
  Future<void> addToOrders(String userId,  Map<String, dynamic> orderData) async {

    // if (uid == null || uid.isEmpty) {
    //   print("Error: UID is null or empty!");
    //   return;
    // }
    // await FirebaseFirestore.instance
    //     .collection('users')
    //     .doc(uid)
    //     .collection('orders')
    //     .add(orderData);

    try {
      await usersCollection.doc(userId).collection('orders').add({
        ...orderData,
        'timestamp': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      print("Error adding to orders: $e");
      throw e;
    }
  }

  // Get Orders
  // Future<List<Map<String, dynamic>>> getOrders() async {
  //   QuerySnapshot snapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(uid)
  //       .collection('orders')
  //       .get();
  //
  //   return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  // }

  Future<List<Map<String, dynamic>>> getOrders() async {
    try {
      QuerySnapshot querySnapshot =
      await usersCollection.doc(uid).collection('orders').get();
      return querySnapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        return {
          'name': data['name'] ?? '',
          'price': data['price']?.toString() ?? '',
          'imageUrl': data['imageUrl'] ?? '',
          'orderDate': data['orderDate']?.toString() ?? '',
          'quantity': data['quantity'] ?? '',
          'multiplier': data['multiplier'] ?? '',
        };
      }).toList();
    } catch (e) {
      print("Error fetching orders: $e");
      throw e;
    }
  }

  Future addToOutOfStoreOrders(String uidOfUser, String name, String suffer,
      String quantity, String multiplier) async {
    print("uid in database " + uidOfUser);
    try {
      return await usersCollection
          .doc(uidOfUser)
          .collection('out-of-store-orders')
          .doc()
          .set({
        'name': name,
        'suffering': suffer,
        'quantity': quantity,
        'multiplier': multiplier,
        'status': 'ACTIVE',
        'bill': 'YET TO BE CONVEYED'
      });
    } catch (e) {
      return null;
    }
  }

  Future addToStoreOrders(
      String uidOfUser,
      String uidOfMedicine,
      String name,
      String bill,
      String quantity,
      String multiplier,
      String category,
      String imageUrl,
      String description) async {
    try {
      return await usersCollection
          .doc(uidOfUser)
          .collection('in-store-orders')
          .doc(uidOfMedicine)
          .set({
        'name': name,
        'imageUrl': imageUrl,
        'bill': bill,
        'quantity': quantity,
        'multiplier': multiplier,
        'category': category,
        'status': 'ACTIVE',
      });
    } catch (e) {
      return null;
    }
  }

  Future addSuggestion(String sugg, String uid) async {
    print("KKK" + uid);
    try {
      return await suggestionsCollection.doc().set({
        'suggestion': sugg,
        'useruid': uid,
      });
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  FirebaseAuth auth = FirebaseAuth.instance;
  String? uid1;

  Future<void> uidOfUser() async {
    final user = auth.currentUser;
    if (user != null) {
      uid1 = user.uid;
    }
  }

  Future getEmail() async {
    await uidOfUser();
    if (uid1 != null) {
      await usersCollection.where('uid', isEqualTo: uid1).get();
    }
  }

  Future removeFromCart(String uid, String itemUid) async {
    try {
      return await usersCollection
          .doc(uid)
          .collection("cart")
          .doc(itemUid)
          .delete();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Clear the cart after purchase (used in BuyDetails)
  // Future<void> clearCart() async {
  //   try {
  //     // Get all documents in the cart subcollection for the current user
  //     QuerySnapshot querySnapshot =
  //     await usersCollection.doc(uid).collection('cart').get();
  //
  //     // Delete each document in the cart subcollection
  //     for (var doc in querySnapshot.docs) {
  //       await doc.reference.delete();
  //     }
  //   } catch (e) {
  //     print("Error clearing cart: $e");
  //     throw e;
  //   }
  // }
}
