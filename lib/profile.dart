import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final double coverHeight = 280;
  final double profileHeight = 144;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('RayNotes'),
          backgroundColor: Colors.blue,
        ),
        body: ListView(padding: EdgeInsets.zero, children: <Widget>[
          buildTop(),
          buildContent(),
          bottomContent(),
        ]));
  }

  Widget buildTop() {
    final bottom = profileHeight / 2;
    final top = coverHeight - profileHeight / 2;
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(bottom: bottom),
          child: buildCoverImage(),
        ),
        Positioned(
          top: top,
          child: buildProfileImage(),
        )
      ],
    );
  }

  Widget buildCoverImage() => Container(
        color: Colors.grey,
        width: double.infinity,
        height: coverHeight,
      );

  Widget buildProfileImage() => CircleAvatar(
        radius: profileHeight / 2,
        backgroundColor: Colors.grey.shade800,
        backgroundImage: AssetImage('assets/images/profile.png'),
      );

  Widget buildContent() => Column(
        children: [
          const SizedBox(height: 8),
          Text('Rayvan Bayu Abhinowo',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text('XII RPL B',
              style: TextStyle(fontSize: 20, color: Colors.black)),
        ],
      );
  Widget bottomContent() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('PoB        : Tenggarong, Kutai Kertanegara, Samarinda',
              style: TextStyle(
                fontSize: 18,
                color: Colors.black,
              )),
          Text('DoB        : 24 Maret 2005',
              style: TextStyle(fontSize: 18, color: Colors.black)),
          Text('Address : Mekar Asri RT2/1, Popongan, Karanganyar',
              style: TextStyle(fontSize: 18, color: Colors.black)),
        ],
      );
}
