import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_texts.dart';
import 'package:figma_news_app/core/widgets/background_container.dart';
import 'package:figma_news_app/product/services/home/doctor_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<DoctorProvider>(context, listen: false).fetchDoctors();
    Provider.of<DoctorProvider>(context, listen: false).loadFavoriteDoctors();
    Provider.of<DoctorProvider>(context, listen: false).fetchPopularDoctors();
    Provider.of<DoctorProvider>(context, listen: false).fetchLiveDoctors();
    return Scaffold(
      bottomNavigationBar: const ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        child: BottomAppBar(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.home,
                color: Colors.green,
                size: 30, // Aktif simge boyutu
              ),
              Icon(
                Icons.favorite,
                color: Colors.grey, // Inaktif simge rengi
                size: 24, // Inaktif simge boyutu
              ),
              Icon(
                Icons.book,
                color: Colors.grey, // Inaktif simge rengi
                size: 24, // Inaktif simge boyutu
              ),
              Icon(
                Icons.message,
                color: Colors.grey, // Inaktif simge rengi
                size: 24, // Inaktif simge boyutu
              ),
            ],
          ),
        ),
      ),
      body: Consumer<DoctorProvider>(
        builder: (context, value, child) {
          if (value.doctors.isEmpty) {
            return const CircularProgressIndicator();
          }
          return BackgroundContainer(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 50),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  AppTexts.hiHandwerker,
                                  style: TextStyle(
                                    color: AppPalette.whiteColor,
                                    fontSize: 20,
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.profile);
                                    },
                                    child: const CircleAvatar()),
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20.0, top: 8.0),
                            child: Text(
                              AppTexts.findYourDoctor,
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
                      top: 140,
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
                            hintText: AppTexts.search,
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
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Text(AppTexts.liveDoctors,
                                    style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold)),
                              ),
                              SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: value.liveDoctors.length,
                                  itemBuilder: (context, index) {
                                    final liveDoctor = value.liveDoctors[index];
                                    return Container(
                                      width: 150,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 8.0, vertical: 8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black12,
                                            blurRadius: 6.0,
                                            offset: Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: ClipRRect(
                                              borderRadius: const BorderRadius
                                                  .vertical(
                                                  top: Radius.circular(15.0)),
                                              child: Image.network(
                                                'https://via.placeholder.com/150',
                                                fit: BoxFit.cover,
                                                width: double.infinity,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  liveDoctor.name,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                const SizedBox(height: 4.0),
                                                Text(
                                                  liveDoctor.specialty,
                                                  style: const TextStyle(
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(height: 16.0), // Boşluk
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildIconCard(
                                      Icons.local_hospital, Colors.blue),
                                  _buildIconCard(Icons.favorite, Colors.green),
                                  _buildIconCard(
                                      Icons.visibility, Colors.orange),
                                  _buildIconCard(Icons.child_care, Colors.red),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                AppTexts.popularDoctor,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(AppTexts.seeAll),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: value.popularDoctors.length,
                              itemBuilder: (context, index) {
                                final popularDoctor =
                                    value.popularDoctors[index];
                                return Container(
                                  width: 150,
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6.0,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ClipRRect(
                                          borderRadius:
                                              const BorderRadius.vertical(
                                                  top: Radius.circular(15.0)),
                                          child: Image.network(
                                            'https://via.placeholder.com/150',
                                            fit: BoxFit.cover,
                                            width: double.infinity,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              popularDoctor.name,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 4.0),
                                            Text(
                                              popularDoctor.specialty,
                                              style: const TextStyle(
                                                color: Colors.grey,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(left: 24.0),
                              child: Text(
                                AppTexts.featureDoctor,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              child: const Text(AppTexts.seeAll),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: SizedBox(
                            height: 120,
                            child: ListView.builder(
                              itemCount: value.doctors.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (BuildContext context, int index) {
                                final doctor = value.doctors[index];

                                return Container(
                                  width: 140,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 6,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                Provider.of<DoctorProvider>(
                                                        context,
                                                        listen: false)
                                                    .toggleFavoriteDoctor(
                                                        doctor);
                                              },
                                              child: Icon(
                                                Icons.favorite,
                                                color: value.isFavorite(doctor)
                                                    ? Colors.red
                                                    : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                            Text(
                                              "⭐ ${doctor.rating}",
                                              style: const TextStyle(
                                                fontSize: 12,
                                                color: Colors.orange,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        radius: 20,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        doctor.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4.0),
                                      Text(
                                        "\$${doctor.hourlyRate}/hr",
                                        style: const TextStyle(
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildIconCard(IconData icon, Color color) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15.0),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6.0,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Icon(icon, color: Colors.white, size: 30),
    );
  }
}
