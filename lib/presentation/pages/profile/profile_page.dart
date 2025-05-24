import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final headerImage = Container(
    width: double.infinity,
    height: 320,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/images/background.jpg'),
        fit: BoxFit.cover,
      ),
    ),
    child: Container(
      margin: const EdgeInsets.only(top: 44),
      child: const Column(
        children: [
          CircleAvatar(
            radius: 64,
            backgroundImage: AssetImage('assets/images/profile.jpg'),
          ),
          SizedBox(height: 10),
          Text(
            'Abdillah Haidar Mahendro',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'DevOps Engineer | Flutter Developer | Backend Engineer',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

  final personalInfo = Container(
    margin: const EdgeInsets.all(54),
    child: const Column(
      children: [
        SizedBox(height: 20),
        Row(
          children: [
            Icon(Icons.mail, color: Color.fromRGBO(4, 79, 79, 0.698)),
            SizedBox(width: 15),
            Text('abdil.haidar17@gmail.com'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.phone_android, color: Color.fromRGBO(4, 79, 79, 0.698)),
            SizedBox(width: 15),
            Text('+62 88977664271'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.group_add, color: Color.fromRGBO(4, 79, 79, 0.698)),
            SizedBox(width: 15),
            Text('Add to Group'),
          ],
        ),
        SizedBox(height: 15),
        Row(
          children: [
            Icon(Icons.comment, color: Color.fromRGBO(4, 79, 79, 0.698)),
            SizedBox(width: 15),
            Text('Show All Comments'),
          ],
        ),
      ],
    ),
  );

  final followButton = ElevatedButton(
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: const Color.fromRGBO(4, 79, 79, 0.698),
    ),
    onPressed: () {},
    child: const Text(
      'FOLLOW ME',
      style: TextStyle(color: Color.from(alpha: 1, red: 1, green: 1, blue: 1)),
    ),
  );

  final numberInfo = Container(
    height: 80,
    decoration: BoxDecoration(
      boxShadow: const [
        BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(2, 4)),
      ],
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    margin: const EdgeInsets.symmetric(vertical: 280, horizontal: 24),
    child: const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Photos',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '150',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 177, 166),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Followers',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '3275',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 177, 166),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Following',
              style: TextStyle(
                color: Colors.black38,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 10),
            Text(
              '1250',
              style: TextStyle(
                color: Color.fromARGB(255, 8, 177, 166),
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(children: [headerImage, personalInfo, followButton]),
        numberInfo,
      ],
    );
  }
}
