// import 'package:flutter/material.dart';
// import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/buydetails.dart';
//
// class HealthCare extends StatefulWidget {
//   @override
//   State<HealthCare> createState() => _HealthCareState();
// }
//
// class _HealthCareState extends State<HealthCare> {
//   final List<Map<String, String>> medicines = [
//     {
//       "uid": "1",
//       "name": "Paracetamol",
//       "price": "50",
//       "image": "assets/images/image.jpg",
//       "category": "Painkiller",
//       "description":
//       "Paracetamol is used to treat mild to moderate pain and to reduce fever."
//     },
//     {
//       "uid": "2",
//       "name": "Cough Syrup",
//       "price": "120",
//       "image": "assets/images/medicine2.jpg",
//       "category": "Cold & Flu",
//       "description":
//       "Cough Syrup is used to relieve cough and throat irritation."
//     },
//     {
//       "uid": "3",
//       "name": "Antibiotic",
//       "price": "150",
//       "image": "assets/images/medicine3.jpg",
//       "category": "Infection",
//       "description":
//       "Antibiotics are used to treat bacterial infections in various parts of the body."
//     },
//     {
//       "uid": "4",
//       "name": "PARACIP-500",
//       "price": "160",
//       "image": "assets/images/medicine4.jpg",
//       "category": "Supplements",
//       "description":
//       "It is effective in treating headaches, muscle pain, cold, and mild to moderate fever"
//     },
//     {
//       "uid": "5",
//       "name": "Nimowok-P",
//       "price": "120",
//       "image": "assets/images/medicine5.jpeg",
//       "category": "Supplements",
//       "description":
//       " combination of Nimesulide and Paracetamol tablets used to relieve pain, inflammation, and fever."
//     },
//     {
//       "uid": "6",
//       "name": "Ometoz D",
//       "price": "220",
//       "image": "assets/images/medicine6.jpeg",
//       "category": "Capsules",
//       "description":
//       "Omeprazole and Domperidone, used to treat acid reflux, heartburn, and related digestive issues."
//     },
//     {
//       "uid": "7",
//       "name": "M2-TONE",
//       "price": "140",
//       "image": "assets/images/medicine7.jpeg",
//       "category": "Supplements",
//       "description":
//       "Ayurvedic formulations designed to support menstrual health and regulate hormonal balance in women."
//     },
//     {
//       "uid": "8",
//       "name": "Periodaid",
//       "price": "240",
//       "image": "assets/images/medicine8.jpeg",
//       "category": "Capsules",
//       "description":
//       "Provide 12-hour relief from PMS symptoms, including cramps, hormonal imbalance, and mood swings."
//     },
//     {
//       "uid": "9",
//       "name": "VINAMRIT",
//       "price": "130",
//       "image": "assets/images/medicine9.jpeg",
//       "category": "PCOS & PCOD TABLETS",
//       "description":
//       "organic supplements that help regulate menstrual cycles, reduce androgen levels."
//     },
//     {
//       "uid": "10",
//       "name": "GyneSutra",
//       "price": "135",
//       "image": "assets/images/medicine10.jpeg",
//       "category": "PCOD Support Tablets",
//       "description":
//       "nutraceutical supplement designed to support women's well-being by managing PCOD-related issues."
//     },
//     {
//       "uid": "11",
//       "name": "HairFollic",
//       "price": "200",
//       "image": "assets/images/medicine11.jpeg",
//       "category": "Supplements",
//       "description":
//       "25 bio-nutrients, including Biotin, Selenium, and Zinc, designed to support hair growth."
//     },
//     {
//       "uid": "12",
//       "name": "SimplyHerbal",
//       "price": "5",
//       "image": "assets/images/medicine12.jpeg",
//       "category": "Capsules",
//       "description":
//       "Ayurvedic formulation designed to promote energy, boost immunity, and improve overall health"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("HealthCare Medicines",
//             style: TextStyle(fontWeight: FontWeight.bold)),
//         backgroundColor: Colors.purpleAccent.shade100,
//       ),
//       body: GridView.builder(
//         padding: EdgeInsets.all(10),
//         itemCount: medicines.length,
//         gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//           crossAxisCount: 2,
//           crossAxisSpacing: 10,
//           mainAxisSpacing: 10,
//           childAspectRatio: 0.75,
//         ),
//         itemBuilder: (context, index) {
//           return GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => BuyDetails(
//                          "uid1",
//                     medicines[index]["uid"]!, // Replace with actual user UID
//                     uidOfMedicine: medicines[index]["uid"]!,
//                     name: medicines[index]["name"]!,
//                     price: medicines[index]["price"]!,
//                     imageUrl: [medicines[index]["image"]!],
//                     category: medicines[index]["category"]!,
//                     description: medicines[index]["description"]!,   uidOfUser: '',
//
//                   ),
//                 ),
//               );
//             },
//             child: Card(
//               elevation: 5,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               child: Column(
//                 children: [
//                   Expanded(
//                     child: Image.asset(
//                       medicines[index]["image"]!,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                     child: Column(
//                       children: [
//                         Text(medicines[index]["name"]!,
//                             style: TextStyle(
//                                 fontSize: 16, fontWeight: FontWeight.bold)),
//                         Text("₹${medicines[index]["price"]}",
//                             style:
//                             TextStyle(fontSize: 14, color: Colors.green)),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
//



