import '../../import.dart';

void showCartMessage(BuildContext context, bool isAdded) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: LayoutBuilder(
        builder: (context, constraints) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                isAdded
                    ? Icons.shopping_cart
                    : Icons.shopping_cart_checkout_outlined,
                color: Colors.white,
                size: 20, // Reduced icon size
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  isAdded
                      ? 'Item added to cart successfully'
                      : 'Item allready exists in cart',
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
            MaterialPageRoute(builder: (context) => const CartScreen()),
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
