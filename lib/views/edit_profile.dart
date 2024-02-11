import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../application/services/profile_service.dart';
import '../application/services/user_service.dart';
import '../state/profile_state.dart';
import 'login.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late final ProfileService profileService;
  late final TextEditingController nameController;
  late final TextEditingController descriptionController;

  @override
  void initState() {
    var profile =
    Provider.of<ProfileState>(context, listen: false).getProfile();
    nameController = TextEditingController(text: profile!.name);
    descriptionController = TextEditingController(text: profile.description);
    profileService = ProfileService(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    Future<void> selectDate(BuildContext context) async {
      var profile =
          Provider.of<ProfileState>(context, listen: false).getProfile();
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: profile!.birthday,
          firstDate: DateTime(2015, 8),
          lastDate: DateTime(2101));
      if (picked != null && picked != profile.birthday) {
        setState(() {
          profile.birthday = picked;
          Provider.of<ProfileState>(context, listen: false)
              .updateProfileLocal(profile);
        });
      }
    }

    void save() async {
      var profile =
        Provider.of<ProfileState>(context, listen: false).getProfile();

      profile.name = nameController.text;
      profile.description = descriptionController.text;

      var res = await profileService.updateProfile(profile);
      if (!context.mounted) return;

      if (res.success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Oplysninger er gemt!'),
            )
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Der gik noget galt :/'),
            )
        );
      }
    }

    void selectProfilePicture() async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.gallery);
      if (image == null || !context.mounted) {
        return;
      }
      var profile =
      Provider.of<ProfileState>(context, listen: false).getProfile();
      var uploadRes = await profileService.uploadProfileImage(image, profile.uid);

      if (!context.mounted) return;
      if (!uploadRes.success) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Der gik noget galt :/'),
            )
        );
        return;
      }
      profile.image = uploadRes.result;

      Provider.of<ProfileState>(context, listen: false)
          .updateProfileLocal(profile);
    }

    return SafeArea(
        child: Scaffold(
            backgroundColor: Colors.orange,
            body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackButton(),
                      Center(
                        child: Consumer<ProfileState>(
                          builder: (context, profile, child) {
                            // On Click image
                            return Column(children: [
                              GestureDetector(
                                onTap: () => {selectProfilePicture()},
                                child: CircleAvatar(
                                  radius: 120,
                                  backgroundImage: NetworkImage(
                                      profile.profile.image.isNotEmpty ? profile.profile.image : "https://firebasestorage.googleapis.com/v0/b/codea-6d3fa.appspot.com/o/profile_images%2Fprofile_picture.png?alt=media&token=01cb7f1b-3316-4a03-b721-aaa404788d7d"
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: TextFormField(
                                  controller: nameController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Navn',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: TextFormField(
                                  controller: descriptionController,
                                  decoration: const InputDecoration(
                                    border: UnderlineInputBorder(),
                                    labelText: 'Beskrivelse',
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Center(
                                      child: Text(
                                        "Fødselsdag:",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: GestureDetector(
                                        onTap: () => {selectDate(context)},
                                        child: Text(
                                          "${profile.profile.birthday.day}/${profile.profile.birthday.month}/${profile.profile.birthday.year}",
                                          style: const TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 16),
                                child: ElevatedButton(
                                  onPressed: () => save(),
                                  child: const Text('Gem'),
                                ),
                              ),
                            ]);
                          },
                        ),
                      )
                    ],
                  ),
                ),
              );
            })));
  }
}