import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sheknows_app/Screens/DashBoard/components/ComponentHealth/buydetails.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';

class HealthCare extends StatefulWidget {
  @override
  State<HealthCare> createState() => _HealthCareState();
}

class _HealthCareState extends State<HealthCare> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? uid1;

  final List<Map<String, String>> medicines = [
    {
      "uid": "1",
      "name": "Paracetamol",
      "price": "50",
      "image": "assets/images/image.jpg",
      "category": "Painkiller",
      "description":
      "Paracetamol is used to treat mild to moderate pain and to reduce fever."
    },
    {
      "uid": "2",
      "name": "Cough Syrup",
      "price": "120",
      "image": "assets/images/medicine2.jpg",
      "category": "Cold & Flu",
      "description":
      "Cough Syrup is used to relieve cough and throat irritation."
    },
    {
      "uid": "3",
      "name": "Antibiotic",
      "price": "150",
      "image": "assets/images/medicine3.jpg",
      "category": "Infection",
      "description":
      "Antibiotics are used to treat bacterial infections in various parts of the body."
    },
    {
      "uid": "4",
      "name": "PARACIP-500",
      "price": "160",
      "image": "assets/images/medicine4.jpg",
      "category": "Supplements",
      "description":
      "It is effective in treating headaches, muscle pain, cold, and mild to moderate fever"
    },
    {
      "uid": "5",
      "name": "Nimowok-P",
      "price": "120",
      "image": "assets/images/medicine5.jpeg",
      "category": "Supplements",
      "description":
      "Combination of Nimesulide and Paracetamol tablets used to relieve pain, inflammation, and fever."
    },
    {
      "uid": "6",
      "name": "Ometoz D",
      "price": "220",
      "image": "assets/images/medicine6.jpeg",
      "category": "Capsules",
      "description":
      "Omeprazole and Domperidone, used to treat acid reflux, heartburn, and related digestive issues."
    },
    {
      "uid": "7",
      "name": "M2-TONE",
      "price": "10",
      "image": "assets/images/medicine7.jpeg",
      "category": "Supplements",
      "description":
      "Ayurvedic formulations designed to support menstrual health and regulate hormonal balance in women."
    },
    {
      "uid": "8",
      "name": "Periodaid",
      "price": "240",
      "image": "assets/images/medicine8.jpeg",
      "category": "Capsules",
      "description":
      "Provide 12-hour relief from PMS symptoms, including cramps, hormonal imbalance, and mood swings."
    },
    {
      "uid": "9",
      "name": "VINAMRIT",
      "price": "130",
      "image": "assets/images/medicine9.jpeg",
      "category": "PCOS & PCOD TABLETS",
      "description":
      "Organic supplements that help regulate menstrual cycles, reduce androgen levels."
    },
    {
      "uid": "10",
      "name": "GyneSutra",
      "price": "135",
      "image": "assets/images/medicine10.jpeg",
      "category": "PCOD Support Tablets",
      "description":
      "Nutraceutical supplement designed to support women's well-being by managing PCOD-related issues."
    },
    {
      "uid": "11",
      "name": "HairFollic",
      "price": "200",
      "image": "assets/images/medicine11.jpeg",
      "category": "Supplements",
      "description":
      "25 bio-nutrients, including Biotin, Selenium, and Zinc, designed to support hair growth."
    },
    {
      "uid": "12",
      "name": "SimplyHerbal",
      "price": "5",
      "image": "assets/images/medicine12.jpeg",
      "category": "Capsules",
      "description":
      "Ayurvedic formulation designed to promote energy, boost immunity, and improve overall health"
    },
  ];

  @override
  void initState() {
    super.initState();
    User? user = auth.currentUser;
    if (user != null) {
      uid1 = user.uid;
    }
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
        onWillPop: () async {
          // Navigate to DashBoard when the back button is pressed
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => Home(email: '',)),
          );
          return false; // Prevent default back button behavior
        },

      child: Scaffold(
        appBar: AppBar(
          title: Text("HealthCare Medicines",
              style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.purpleAccent.shade100,
        ),
        body: GridView.builder(
          padding: EdgeInsets.all(10),
          itemCount: medicines.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.75,
          ),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (uid1 == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Please log in to continue")),
                  );
                  return;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BuyDetails(
                      uidOfUser: uid1!, // Use the actual user UID
                      uidOfMedicine: medicines[index]["uid"]!,
                      name: medicines[index]["name"]!,
                      price: medicines[index]["price"]!,
                      imageUrl: [medicines[index]["image"]!],
                      category: medicines[index]["category"]!,
                      description: medicines[index]["description"]!,
                    ),
                  ),
                );
              },
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        medicines[index]["image"]!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text(medicines[index]["name"]!,
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold)),
                          Text("₹${medicines[index]["price"]}",
                              style:
                              TextStyle(fontSize: 14, color: Colors.green)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}