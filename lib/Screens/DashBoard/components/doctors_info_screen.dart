import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';

class DoctorInfoScreen extends StatefulWidget {
  @override
  _DoctorInfoScreenState createState() => _DoctorInfoScreenState();
}

class _DoctorInfoScreenState extends State<DoctorInfoScreen> {
  final List<Map<String, String>> doctorsData = [
    // Cardiologists
    {
      'Doctor Name': 'Dr. Abhijeet Patil',
      'Degree': 'MBBS, MD (Cardiology)',
      'Specialist': 'Cardiologist',
      'Address': 'Heart Care Clinic, Mumbai',
      'Phone Number': '+91 9876543210',
    },
    {
      'Doctor Name': 'Dr. Snehal Deshmukh',
      'Degree': 'MBBS, DM (Cardiology)',
      'Specialist': 'Cardiologist',
      'Address': 'Pulse Heart Center, Pune',
      'Phone Number': '+91 9876543211',
    },

    // Gynecologists
    {
      'Doctor Name': 'Dr. Anjali Sharma',
      'Degree': 'MBBS, MD (Gynecology)',
      'Specialist': 'Gynecologist',
      'Address': 'Mother Care Hospital, Nashik',
      'Phone Number': '+91 9876543212',
    },
    {
      'Doctor Name': 'Dr. Seema Pawar',
      'Degree': 'MBBS, DGO',
      'Specialist': 'Gynecologist',
      'Address': 'Women’s Health Clinic, Kolhapur',
      'Phone Number': '+91 9876543213',
    },

    // Orthopedic Surgeons
    {
      'Doctor Name': 'Dr. Rajesh Kulkarni',
      'Degree': 'MBBS, MS (Orthopedics)',
      'Specialist': 'Orthopedic Surgeon',
      'Address': 'Bone & Joint Care, Aurangabad',
      'Phone Number': '+91 9876543214',
    },
    {
      'Doctor Name': 'Dr. Prakash Jadhav',
      'Degree': 'MBBS, MS (Orthopedics)',
      'Specialist': 'Orthopedic Surgeon',
      'Address': 'Ortho Care Clinic, Nagpur',
      'Phone Number': '+91 9876543215',
    },

    // Dermatologists
    {
      'Doctor Name': 'Dr. Priya Joshi',
      'Degree': 'MBBS, MD (Dermatology)',
      'Specialist': 'Dermatologist',
      'Address': 'SkinGlow Clinic, Mumbai',
      'Phone Number': '+91 9876543216',
    },
    {
      'Doctor Name': 'Dr. Neha Sawant',
      'Degree': 'MBBS, MD (Dermatology)',
      'Specialist': 'Dermatologist',
      'Address': 'ClearSkin Center, Pune',
      'Phone Number': '+91 9876543217',
    },

    // Pediatricians
    {
      'Doctor Name': 'Dr. Vishal Patil',
      'Degree': 'MBBS, MD (Pediatrics)',
      'Specialist': 'Pediatrician',
      'Address': 'Child Care Hospital, Mumbai',
      'Phone Number': '+91 9876543218',
    },
    {
      'Doctor Name': 'Dr. Ruchi Desai',
      'Degree': 'MBBS, DCH (Pediatrics)',
      'Specialist': 'Pediatrician',
      'Address': 'Kids Health Clinic, Pune',
      'Phone Number': '+91 9876543219',
    },

    // Neurologists
    {
      'Doctor Name': 'Dr. Harish More',
      'Degree': 'MBBS, DM (Neurology)',
      'Specialist': 'Neurologist',
      'Address': 'Neuro Care Center, Mumbai',
      'Phone Number': '+91 9876543220',
    },
    {
      'Doctor Name': 'Dr. Sangeeta Deshpande',
      'Degree': 'MBBS, MD (Neurology)',
      'Specialist': 'Neurologist',
      'Address': 'Brain Wellness Clinic, Pune',
      'Phone Number': '+91 9876543221',
    },

    // Dentists
    {
      'Doctor Name': 'Dr. Anil Shinde',
      'Degree': 'BDS, MDS (Dentistry)',
      'Specialist': 'Dentist',
      'Address': 'Smile Dental Clinic, Nagpur',
      'Phone Number': '+91 9876543222',
    },
    {
      'Doctor Name': 'Dr. Kavita Kadam',
      'Degree': 'BDS, MDS (Oral Surgery)',
      'Specialist': 'Dentist',
      'Address': 'Bright Smile Dental Care, Aurangabad',
      'Phone Number': '+91 9876543223',
    },

    // ENT Specialists
    {
      'Doctor Name': 'Dr. Manish Pawar',
      'Degree': 'MBBS, MS (ENT)',
      'Specialist': 'ENT Specialist',
      'Address': 'Ear Nose Throat Clinic, Pune',
      'Phone Number': '+91 9876543224',
    },
    {
      'Doctor Name': 'Dr. Aruna Patil',
      'Degree': 'MBBS, MS (ENT)',
      'Specialist': 'ENT Specialist',
      'Address': 'ENT Health Care, Mumbai',
      'Phone Number': '+91 9876543225',
    },

    // Oncologists
    {
      'Doctor Name': 'Dr. Vinay Kulkarni',
      'Degree': 'MBBS, DM (Oncology)',
      'Specialist': 'Oncologist',
      'Address': 'Cancer Care Hospital, Pune',
      'Phone Number': '+91 9876543226',
    },
    {
      'Doctor Name': 'Dr. Kavya Phadke',
      'Degree': 'MBBS, MD (Oncology)',
      'Specialist': 'Oncologist',
      'Address': 'Hope Cancer Institute, Mumbai',
      'Phone Number': '+91 9876543227',
    },

    // Psychiatrists
    {
      'Doctor Name': 'Dr. Anupam Rao',
      'Degree': 'MBBS, MD (Psychiatry)',
      'Specialist': 'Psychiatrist',
      'Address': 'Mind Wellness Center, Pune',
      'Phone Number': '+91 9876543228',
    },
    {
      'Doctor Name': 'Dr. Radhika Shinde',
      'Degree': 'MBBS, MD (Psychiatry)',
      'Specialist': 'Psychiatrist',
      'Address': 'Peace of Mind Clinic, Mumbai',
      'Phone Number': '+91 9876543229',
    },

    // General Physicians
    {
      'Doctor Name': 'Dr. Mohan Joshi',
      'Degree': 'MBBS, MD (General Medicine)',
      'Specialist': 'General Physician',
      'Address': 'Family Health Care, Nagpur',
      'Phone Number': '+91 9876543230',
    },
    {
      'Doctor Name': 'Dr. Ritu Thakur',
      'Degree': 'MBBS, MD (General Medicine)',
      'Specialist': 'General Physician',
      'Address': 'Healthy Living Clinic, Aurangabad',
      'Phone Number': '+91 9876543231',
    },
    // Cardiologists
    {
      'Doctor Name': 'Dr. A.K. Mehta',
      'Degree': 'MBBS, MD (Cardiology)',
      'Specialist': 'Cardiologist',
      'Address': 'Heart Care Clinic, Mumbai',
      'Phone Number': '+91 9876543210',
    },
    {
      'Doctor Name': 'Dr. Ramesh Gupta',
      'Degree': 'MBBS, DM (Cardiology)',
      'Specialist': 'Cardiologist',
      'Address': 'Pulse Heart Center, Delhi',
      'Phone Number': '+91 9876543211',
    },

    // Gynecologists
    {
      'Doctor Name': 'Dr. Anjali Sharma',
      'Degree': 'MBBS, MD (Gynecology)',
      'Specialist': 'Gynecologist',
      'Address': 'Mother Care Hospital, Pune',
      'Phone Number': '+91 9876543212',
    },
    {
      'Doctor Name': 'Dr. Sneha Kapoor',
      'Degree': 'MBBS, DGO',
      'Specialist': 'Gynecologist',
      'Address': 'Women’s Health Clinic, Jaipur',
      'Phone Number': '+91 9876543213',
    },

    // Orthopedic Surgeons
    {
      'Doctor Name': 'Dr. Rajesh Verma',
      'Degree': 'MBBS, MS (Orthopedics)',
      'Specialist': 'Orthopedic Surgeon',
      'Address': 'Bone & Joint Care, Bengaluru',
      'Phone Number': '+91 9876543214',
    },
    {
      'Doctor Name': 'Dr. Arvind Patil',
      'Degree': 'MBBS, MS (Orthopedics)',
      'Specialist': 'Orthopedic Surgeon',
      'Address': 'Ortho Care Clinic, Hyderabad',
      'Phone Number': '+91 9876543215',
    },

    // Dermatologists
    {
      'Doctor Name': 'Dr. Priya Singh',
      'Degree': 'MBBS, MD (Dermatology)',
      'Specialist': 'Dermatologist',
      'Address': 'SkinGlow Clinic, Chennai',
      'Phone Number': '+91 9876543216',
    },
    {
      'Doctor Name': 'Dr. Neha Joshi',
      'Degree': 'MBBS, MD (Dermatology)',
      'Specialist': 'Dermatologist',
      'Address': 'ClearSkin Center, Kolkata',
      'Phone Number': '+91 9876543217',
    },

    // Pediatricians
    {
      'Doctor Name': 'Dr. Vishal Kapoor',
      'Degree': 'MBBS, MD (Pediatrics)',
      'Specialist': 'Pediatrician',
      'Address': 'Child Care Hospital, Chandigarh',
      'Phone Number': '+91 9876543218',
    },
    {
      'Doctor Name': 'Dr. Ruchi Agarwal',
      'Degree': 'MBBS, DCH (Pediatrics)',
      'Specialist': 'Pediatrician',
      'Address': 'Kids Health Clinic, Lucknow',
      'Phone Number': '+91 9876543219',
    },

    // Neurologists
    {
      'Doctor Name': 'Dr. Harish Kumar',
      'Degree': 'MBBS, DM (Neurology)',
      'Specialist': 'Neurologist',
      'Address': 'Neuro Care Center, Delhi',
      'Phone Number': '+91 9876543220',
    },
    {
      'Doctor Name': 'Dr. Sangeeta Mehta',
      'Degree': 'MBBS, MD (Neurology)',
      'Specialist': 'Neurologist',
      'Address': 'Brain Wellness Clinic, Mumbai',
      'Phone Number': '+91 9876543221',
    },

    // Dentists
    {
      'Doctor Name': 'Dr. Anil Sinha',
      'Degree': 'BDS, MDS (Dentistry)',
      'Specialist': 'Dentist',
      'Address': 'Smile Dental Clinic, Ahmedabad',
      'Phone Number': '+91 9876543222',
    },
    {
      'Doctor Name': 'Dr. Kavita Malhotra',
      'Degree': 'BDS, MDS (Oral Surgery)',
      'Specialist': 'Dentist',
      'Address': 'Bright Smile Dental Care, Surat',
      'Phone Number': '+91 9876543223',
    },

    // ENT Specialists
    {
      'Doctor Name': 'Dr. Manish Sharma',
      'Degree': 'MBBS, MS (ENT)',
      'Specialist': 'ENT Specialist',
      'Address': 'Ear Nose Throat Clinic, Patna',
      'Phone Number': '+91 9876543224',
    },
    {
      'Doctor Name': 'Dr. Aruna Gupta',
      'Degree': 'MBBS, MS (ENT)',
      'Specialist': 'ENT Specialist',
      'Address': 'ENT Health Care, Indore',
      'Phone Number': '+91 9876543225',
    },

    // Oncologists
    {
      'Doctor Name': 'Dr. Vinay Kumar',
      'Degree': 'MBBS, DM (Oncology)',
      'Specialist': 'Oncologist',
      'Address': 'Cancer Care Hospital, Delhi',
      'Phone Number': '+91 9876543226',
    },
    {
      'Doctor Name': 'Dr. Kavya Nair',
      'Degree': 'MBBS, MD (Oncology)',
      'Specialist': 'Oncologist',
      'Address': 'Hope Cancer Institute, Bengaluru',
      'Phone Number': '+91 9876543227',
    },

    // Psychiatrists
    {
      'Doctor Name': 'Dr. Anupam Roy',
      'Degree': 'MBBS, MD (Psychiatry)',
      'Specialist': 'Psychiatrist',
      'Address': 'Mind Wellness Center, Delhi',
      'Phone Number': '+91 9876543228',
    },
    {
      'Doctor Name': 'Dr. Radhika Desai',
      'Degree': 'MBBS, MD (Psychiatry)',
      'Specialist': 'Psychiatrist',
      'Address': 'Peace of Mind Clinic, Hyderabad',
      'Phone Number': '+91 9876543229',
    },

    // General Physicians
    {
      'Doctor Name': 'Dr. Mohan Krishna',
      'Degree': 'MBBS, MD (General Medicine)',
      'Specialist': 'General Physician',
      'Address': 'Family Health Care, Pune',
      'Phone Number': '+91 9876543230',
    },
    {
      'Doctor Name': 'Dr. Ritu Kapoor',
      'Degree': 'MBBS, MD (General Medicine)',
      'Specialist': 'General Physician',
      'Address': 'Healthy Living Clinic, Chennai',
      'Phone Number': '+91 9876543231',
    },
  ];


