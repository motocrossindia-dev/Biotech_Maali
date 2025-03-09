import 'dart:developer';

import 'package:biotech_maali/src/payment_and_order/local_store_list/local_store_list_provider.dart';

import '../../../import.dart';

class SelectLocalStoreScreen extends StatefulWidget {
  const SelectLocalStoreScreen({super.key});

  @override
  State<SelectLocalStoreScreen> createState() => _SelectLocalStoreScreenState();
}

class _SelectLocalStoreScreenState extends State<SelectLocalStoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CommonTextWidget(
          title: 'Select Local Store',
          fontSize: 18,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Consumer<LocalStoreListProvider>(
        builder: (context, provider, child) {
          List<Map<String, String>> stores = provider.stores;
          return Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio:
                        0.76, // Changed from 0.7 to make cards shorter
                    crossAxisSpacing: 15,
                    mainAxisSpacing: 15,
                  ),
                  itemCount: provider.stores.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        provider.setSelectedStore(index);
                      },
                      child: StoreCard(
                        isSelected: provider.selectedStoreIndex == index,
                        imageUrl: stores[index]['image']!,
                        address: stores[index]['address']!,
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          side: BorderSide(color: cButtonGreen),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: CommonTextWidget(
                          title: 'CANCEL',
                          color: cButtonGreen,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: cButtonGreen,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        onPressed: () {
                          // Handle delivery action
                          Navigator.pop(context, provider.selectedStoreIndex);
                        },
                        child: const CommonTextWidget(
                          title: 'DELIVER HERE',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class StoreCard extends StatelessWidget {
  final bool isSelected;
  final String imageUrl;
  final String address;

  const StoreCard({
    super.key,
    required this.isSelected,
    required this.imageUrl,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    log("Image : $imageUrl");
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Expanded(
            flex: 2, // Changed from 3 to reduce image height proportion
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                  child: Image.asset(
                    imageUrl,
                    width: double.infinity,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Center(
                          child: Icon(Icons.image_not_supported, size: 40),
                        ),
                      );
                    },
                  ),
                ),
                if (isSelected)
                  Positioned.fill(
                    child: Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Center(
                        child: CircleAvatar(
                          backgroundColor: cButtonGreen,
                          radius: 20,
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Expanded(
            flex: 2, // Changed from 2 to reduce text area height proportion
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Text(
                  address,
                  style: const TextStyle(fontSize: 12),
                  maxLines: 5, // Reduced from 5 to show less text
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
