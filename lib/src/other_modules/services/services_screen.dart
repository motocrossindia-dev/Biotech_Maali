import 'package:biotech_maali/src/module/services/screens/drip_irrigation_screen.dart';
import 'package:biotech_maali/src/module/services/screens/garden_maintenance_screen.dart';
import 'package:biotech_maali/src/module/services/screens/landscaping_service_screen.dart';
import 'package:biotech_maali/src/module/services/screens/terrace_garden_screen.dart';
import 'package:biotech_maali/src/module/services/screens/vertical_garden_screen.dart';
import 'package:biotech_maali/src/other_modules/services/services_provider.dart';
import '../../../import.dart';

class ServicesScreen extends StatefulWidget {
  const ServicesScreen({super.key});

  @override
  State<ServicesScreen> createState() => _ServicesScreenState();
}

class _ServicesScreenState extends State<ServicesScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch services when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ServicesProvider>().fetchServices();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Services'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Consumer<ServicesProvider>(
        builder: (context, provider, child) {
          // if (provider.isLoading) {
          //   return const Center(child: CircularProgressIndicator());
          // }

          // if (provider.error.isNotEmpty) {
          //   return Center(
          //     child: Column(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Text(provider.error),
          //         const SizedBox(height: 16),
          //         ElevatedButton(
          //           onPressed: () => provider.fetchServices(),
          //           child: const Text('Retry'),
          //         ),
          //       ],
          //     ),
          //   );
          // }

          return const SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LandscapingServiceCard(),
                HowItWorksSection(),
                ContactFormSection(),
              ],
            ),
          );
        },
      ),
    );
  }
}

class LandscapingServiceCard extends StatelessWidget {
  const LandscapingServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildServiceCard(
            context: context,
            title: 'Landscaping',
            imageUrl:
                'https://static.wixstatic.com/media/0e86fc_3c46288efa2441fab93089a47d7e6277~mv2.jpeg/v1/fill/w_640,h_688,al_c,q_85,usm_0.66_1.00_0.01,enc_avif,quality_auto/0e86fc_3c46288efa2441fab93089a47d7e6277~mv2.jpeg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LandscapingServiceScreen(),
                ),
              );
            },
          ),
          _buildServiceCard(
            context: context,
            title: 'Terrace & Kitchen Garden',
            imageUrl:
                'https://i.pinimg.com/474x/62/7d/b4/627db446caf61439694c80173835b8c0.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const TerraceGardenScreen(),
                ),
              );
            },
          ),
          _buildServiceCard(
            context: context,
            title: 'Vertical Wall & Garden',
            imageUrl:
                'https://media.architecturaldigest.com/photos/66bfa51bbb9599ad676d0e19/master/w_1600%2Cc_limit/GettyImages-455075581.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const VerticalGardenScreen(),
                ),
              );
            },
          ),
          _buildServiceCard(
            context: context,
            title: 'Drip Irrigation',
            imageUrl:
                'https://img-cdn.krishijagran.com/98815/drip-irrigation-1.jpg',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const DripIrrigationScreen(),
                ),
              );
            },
          ),
          _buildServiceCard(
            context: context,
            title: 'Garden Maintenance',
            imageUrl:
                'https://images.unsplash.com/photo-1416879595882-3373a0480b5b',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GardenMaintenanceScreen(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildServiceCard({
    required BuildContext context,
    required String title,
    required String imageUrl,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 160,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Stack(
              children: [
                // Image
                Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                  height: double.infinity,
                  width: double.infinity,
                ),
                // Gradient overlay
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.7),
                      ],
                    ),
                  ),
                ),
                // Title
                Positioned(
                  bottom: 10,
                  left: 10,
                  right: 10,
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}



class HowItWorksSection extends StatelessWidget {
  const HowItWorksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ServicesProvider>(
      builder: (context, provider, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'How it works',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildWorkStep(
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/4a90e2/team-skin-type-7.png',
                      label: 'Professional\nTeam',
                    ),
                    _buildWorkStep(
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/4a90e2/fire-element.png',
                      label: 'Best\nEquipment',
                    ),
                    _buildWorkStep(
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/4a90e2/calendar--v1.png',
                      label: 'Time\nManagement',
                    ),
                    _buildWorkStep(
                      imagePath:
                          'https://img.icons8.com/ios-filled/50/4a90e2/maintenance.png',
                      label: 'Quality\nWork',
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWorkStep({required String imagePath, required String label}) {
    return Column(
      children: [
        Image.network(
          imagePath,
          width: 24,
          height: 24,
          color: const Color(0xFF2196F3),
          errorBuilder: (context, error, stackTrace) => const Icon(
            Icons.error,
            size: 24,
            color: Color(0xFF2196F3),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 11,
            color: Colors.black87,
            height: 1.2,
          ),
        ),
      ],
    );
  }
}

class ContactFormSection extends StatefulWidget {
  const ContactFormSection({super.key});

  @override
  State<ContactFormSection> createState() => _ContactFormSectionState();
}

class _ContactFormSectionState extends State<ContactFormSection> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _contactController = TextEditingController();
  final _locationController = TextEditingController();
  final _serviceController = TextEditingController();
  final _messageController = TextEditingController();

  String? _validateField(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final provider = context.read<ServicesProvider>();
      final success = await provider.submitForm(
        _nameController.text,
        _contactController.text,
        _locationController.text,
        _serviceController.text,
        _messageController.text,
      );

      if (!mounted) return;

      if (success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Form submitted successfully!')),
        );
        _formKey.currentState!.reset();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(provider.error.isEmpty
                ? 'Failed to submit form'
                : provider.error),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const Text(
                  'Biotech Maali Service',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Image.asset(
                  'assets/png/images/undraw_contact_us.png',
                  height: 150,
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) {
                    return SizedBox(
                      height: 100,
                      child: Icon(Icons.error, color: Colors.grey[400]),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateField(value, 'Name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contactController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.phone,
                  validator: (value) => _validateField(value, 'Contact number'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _locationController,
                  decoration: const InputDecoration(
                    labelText: 'Location',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateField(value, 'Location'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _serviceController,
                  decoration: const InputDecoration(
                    labelText: 'Service',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateField(value, 'Service'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _messageController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Message',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) => _validateField(value, 'Message'),
                ),
                const SizedBox(height: 24),
                Consumer<ServicesProvider>(
                  builder: (context, provider, child) {
                    return SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: CommonButtonWidget(
                        title: provider.isSubmitting ? 'SENDING...' : 'SEND',
                        event: provider.isSubmitting ? null : _submitForm,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _locationController.dispose();
    _serviceController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
