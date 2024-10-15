import 'package:figma_news_app/core/constants/app_palette.dart';
import 'package:figma_news_app/core/routes/app_routes.dart';
import 'package:figma_news_app/core/utils/app_sizes.dart';
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
      bottomNavigationBar: _buildBottomNavigationBar(context),
      body: Consumer<DoctorProvider>(
        builder: (context, value, child) {
          if (value.doctors.isEmpty) {
            return const CircularProgressIndicator();
          }
          return BackgroundContainer(
            child: Column(
              children: [
                _buildHeader(context),
                const SizedBox(
                  height: AppSizes.btnVerPadding,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding:
                              const EdgeInsets.all(AppSizes.textInputRadius),
                          child: Column(
                            children: [
                              const Padding(
                                  padding:
                                      EdgeInsets.all(AppSizes.textInputRadius),
                                  child: HomeViewTitleText(
                                      titleText: AppTexts.liveDoctors)),
                              _liveDoctors(value),
                              const SizedBox(height: AppSizes.textInputRadius),
                              _buildIconRow(),
                            ],
                          ),
                        ),
                        _buildSectionWithSeeAll(
                          title: AppTexts.popularDoctor,
                          onSeeAllPressed: () {},
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSizes.textInputRadius),
                          child: _popularDoctors(value),
                        ),
                        _buildSectionWithSeeAll(
                          title: AppTexts.featureDoctor,
                          onSeeAllPressed: () {},
                        ),
                        const SizedBox(
                          height: AppSizes.textInputRadius,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: AppSizes.textInputRadius),
                          child: _featureDoctors(value),
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

  Widget _buildSectionWithSeeAll({
    required String title,
    required VoidCallback onSeeAllPressed,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  const EdgeInsets.only(left: AppSizes.onboardTitleTextSize),
              child: HomeViewTitleText(titleText: title),
            ),
            TextButton(
              onPressed: onSeeAllPressed,
              child: const Text(AppTexts.seeAll),
            ),
          ],
        ),
      ],
    );
  }
}

Row _buildIconRow() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: [
      _buildIconCard(Icons.local_hospital, Colors.blue),
      _buildIconCard(Icons.favorite, Colors.green),
      _buildIconCard(Icons.visibility, Colors.orange),
      _buildIconCard(Icons.child_care, Colors.red),
    ],
  );
}

Stack _buildHeader(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    children: [
      Container(
        width: double.infinity,
        height: AppSizes.headerHeight,
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(AppSizes.paddingMedium),
            bottomRight: Radius.circular(AppSizes.paddingMedium),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: AppSizes.homeHeight),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.textInputHorPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    AppTexts.hiHandwerker,
                    style: TextStyle(
                      color: AppPalette.whiteColor,
                      fontSize: AppSizes.textInputHorPadding,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, AppRoutes.profile);
                      },
                      child: const CircleAvatar()),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                  left: AppSizes.textInputHorPadding,
                  top: AppSizes.textInputHorPadding - AppSizes.btnVerPadding),
              child: Text(
                AppTexts.findYourDoctor,
                style: TextStyle(
                  color: AppPalette.whiteColor,
                  fontSize: AppSizes.homeTitleSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(
        top: AppSizes.searchTopSize,
        left: MediaQuery.of(context).size.width * 0.05,
        right: MediaQuery.of(context).size.width * 0.05,
        child: Container(
          height: AppSizes.searchHeightSize,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppSizes.searchBorderSize),
            boxShadow: const [
              BoxShadow(
                color: Colors.black26,
                blurRadius: AppSizes.searchBlurSize,
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
                  vertical: AppSizes.btnVerPadding,
                  horizontal: AppSizes.textInputRadius),
              suffixIcon: Icon(Icons.close),
            ),
          ),
        ),
      ),
    ],
  );
}

ClipRRect _buildBottomNavigationBar(BuildContext context) {
  return ClipRRect(
    borderRadius: const BorderRadius.vertical(
        top: Radius.circular(AppSizes.paddingMedium)),
    child: BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Icon(
            Icons.home,
            color: Colors.green,
            size: AppSizes.iconActiveSize,
          ),
          const Icon(
            Icons.favorite,
            color: Colors.grey,
            size: AppSizes.iconInactiveSize,
          ),
          const Icon(
            Icons.book,
            color: Colors.grey,
            size: AppSizes.iconInactiveSize,
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            color: Colors.grey,
            iconSize: AppSizes.iconInactiveSize,
            onPressed: () async {
              await Provider.of<DoctorProvider>(context, listen: false)
                  .logout(context);
            },
          ),
        ],
      ),
    ),
  );
}

