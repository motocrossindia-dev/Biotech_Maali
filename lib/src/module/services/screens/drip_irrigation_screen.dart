import 'package:flutter/material.dart';
import '../widgets/service_detail_header.dart';

class DripIrrigationScreen extends StatelessWidget {
  const DripIrrigationScreen({super.key});

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
        title: const Text('Drip Irrigation Systems'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ServiceDetailHeader(
                imageUrl:
                    'https://www.pipelife.com/irrigation-systems/drip-irrigation/_jcr_content/root/heroslider_copy/first-image/item/image.imgTransformer/media_16to10/md-2/1736767693316/Irrigation_pages_Drip_Irrigation_Hero.jpg',
                title: 'Drip Irrigation Systems',
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Smart Water Management',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    _buildDetailItem(
                      context,
                      'Custom system design and installation',
                      'https://creativeplant.com/wp-content/uploads/2023/11/IMG_20220511_100624684.jpg',
                      'We offer tailored drip irrigation system designs and professional installation services to meet your specific needs.',
                    ),
                    _buildDetailItem(
                      context,
                      'Water-efficient irrigation planning',
                      'https://www.wsbeng.com/wp-content/uploads/2022/07/AdobeStock_398873545-72dpi.jpg',
                      'Our experts plan irrigation systems that maximize water efficiency and ensure optimal plant growth.',
                    ),
                    _buildDetailItem(
                      context,
                      'Automated control systems',
                      'https://sswm.info/sites/default/files/inline-images/CARDENAS-LAILHACAR%202006.%20Control%20board%20showing%20timers%2C%20soil%20moisture%20sensor-controllers%2C%20etc..png',
                      'Implementing advanced automated control systems for precise water management and convenience.',
                    ),
                    _buildDetailItem(
                      context,
                      'Moisture sensors integration',
                      'https://media.licdn.com/dms/image/v2/D5612AQGfcLIpSB8M0Q/article-cover_image-shrink_600_2000/article-cover_image-shrink_600_2000/0/1709009889981?e=2147483647&v=beta&t=4Psn-H8h3gWRFX8qQdvoaZJdPnTYn1povRRJnpyaVQE',
                      'Integrating moisture sensors to monitor soil moisture levels and adjust irrigation accordingly.',
                    ),
                    _buildDetailItem(
                      context,
                      'Regular maintenance and repairs',
                      'https://cdn.wikifarmer.com/images/detailed/2023/04/Irrigation-System-Maintenance.jpg',
                      'Providing regular maintenance and repair services to ensure your irrigation system operates efficiently.',
                    ),
                    _buildDetailItem(
                      context,
                      'Water usage optimization',
                      'https://cdn.wikifarmer.com/images/detailed/2023/04/Irrigation-Management-How-to-Optimize-Irrigation-Efficiency-.jpg',
                      'Optimizing water usage to reduce waste and promote sustainable water management practices.',
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
