import 'package:flutter/material.dart';

class TermsAndConditionsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Terms & Conditions",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Terms & Conditions",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Welcome to SheKnows! By using our app, you agree to the following terms and conditions:",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 15),
            _buildPoint(
              "1. User Responsibilities",
              "Users must provide accurate information while registering and maintain the confidentiality of their account credentials.",
            ),
            _buildPoint(
              "2. Medical Disclaimer",
              "SheKnows offers health information, but it is not a replacement for professional medical advice. Always consult a healthcare provider for medical concerns.",
            ),
            _buildPoint(
              "3. Prohibited Activities",
              "Users are prohibited from misusing the app for fraudulent activities, spamming, or uploading harmful content.",
            ),
            _buildPoint(
              "4. Privacy Policy",
              "We value your privacy. Please review our Privacy Policy to understand how we collect, use, and protect your data.",
            ),
            _buildPoint(
              "5. Payment and Refunds",
              "All payments are processed securely. Refunds may be provided based on our refund policy guidelines.",
            ),
            _buildPoint(
              "6. Limitation of Liability",
              "We strive for app reliability, but SheKnows is not responsible for technical errors, data loss, or third-party issues.",
            ),
            _buildPoint(
              "7. Termination",
              "We reserve the right to suspend or terminate accounts found violating these terms.",
            ),
            SizedBox(height: 20),
            Divider(),
            Center(
              child: Text(
                "For queries, contact us at: sheknowsapp@gmail.com",
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPoint(String title, String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  content,
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
