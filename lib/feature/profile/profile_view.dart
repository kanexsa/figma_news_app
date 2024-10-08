import 'package:figma_news_app/product/services/profile/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    TextEditingController nameController =
        TextEditingController(text: profileProvider.name);
    TextEditingController phoneController =
        TextEditingController(text: profileProvider.phone);
    TextEditingController descriptionController =
        TextEditingController(text: profileProvider.description);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(radius: 50),
            const SizedBox(height: 16),
            TextField(
              controller: TextEditingController(text: profileProvider.email),
              enabled: false,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'İsim'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneController,
              decoration: const InputDecoration(labelText: 'Telefon'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'Açıklama'),
            ),
            const SizedBox(height: 16),
            const TextField(
              obscureText: true,
              enabled: false,
              decoration: InputDecoration(hintText: '******'),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                profileProvider.saveProfileData(
                  nameController.text,
                  phoneController.text,
                  descriptionController.text,
                );
              },
              child: const Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}
