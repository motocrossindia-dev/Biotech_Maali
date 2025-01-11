import '../../../../import.dart';

class PromotionalBanner extends StatelessWidget {
  const PromotionalBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Vibrant and Thriving Plants Online',
            style: TextStyle(
              fontSize: 16,
              color: Colors.green[800],
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Celebrate Friendship with 15% Off',
            style: TextStyle(
              fontSize: 14,
              color: Colors.green[900],
              fontWeight: FontWeight.normal,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 30, // This controls the overall height
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProductListScreen(title: "Plants", products: []),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: cButtonGreen,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 16, // Reduced from 24
                  vertical:
                      0, // Removed vertical padding to let SizedBox control height
                ),
                minimumSize: Size.zero, // Allows the button to be smaller
                tapTargetSize: MaterialTapTargetSize
                    .shrinkWrap, // Removes default minimum size
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: const Text(
                'Shop Now',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
