import 'package:flutter/material.dart';
import '../widgets/service_detail_header.dart';

class TerraceGardenScreen extends StatelessWidget {
  const TerraceGardenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text("Terrace & Kitchen Garden"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ServiceDetailHeader(
                imageUrl:
                    'https://static.vecteezy.com/system/resources/previews/023/378/230/large_2x/modern-garden-terrace-kitchen-interior-ai-generated-photo.jpg',
                title: 'Terrace & Kitchen Garden',
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Grow Your Own Urban Garden',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black38),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      context,
                      'Custom terrace garden design',
                      'https://www.anzlandscaping.in/wp-content/uploads/2023/07/Screenshot-2023-02-17-115051.png',
                      'Create a beautiful and functional terrace garden with our custom design services.',
                    ),
                    _buildDetailItem(
                      context,
                      'Kitchen garden setup with vegetable plots',
                      'https://media.architecturaldigest.com/photos/626aab7c3eb88382e12961b4/3:2/w_4737,h_3158,c_limit/16%20Backyard%20Vegetable%20Garden%20Ideas.jpg',
                      'Set up a productive kitchen garden with our expert guidance and vegetable plots.',
                    ),
                    _buildDetailItem(
                      context,
                      'Container gardening solutions',
                      'https://www.allthatgrows.in/cdn/shop/articles/81478036_m_1_1100x1100.jpg?v=1603343363',
                      'Optimize your space with our innovative container gardening solutions.',
                    ),
                    _buildDetailItem(
                      context,
                      'Herb garden installations',
                      'https://media.istockphoto.com/id/164666590/photo/roof-terrace.jpg?s=612x612&w=0&k=20&c=WKF9eZ_Tj2G5lFqxpuYsEZ4b5d7jS7OUVQ3zyXFeCtw=',
                      'Install a thriving herb garden with our professional services.',
                    ),
                    _buildDetailItem(
                      context,
                      'Efficient irrigation systems',
                      'https://m.media-amazon.com/images/I/910YBxiVcIL.jpg',
                      'Ensure your garden is well-watered with our efficient irrigation systems.',
                    ),
                    _buildDetailItem(
                      context,
                      'Organic growing techniques',
                      'https://geneticliteracyproject.org/wp-content/uploads/elementor/thumbs/predlog-za-velinu-slikuu-pe4xzp6h8fjg0qi42uaagc7r6hh3xtwd9s1t1ns0am.jpg',
                      'Grow healthy, organic produce with our sustainable growing techniques.',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDetailItem(
      BuildContext context, String title, String imageUrl, String description) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(fontSize: 16, color: Colors.grey[800]),
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(imageUrl),
            ),
          ],
        ),
      ),
    );
  }
}
