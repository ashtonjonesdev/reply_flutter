import 'package:flutter/material.dart';
import 'package:material_about/material_about.dart';
import 'package:reply_flutter/styles/colors.dart';

class AboutDeveloper extends StatelessWidget {

  static final String routeName = 'aboutdeveloper';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('About Developer'),
      ),
      body: MaterialAbout(
        banner: Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Image.asset(
            'images/gradient_purple_background.jpg',
            height: 20.0,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.fill,
          ),
        ),
        dp: Image.asset(
          "images/profile_picture.JPG",
          height: 190.0,
          fit: BoxFit.fill,
        ),
        name: "Ashton Jones",
        position: "Mobile Developer",
        description: "👨‍💻 Google Certified Android Engineer |\n ✍ Writer |\n🧘‍♂️ Stoic && Meditator",
        seperatorColor: kPrimaryColor,
        iconColor: Colors.black,
        textColor: Colors.black,
        playstoreID: "8786079395794167171",
        github: "ashtonjonesdev", //e.g JideGuru
        facebook: "TJgrapes", //e.g jideguru
        twitter: "TJgrapes", //e.g JideGuru
        linkedin: "tjgrapes",
        email: "ashtonjonesdev@gmail.com",
        website: "https://ashtonjones.dev/",
        appIcon: "images/app_icon.png",
        appName: "Reply",
        appVersion: "1.0",
        donate: "mailto: ashtonjonesdev@gmail.com",
        share: "https://play.google.com/store/apps/details?id=dev.ashtonjones.reply",
        devID: "8786079395794167171",
        help: "help",
      ),
    );
  }
}