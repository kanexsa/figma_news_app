import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/widgets/background_container.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundContainer(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.infinity,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Hi Handwerker!",
                              style: TextStyle(
                                color: AppPalette.whiteColor,
                                fontSize: 20,
                              ),
                            ),
                            CircleAvatar(),
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 20.0, top: 8.0),
                        child: Text(
                          "Find Your Doctor!",
                          style: TextStyle(
                            color: AppPalette.whiteColor,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top:
                      140, // Adjust this value to position the TextField correctly
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                  child: Container(
                    height: 48,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25.0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 4.0,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search...',
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 16.0),
                        suffixIcon: Icon(Icons.close),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // Eklemek istediğiniz diğer öğeler buraya
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          const Text("Live Doctors",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          // Diğer öğeler
                          Container(
                            height: 150,
                            color: Colors.blue,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(child: Text('Doctor 1')),
                          ),
                          Container(
                            height: 150,
                            color: Colors.red,
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: const Center(child: Text('Doctor 2')),
                          ),
                          // Devam eden diğer öğeler
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
