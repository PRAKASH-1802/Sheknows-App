import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green.shade400,
        title: Text(
          "About SheKnows",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Icon(Icons.account_circle, color: Colors.pinkAccent, size: 130, ),
              // Logo Section
              // CircleAvatar(
              //   radius: 60,
              //   backgroundImage: AssetImage("assets/images/logo.png"),
              // ),

              SizedBox(height: 15),

              // Title with Icon
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_hospital, color: Colors.green, size: 28),
                  SizedBox(width: 10),
                  Text(
                    "SheKnows",
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade700,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Information Card
              Card(
                elevation: 8,
                shadowColor: Colors.green.shade200,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    "SheKnows is an excellent healthcare platform designed to empower women by providing comprehensive information about their health and well-being. \n\n🌿 Features include:\n✅ Doctor Appointments\n✅ Pharmacy Services\n✅ Nearest Hospital Locator\n✅ Smart Chatbot for Personalized Guidance\n\nWith a secure interface and user-friendly design, SheKnows ensures easy access to reliable healthcare solutions, anytime and anywhere!!!",
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Contact Card
              Card(
                color: Colors.green.shade100,
                elevation: 5,
                shadowColor: Colors.green.shade300,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ListTile(
                  leading: Icon(Icons.phone, color: Colors.green),
                  title: Text(
                    "For further queries:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text("Email us at: sheknowsapp@gmail.com"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