  List<Map<String, String>> filteredDoctors = [];

  @override
  void initState() {
    super.initState();
    filteredDoctors = doctorsData; // By default, all doctors will be shown
  }

  void _searchDoctor(String query) {
    final results = doctorsData.where((doctor) {
      final doctorName = doctor['Doctor Name']!.toLowerCase();
      final specialist = doctor['Specialist']!.toLowerCase();
      final address = doctor['Address']!.toLowerCase();

      return doctorName.contains(query.toLowerCase()) ||
          specialist.contains(query.toLowerCase()) ||
          address.contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredDoctors = results;
    });
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
          automaticallyImplyLeading: false,
          title: Text(
            "Doctors Info",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          backgroundColor: Colors.lightGreenAccent.shade400,
        ),

        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                onChanged: _searchDoctor,
                decoration: InputDecoration(
                  hintText: 'Search doctors by name, specialist, or address...',
                  prefixIcon: Icon(Icons.search, color: Colors.indigo),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
            ),

            Expanded(
              child: filteredDoctors.isEmpty
                  ? Center(
                child: Text(
                  'No doctors found!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              )
                  : ListView.builder(
                itemCount: filteredDoctors.length,
                itemBuilder: (context, index) {
                  var doctor = filteredDoctors[index];
                  return Stack(
                    children: [
                      Card(
                        margin: EdgeInsets.all(12),
                        elevation: 8,
                        shadowColor: Colors.indigo.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.only(left: 20, right: 16, top: 18, bottom: 15),
                          leading: Icon(
                            LucideIcons.stethoscope,
                            size: 50,
                            color: Colors.teal[700],
                          ),
                          title: Text(
                            doctor['Doctor Name']!,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 6),
                              _buildInfoRow('Degree', doctor['Degree']!),
                              _buildInfoRow('Specialist', doctor['Specialist']!),
                              _buildInfoRow('Address', doctor['Address']!),
                              _buildInfoRow('Phone Number', doctor['Phone Number']!),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(height: 25,),
                      Positioned(
                        top: 35,
                        left: 35,
                        child: Icon(
                          Icons.account_circle,
                          size: 40,
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  );
                },
              ),
            )



          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4.0),
      child: Row(
        children: [
          Icon(Icons.arrow_right, color: Colors.indigo, size: 18),
          SizedBox(width: 6),
          Text(
            '$label: ',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 17,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.grey[900],
                fontSize: 17,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
