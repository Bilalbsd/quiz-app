import 'package:flutter/material.dart';

class ProfileHomePage extends StatelessWidget {
  const ProfileHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Home Page'),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Container(
        alignment: Alignment.center,
        color: Colors.blue[50],
        child: Stack(
          alignment: Alignment.center,
          children: [
            _getCard(context),
            Positioned(
              top: 60,
              child: _getAvatar(),
            ),
          ],
        ),
      ),
    );
  }

  Container _getCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 150),
      padding: const EdgeInsets.all(20),
      width: 350,
      decoration: BoxDecoration(
        color: Colors.blue[900],
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 60),
          const Text(
            'Bilal',
            style: TextStyle(
              fontSize: 28,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'bilal@etu.umontpellier.fr',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Réseau social : @BilalBsd',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/quiz'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: const EdgeInsets.symmetric(vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Commencer le Quiz',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blue[50]!, width: 5),
        image: const DecorationImage(
          image: AssetImage('assets/images/profile.jpg'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
