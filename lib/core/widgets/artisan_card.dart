import 'package:flutter/material.dart';

class ArtisanCard extends StatelessWidget {
  final String name;
  final String job;
  final String city;
  final String rating;
  final VoidCallback? onPressed;

  const ArtisanCard({
    super.key,
    required this.name,
    required this.job,
    required this.city,
    required this.rating,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 35,
              backgroundColor: Color(0xff1565C0),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 35,
              ),
            ),

            const SizedBox(width: 15),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Text(
                    job,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [

                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Text(city),

                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [

                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 18,
                      ),

                      const SizedBox(width: 5),

                      Text(rating),

                    ],
                  ),

                ],
              ),
            ),

            ElevatedButton.icon(

              onPressed: onPressed,

              icon: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),

              label: const Text("Voir"),

              style: ElevatedButton.styleFrom(

                backgroundColor: const Color(0xff1565C0),

                foregroundColor: Colors.white,

                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),

                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),

              ),

            ),
          ],
        ),
      ),
    );
  }
}