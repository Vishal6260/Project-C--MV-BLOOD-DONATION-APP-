// ignore: file_names
import 'package:flutter/material.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    final List<Testimonial> testimonials = [
      Testimonial('MV Blood Donation App',
          'MV Blood Donation is a mobile application dedicated to making the process of blood donation more convenient and accessible for both donors and recipients'),
      Testimonial('Mission',
          'Our mission is to connect individuals in need of blood transfusions with willing and eligible blood donors, ultimately saving lives and making a positive impact on communities.'),
    ];

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          toolbarHeight: 70,
          backgroundColor: const Color.fromARGB(255, 200, 20, 7),
          title: const Text(
            "About Us",
            // style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
        ),
        body: Container(
            width: screenWidth,
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: testimonials.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          testimonials[index].author,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          testimonials[index].text,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}

class Testimonial {
  final String author;
  final String text;

  Testimonial(this.author, this.text);
}
