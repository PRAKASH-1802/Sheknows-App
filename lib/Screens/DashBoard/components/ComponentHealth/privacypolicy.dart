import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        backgroundColor: Colors.green.shade400,
        title: Text(
          "Privacy & Policy",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Heading
            Text(
              "Sheknows Privacy Policy",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade700,
              ),
            ),
            SizedBox(height: 10),

            // Introduction
            Text(
              "At SheKnows, we value your privacy and are committed to ensuring the safety of your personal information. This policy outlines how we collect, use, and protect your data.",
              style: TextStyle(fontSize: 16),
            ),

            SizedBox(height: 20),

            // Information Collection
            _buildSection(
              title: "1. Information We Collect",
              content: """
- Personal details like name, email, and contact number for account creation.
- Health-related data provided by users to improve services.
- Device information such as IP address and app usage for better functionality.
""",
            ),

            // Data Usage
            _buildSection(
              title: "2. How We Use Your Information",
              content: """
- To provide accurate health advice and recommendations.
- To improve app features and enhance user experience.
- To send important updates or promotional content (with consent).
""",
            ),

            // Data Sharing
            _buildSection(
              title: "3. Data Sharing",
              content: """
- Your data is never shared with third parties without your consent.
- We may collaborate with trusted partners to provide better healthcare services.
""",
            ),

            // Security Measures
            _buildSection(
              title: "4. Security Measures",
              content: """
- We use encryption to safeguard your data.
- Strict access controls are implemented to ensure data protection.
""",
            ),

            // User Rights
            _buildSection(
              title: "5. Your Rights",
              content: """
- You can access, update, or delete your personal information.
- For data-related concerns, contact our support team.
""",
            ),

            SizedBox(height: 20),

            // Contact Information
            Card(
              color: Colors.green.shade100,
              elevation: 5,
              shadowColor: Colors.green.shade300,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: Icon(Icons.email, color: Colors.green),
                title: Text(
                  "For any queries:",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text("Email us at: sheknowsapp@gmail.com"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable Widget for Privacy Sections
  Widget _buildSection({required String title, required String content}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.green.shade700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            content,
            style: TextStyle(fontSize: 15, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
