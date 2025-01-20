import 'package:biotech_maali/src/other_modules/franchise_enquiry/franchise_enquiry_provider.dart';
import '../../../import.dart';

class FranchiseScreen extends StatelessWidget {
  const FranchiseScreen({super.key});

  // Form validation helper methods
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 2) {
      return 'Name must be at least 2 characters';
    }
    return null;
  }

  String? validateContact(String? value) {
    if (value == null || value.isEmpty) {
      return 'Contact number is required';
    }
    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
      return 'Please enter a valid 10-digit contact number';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? validateArea(String? value) {
    if (value == null || value.isEmpty) {
      return 'Area is required';
    }
    if (value.length < 5) {
      return 'Please provide more details about the area';
    }
    return null;
  }

  String? validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < 10) {
      return 'Please provide a complete address';
    }
    return null;
  }

  String? validateMessage(String? value) {
    if (value == null || value.isEmpty) {
      return 'Message is required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(),
        title: const Text('Franchise Enquiry'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Plant Store Image
            Image.network(
              'https://picsum.photos/400/200',
              height: 200,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 20),

            const Center(
              child: Text(
                'Get A Franchise',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            Image.network(
              'https://picsum.photos/400/100',
              height: 100,
              fit: BoxFit.cover,
            ),

            // Franchise Form
            Form(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildTextField(
                      context,
                      'Name',
                      validator: validateName,
                      keyboardType: TextInputType.name,
                    ),
                    _buildTextField(
                      context,
                      'Contact Number',
                      validator: validateContact,
                      keyboardType: TextInputType.phone,
                    ),
                    _buildTextField(
                      context,
                      'Your Email',
                      validator: validateEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    _buildTextField(
                      context,
                      'Area In Which You Want To Open The Biotech Maali Outlet',
                      validator: validateArea,
                    ),
                    _buildTextField(
                      context,
                      'Address',
                      validator: validateAddress,
                      keyboardType: TextInputType.streetAddress,
                    ),
                    _buildTextField(
                      context,
                      'Message',
                      maxLines: 3,
                      validator: validateMessage,
                    ),

                    const SizedBox(height: 20),

                    Consumer<FranchiseProvider>(
                      builder: (context, provider, _) {
                        return Column(
                          children: [
                            if (provider.error != null) ...[
                              Text(
                                provider.error!,
                                style: TextStyle(color: Colors.red[700]),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                            ],
                            CommonButtonWidget(
                              event: provider.isLoading
                                  ? null
                                  : () async {
                                      // Validate all fields before submission
                                      bool isValid = true;
                                      final fields = {
                                        'name': provider.name,
                                        'contact': provider.contact,
                                        'email': provider.email,
                                        'area': provider.area,
                                        'address': provider.address,
                                        'message': provider.message,
                                      };

                                      fields.forEach((key, value) {
                                        String? error;
                                        switch (key) {
                                          case 'name':
                                            error = validateName(value);
                                            break;
                                          case 'contact':
                                            error = validateContact(value);
                                            break;
                                          case 'email':
                                            error = validateEmail(value);
                                            break;
                                          case 'area':
                                            error = validateArea(value);
                                            break;
                                          case 'address':
                                            error = validateAddress(value);
                                            break;
                                          case 'message':
                                            error = validateMessage(value);
                                            break;
                                        }
                                        if (error != null) {
                                          provider.setError(error);
                                          isValid = false;
                                        }
                                      });

                                      if (isValid) {
                                        await provider.submitForm();
                                      }
                                    },
                              title:
                                  provider.isLoading ? 'SENDING...' : 'SEND MESSAGE',
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),

            // Rest of the sections remain the same
            _buildWhyWeRockSection(),
            ..._buildFeatureItems(),
            _buildStoreLocationsSection(),
            ..._buildStoreCards(),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: CommonButtonWidget(event: () {}, title: 'VIEW ALL'),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context,
    String label, {
    int maxLines = 1,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Consumer<FranchiseProvider>(
        builder: (context, provider, _) {
          return TextFormField(
            maxLines: maxLines,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              labelText: label,
              border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFF8BC34A)),
              ),
              errorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
            validator: validator,
            onChanged: (value) {
              switch (label) {
                case 'Name':
                  provider.setName(value);
                  break;
                case 'Contact Number':
                  provider.setContact(value);
                  break;
                case 'Your Email':
                  provider.setEmail(value);
                  break;
                case 'Area In Which You Want To Open The Biotech Maali Outlet':
                  provider.setArea(value);
                  break;
                case 'Address':
                  provider.setAddress(value);
                  break;
                case 'Message':
                  provider.setMessage(value);
                  break;
              }
              // Clear error when user starts typing
              if (provider.error != null) {
                provider.setError(null);
              }
            },
          );
        },
      ),
    );
  }

  Widget _buildWhyWeRockSection() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Why We Rock?',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Take the first step and become a part of the family that is ever-growing. Partner with the Most Trusted Plant Nursery in the market. The vision of Biotech Maali franchise is to deliver our unique cultural blend and values to each corner of this world.',
            style: TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              'https://picsum.photos/400/200',
              width: double.infinity,
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoreLocationsSection() {
    return const Padding(
      padding: EdgeInsets.all(16.0),
      child: Text(
        'Check Out Our Stores',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  List<Widget> _buildFeatureItems() {
    final features = [
      {
        'title': 'Target Audience',
        'icon': Icons.group_outlined,
        'description':
            'We are a major attraction for youths who are spending more than 5,00,000 minutes in our outlets. In the coming years, we are targeting to reach more cities and to serve more people.',
      },
      {
        'title': 'Prominence',
        'icon': Icons.star_outline,
        'description':
            'We are a major attraction for youths who are spending more than 5,00,000 minutes in our outlets. In the coming years, we are targeting to reach more cities and to serve more people.',
      },
      {
        'title': 'Fresh Concept',
        'icon': Icons.local_florist_outlined,
        'description':
            'We are a major attraction for youths who are spending more than 5,00,000 minutes in our outlets. In the coming years, we are targeting to reach more cities and to serve more people.',
      },
      {
        'title': 'Brand Value',
        'icon': Icons.trending_up_outlined,
        'description':
            'We are a major attraction for youths who are spending more than 5,00,000 minutes in our outlets. In the coming years, we are targeting to reach more cities and to serve more people.',
      },
    ];

    return features
        .map(
          (feature) => Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.grey.shade200),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Icon(
                    feature['icon'] as IconData,
                    size: 24,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        feature['title'] as String,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        feature['description'] as String,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  List<Widget> _buildStoreCards() {
    return [
      _buildStoreCard('Bangalore', 'ELECTRONICS CITY Ph Gate'),
      _buildStoreCard('Bangalore', 'ELECTRONICS CITY Ph Gate'),
    ];
  }

  Widget _buildStoreCard(String city, String location) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFF8BC34A)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  city,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Icon(Icons.location_on_outlined, color: Color(0xFF8BC34A)),
              ],
            ),
            const SizedBox(height: 8),
            Text(location),
            const Text('Contact Number: 9999999999'),
            const Text('Time: 9am to 9pm'),
          ],
        ),
      ),
    );
  }
}