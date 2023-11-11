import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const ContactMeScreen());
}

class ContactMeScreen extends StatelessWidget {
  const ContactMeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.teal,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProfileCard(),
              Separator(),
              PhoneCard(),
              EmailCard(),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          radius: 48.0,
          backgroundImage: NetworkImage(
            'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'Jane Doe',
          style: GoogleFonts.pacifico(
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 32.0,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
        const SizedBox(
          height: 8.0,
        ),
        Text(
          'FLUTTER DEVELOPER',
          style: GoogleFonts.sourceSans3(
            textStyle: TextStyle(
              color: Colors.teal.shade100,
              fontSize: 16.0,
              letterSpacing: 2.25,
              fontWeight: FontWeight.w500,
            ),
          ),
        )
      ],
    );
  }
}

class Separator extends StatelessWidget {
  const Separator({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32.0,
      width: 160.0,
      child: Divider(
        color: Colors.teal.shade100,
        thickness: 1.0,
      ),
    );
  }
}

class PhoneCard extends StatelessWidget {
  const PhoneCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      shadowColor: Colors.teal.shade900,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.teal,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.phone,
          size: 24.0,
          color: Colors.teal.shade900,
        ),
        title: Text(
          '+1 555 555 5555',
          style: GoogleFonts.sourceSans3(
            textStyle: TextStyle(
              color: Colors.teal.shade900,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}

class EmailCard extends StatelessWidget {
  const EmailCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 24.0),
      shadowColor: Colors.teal.shade900,
      elevation: 8.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: const BorderSide(
          color: Colors.teal,
          width: 2.0,
          style: BorderStyle.solid,
        ),
      ),
      child: ListTile(
        leading: Icon(
          Icons.email,
          size: 24.0,
          color: Colors.teal.shade900,
        ),
        title: Text(
          'jane@example.com',
          style: GoogleFonts.sourceSans3(
            textStyle: TextStyle(
              color: Colors.teal.shade900,
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
