import 'package:flutter/material.dart';

class FeatursCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  const FeatursCard({
    super.key,
    required this.icon,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: const Color.fromARGB(255, 55, 114, 216).withValues(alpha: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: const Color.fromARGB(255, 196, 218, 229),
                  size: 15,
                ),
                SizedBox(width: 6),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    color: const Color.fromARGB(255, 196, 218, 229),
                  ),
                ),
              ],
            ),
            SizedBox(height: 5),
            Text(
              content,
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
