import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sheknows_app/Screens/DashBoard/home.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Image Slider ke liye images
  List<String> images = [
    "assets/images/P1.png",
    "assets/images/P2.png",
    "assets/images/P3.png",
    "assets/images/P4.png",
    "assets/images/P5.png",
  ];

  // GridView ke liye images
  List<String> gridImages = [
    "assets/images/H1.jpeg",
    "assets/images/H2.jpeg",
    "assets/images/H3.jpeg",
    "assets/images/H4.jpeg",
    "assets/images/H5.jpeg",
    "assets/images/H6.jpeg",
    "assets/images/H7.jpeg",
    "assets/images/H8.jpeg",
    "assets/images/H9.jpeg",
    "assets/images/H10.jpeg",
    "assets/images/H11.jpeg",
    "assets/images/H12.jpeg",
    "assets/images/H13.jpeg",
    "assets/images/H14.jpeg",

  ];

  List<String> descriptions = [
    "Breast Cancer: Early detection is important for successful treatment.",
    "PCOS: A hormonal disorder causing irregular periods and weight gain.",
    "Endometriosis: A condition where tissue grows outside the uterus.",
    "Osteoporosis: Weak bones due to low calcium levels.",
    "Menstrual Cramps: Severe pain during periods due to muscle contractions.",
    "Mental Health: Depression and anxiety are common in women.",
    "Promotes Menstrual Awareness – Encourages open discussions about periods. Breaks Social Stigma – Helps normalize menstruation in society.Supports Women's Dignity – Emphasizes respect and hygiene.Encourages Period Positivity – Promotes self-confidence among women.Advocates for Better Hygiene – Highlights the need for sanitary products.Inspires Social Change – Helps drive policies for menstrual health.Empowers Women – Encourages equal rights and awareness.",
    "The image Menopause Bingo shows common symptoms that many women experience during menopause. It includes chin hair, crying for no reason, mood swings, low sex drive, tiredness, headaches, hair loss, hot flashes, dry skin, anxiety, slow metabolism, and trouble sleeping (insomnia). Each symptom is shown with a simple picture, making it easy to understand. The bingo format makes it a lighthearted way to talk about menopause while also showing the real challenges women go through. The image helps raise awareness and reminds women that these changes are normal. It also highlights the importance of self-care, support from others, and getting medical advice if needed.",
    "The image shows how estrogen hormone levels change as a woman ages. At age 20-35, estrogen levels are high, helping with body functions like menstruation, fertility, and skin health. From age 40-50, estrogen levels start to drop as menopause approaches. At age 50, menopause occurs, leading to a big decrease in estrogen. After age 50 (60-80), estrogen levels stay very low, which can cause symptoms like dry skin, weaker bones, and mood changes.",
    "The image explains the causes and symptoms of late periods in a simple way.",
    "The image explains the difference between PCOS (Polycystic Ovary Syndrome) and PCOD (Polycystic Ovary Disease).",
    "Breast Cancer = Most common cancer in women worldwide. Early detection through self-exams and mammograms is crucial. Risk factors: Genetics, age, lifestyle, and hormonal imbalances. Cervical Cancer Caused by the Human Papillomavirus (HPV). 7 women die from it daily (as per the image reference).Preventable through HPV vaccination and regular Pap smears.VaginitisInflammation of the vagina due to infection or hormonal imbalance.Caused by bacteria, yeast, viruses, or reduced lactobacillus.Symptoms: Itching, abnormal discharge, and irritation.Ovarian CystFluid-filled sacs on ovaries, common in women.Linked to hormonal imbalances and Polycystic Ovary Syndrome (PCOS).Ovarian CancerCommon in women aged 40-60 years Symptoms: Bloating, pelvic pain, and difficulty eating. Early detection is difficult, so regular checkups are important.",
    "1️⃣ Irregular Periods – Skipped, heavy, or painful periods (PCOS, hormonal imbalance).2️⃣ Pelvic Pain – Chronic lower abdomen pain (Fibroids, Endometriosis).3️⃣ Unusual Discharge – Foul-smelling or excessive discharge (Infections, STDs).4️⃣ Pain During Intercourse – Discomfort or pain (Endometriosis, Infections).5️⃣ Frequent Urinary Issues – Urgency, pain, or burning (UTI, reproductive issues).6️⃣ Unexplained Infertility – Difficulty conceiving (PCOS, hormonal imbalance).7️⃣ Abnormal Lumps – Lumps in pelvic or breast area (Cysts, Fibroids, Cancer).",
    " Common STDs/STIs: 1️⃣ Syphilis – Sores, rash, organ damage if untreated.2️⃣ Hepatitis B – Liver infection, can lead to liver failure.3️⃣ HPV (Human Papillomavirus) – Warts, cervical cancer risk.4️⃣ Gonorrhea – Painful urination, reproductive issues.5️⃣ HIV (Human Immunodeficiency Virus) – Weakens immunity, leads to AIDS.",
  ];

  int currentIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startImageRotation();
  }

  void _startImageRotation() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (mounted) {
        setState(() {
          currentIndex = (currentIndex + 1) % images.length;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  // Function: Image Tap Karne Par Full-Screen Show Karega
  void _showFullScreenImage(
      BuildContext context, String imagePath, String description) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(imagePath, fit: BoxFit.contain),
              ),
              Container(
                padding: EdgeInsets.all(15),
                height: 200, // Scroll ke liye fixed height de rha hain
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        description,
                        style: TextStyle(fontSize: 16, color: Colors.black87),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 10),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child:
                              Text("Close", style: TextStyle(color: Colors.blue)),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 20,
          // title: Text('SheKnows' ,style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.white,
        ),
        drawer: Drawer(),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 5,
                  right: 5,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  child: AnimatedSwitcher(
                    duration: Duration(seconds: 1),
                    child: Image.asset(
                      images[currentIndex],
                      key: ValueKey<String>(images[currentIndex]),
                      width: 500,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                "Information on women's diseases",
                style: TextStyle(
                    color: Colors.black45,
                    fontSize: 25,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 15,
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: GridView.builder(
                      shrinkWrap: true, // GridView ki height ko restrict karega
                      physics:
                          NeverScrollableScrollPhysics(), // parent scroll view use karega
                      itemCount: gridImages.length, // Total images
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, //2 images per row
                        crossAxisSpacing: 13, //Horizontal spacing
                        mainAxisSpacing: 13, //Vertical spacing
                        childAspectRatio: 1.2, // Adjust height-width ratio
                      ),

                      itemBuilder: (context, index) {
                        // Ensure we don't go out of bounds
                        String description = (index < descriptions.length)
                            ? descriptions[index]
                            : "No description available"; // Fallback text

                        return GestureDetector(
                          onTap: () => _showFullScreenImage(context, gridImages[index], description),
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 4,
                                  spreadRadius: 0.0,
                                  offset: Offset(3.0, 3.0),
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                image: AssetImage(gridImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },

                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