SizedBox _featureDoctors(DoctorProvider value) {
  return SizedBox(
    height: AppSizes.featureDoctorSize,
    child: ListView.builder(
      itemCount: value.doctors.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        final doctor = value.doctors[index];

        return Container(
          width: AppSizes.featureDoctorContainerSize,
          margin: const EdgeInsets.symmetric(
              horizontal: AppSizes.featureDoctorContainerMarginHorSize),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                AppSizes.featureDoctorContainerBorderSize),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: AppSizes.featureDoctorContainerBlurSize,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.featureDoctorContainerMarginHorSize),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Provider.of<DoctorProvider>(context, listen: false)
                            .toggleFavoriteDoctor(doctor);
                      },
                      child: Icon(
                        Icons.favorite,
                        color:
                            value.isFavorite(doctor) ? Colors.red : Colors.grey,
                        size: AppSizes.textInputHorPadding,
                      ),
                    ),
                    Text(
                      "⭐ ${doctor.rating}",
                      style: const TextStyle(
                        fontSize: AppSizes.btnVerPadding,
                        color: Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundImage: NetworkImage(doctor.imageUrl),
                radius: AppSizes.featureDoctorCircleAvatarSize,
              ),
              const SizedBox(height: AppSizes.paddingLow),
              Text(
                doctor.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: AppSizes.featureDoctorMinSize),
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
  );
}

SizedBox _popularDoctors(DoctorProvider value) {
  return SizedBox(
    height: AppSizes.popularDoctorSize,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: value.popularDoctors.length,
      itemBuilder: (context, index) {
        final popularDoctor = value.popularDoctors[index];
        return Container(
          width: AppSizes.popularDoctorContainerSize,
          margin: const EdgeInsets.symmetric(
              vertical: AppSizes.featureDoctorContainerMarginHorSize,
              horizontal: AppSizes.featureDoctorContainerMarginHorSize),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(
                AppSizes.featureDoctorContainerBorderSize),
            boxShadow: const [
              BoxShadow(
                color: Colors.black12,
                blurRadius: AppSizes.featureDoctorContainerBlurSize,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(
                          AppSizes.featureDoctorContainerBorderSize)),
                  child: Image.network(
                    popularDoctor.imageUrl,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(
                    AppSizes.featureDoctorContainerMarginHorSize),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      popularDoctor.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppSizes.featureDoctorMinSize),
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
  );
}

SizedBox _liveDoctors(DoctorProvider value) {
  return SizedBox(
    height: AppSizes.liveDoctorSize,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: value.liveDoctors.length,
      itemBuilder: (context, index) {
        final liveDoctor = value.liveDoctors[index];
        return Stack(
          children: [
            Container(
              width: AppSizes.popularDoctorContainerSize,
              margin: const EdgeInsets.symmetric(
                  horizontal: AppSizes.featureDoctorContainerMarginHorSize,
                  vertical: AppSizes.featureDoctorContainerMarginHorSize),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    AppSizes.featureDoctorContainerBorderSize),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: AppSizes.featureDoctorContainerBlurSize,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(
                            AppSizes.featureDoctorContainerBorderSize),
                      ),
                      child: Image.network(
                        liveDoctor.imageUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(
                        AppSizes.featureDoctorContainerMarginHorSize),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          liveDoctor.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: AppSizes.featureDoctorMinSize),
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
            ),
            Positioned(
              top: AppSizes.liveTextTopLeftSize,
              left: AppSizes.liveTextTopLeftSize,
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.featureDoctorContainerMarginHorSize,
                    vertical: AppSizes.featureDoctorMinSize),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius:
                      BorderRadius.circular(AppSizes.liveTextBorderSize),
                ),
                child: const Text(
                  AppTexts.live,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: AppSizes.privacyPolicyTextSizes,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    ),
  );
}

Widget _buildIconCard(IconData icon, Color color) {
  return Container(
    width: AppSizes.iconCardWidthHeightSize,
    height: AppSizes.iconCardWidthHeightSize,
    decoration: BoxDecoration(
      color: color,
      borderRadius:
          BorderRadius.circular(AppSizes.featureDoctorContainerBorderSize),
      boxShadow: const [
        BoxShadow(
          color: Colors.black12,
          blurRadius: AppSizes.featureDoctorContainerBlurSize,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: Icon(icon, color: Colors.white, size: AppSizes.iconActiveSize),
  );
}

class HomeViewTitleText extends StatelessWidget {
  const HomeViewTitleText({
    super.key,
    required this.titleText,
  });

  final String titleText;

  @override
  Widget build(BuildContext context) {
    return Text(
      titleText,
      style: const TextStyle(
        fontSize: AppSizes.splashTitleTextSize,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
