import 'package:civix_teams/features/my%20team/presentation/views/widgets/contact_tile.dart';
import 'package:flutter/material.dart';

class MyTeamViewBody extends StatelessWidget {
  const MyTeamViewBody({super.key});
  final List<Map<String, dynamic>> contacts = const [
    {"firstName": "Islam", "lastName": "Bahaa", "phoneNumber": "+201234567890"},
    {"firstName": "Ahmed", "lastName": "Fathy", "phoneNumber": "+201234567890"},
    {"firstName": "Ziad", "lastName": "Fathy", "phoneNumber": "+201234567890"},
    {
      "firstName": "Ibrahim",
      "lastName": "Mohamed",
      "phoneNumber": "+201234567890",
    },
    {"firstName": "Adel", "lastName": "Shakal", "phoneNumber": "+201234567890"},
  ];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: ListView.builder(
        itemCount: contacts.length,
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ContactTile(
              firstName: contacts[index]["firstName"],
              lastName: contacts[index]["lastName"],
              phoneNumber: contacts[index]["phoneNumber"],
            ),
          );
        },
      ),
    );
  }
}
