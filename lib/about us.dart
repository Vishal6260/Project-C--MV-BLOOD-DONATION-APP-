// ignore: file_names
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = TextStyle(
        fontSize: 30,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w800);

    TextStyle paraStyle = TextStyle(
        fontSize: 20,
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w400);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        toolbarHeight: 70,
        backgroundColor: const Color.fromARGB(255, 200, 20, 7),
        title: const Text(
          "About Us",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "About",
              style: titleStyle,
            ),
            Text(
              "MV Blood Donation is a mobile application dedicated to making the process of blood donation more convenient and accessible for both donors and recipients",
              style: paraStyle,
            ),
            const SizedBox(height: 35),
            Text(
              "Mission",
              style: titleStyle,
            ),
            Text(
              "Our mission is to connect individuals in need of blood transfusions with willing and eligible blood donors, ultimately saving lives and making a positive impact on communities.",
              style: paraStyle,
            ),
            const SizedBox(height: 35),
            Text(
              "Contact",
              style: titleStyle,
            ),
            const SizedBox(height: 9),
            Text(
              "Vision Developers",
              style: paraStyle,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Column(
                  children: [
                    Text("Email", style: paraStyle),
                    const SizedBox(height: 15),
                    Text("Phone", style: paraStyle),
                  ],
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("visiondevelopers@gmail.com", style: paraStyle),
                    const SizedBox(height: 15),
                    Text("54698541", style: paraStyle),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
