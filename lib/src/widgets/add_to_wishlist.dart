import 'package:biotech_maali/src/module/wishlist/wishlist_screen.dart';

import '../../import.dart';

void showWishlistMessage(BuildContext context, bool isAdded) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAdded ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: 20, // Reduced icon size
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isAdded
                      ? 'Item added to wishlist successfully'
                      : 'Item removed from wishlist',
                  overflow: TextOverflow.ellipsis, // Handles text overflow
                  style: const TextStyle(fontSize: 14), // Slightly smaller text
                ),
              ),
            ],
          );
        },
      ),
      action: SnackBarAction(
        label: 'View', // Shortened the label
        textColor: Colors.yellow, // Makes action more visible
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WishlistScreen(),
            ),
          );
        },
      ),

      duration: const Duration(seconds: 2),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.only(
        bottom: 20,
        left: 10,
        right: 10,
      ), // Add margins
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      backgroundColor: isAdded ? Colors.green : Colors.grey[800],
    ),
  );
}
