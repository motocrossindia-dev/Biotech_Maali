import 'package:flutter/material.dart';

class ServiceDetailHeader extends StatelessWidget {
  final String imageUrl;
  final String title;

  const ServiceDetailHeader({
    super.key,
    required this.imageUrl,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          imageUrl,
          height: 200,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        // Positioned(
        //   bottom: 16,
        //   left: 16,
        //   child: Text(
        //     title,
        //     style: const TextStyle(
        //       color: Colors.black87,
        //       fontSize: 24,
        //       fontWeight: FontWeight.bold,
        //     ),
        //   ),
        // ),
      ],
    );
  }
}
