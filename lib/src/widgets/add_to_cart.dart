import '../../import.dart';

void showCartMessage(BuildContext context, bool isAdded) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Animated and Pulsating Icon
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 600),
            tween: Tween(begin: 0.7, end: 1.0),
            builder: (context, scale, child) {
              return Transform.scale(
                scale: scale,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isAdded
                        ? Colors.white.withOpacity(0.2)
                        : Colors.grey.withOpacity(0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isAdded ? Icons.shopping_cart_checkout : Icons.info_outline,
                    color: isAdded ? Colors.white : Colors.orange,
                    size: 24,
                  ),
                ),
              );
            },
          ),

          const SizedBox(width: 12),

          // Message Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  isAdded ? 'Item Added to Cart' : 'Cart Update',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  isAdded
                      ? 'Your product is ready for checkout'
                      : 'This item is already in your cart',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 12,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),

      // Styling
      backgroundColor: isAdded ? Colors.green.shade700 : Colors.orange.shade700,

      // Layout and Behavior
      behavior: SnackBarBehavior.floating,
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),

      // Margins for better visual appeal
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),

      // Duration and Action
      duration: const Duration(seconds: 3),
      action: SnackBarAction(
        label: 'VIEW CART',
        textColor: Colors.white,
        onPressed: () {
          // Dismiss snackbar before navigation
          ScaffoldMessenger.of(context).hideCurrentSnackBar();

          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const CartScreen()),
          );
        },
      ),
    ),
  );
}

// import '../../import.dart';

// void showCartMessage(BuildContext context, bool isAdded) {
//   // 1. SnackBar (Original Implementation)
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.transparent,
//     isScrollControlled: true,
//     builder: (BuildContext context) {
//       return Container(
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: const BorderRadius.vertical(
//             top: Radius.circular(24),
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.1),
//               blurRadius: 20,
//               spreadRadius: 5,
//             ),
//           ],
//         ),
//         padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             // Animated Cart Icon
//             TweenAnimationBuilder<double>(
//               duration: const Duration(milliseconds: 500),
//               tween: Tween(begin: 0.5, end: 1.0),
//               builder: (context, scale, child) {
//                 return Transform.scale(
//                   scale: scale,
//                   child: Icon(
//                     isAdded
//                         ? Icons.shopping_cart_checkout
//                         : Icons.add_shopping_cart,
//                     size: 80,
//                     color: isAdded ? Colors.green : Colors.blue,
//                   ),
//                 );
//               },
//             ),

//             const SizedBox(height: 24),

//             // Message
//             Text(
//               isAdded
//                   ? 'Item Added to Cart Successfully!'
//                   : 'Item Already in Your Cart',
//               style: TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.w600,
//                 color: isAdded ? Colors.green : Colors.blue,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 16),

//             // Subtitle
//             Text(
//               isAdded
//                   ? 'Your product is ready for checkout.'
//                   : 'You can modify quantity in the cart.',
//               style: const TextStyle(
//                 fontSize: 14,
//                 color: Colors.grey,
//               ),
//               textAlign: TextAlign.center,
//             ),

//             const SizedBox(height: 32),

//             // Action Buttons
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 // Continue Shopping Button
//                 OutlinedButton(
//                   onPressed: () => Navigator.pop(context),
//                   style: OutlinedButton.styleFrom(
//                     foregroundColor: Colors.blue,
//                     side: const BorderSide(color: Colors.blue),
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12),
//                   ),
//                   child: const Text('Continue Shopping'),
//                 ),

//                 const SizedBox(width: 16),

//                 // View Cart Button
//                 ElevatedButton(
//                   onPressed: () {
//                     Navigator.pop(context);
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                           builder: (context) => const CartScreen()),
//                     );
//                   },
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     foregroundColor: Colors.white,
//                     padding: const EdgeInsets.symmetric(
//                         horizontal: 24, vertical: 12),
//                   ),
//                   child: const Text('View Cart'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       );
//     },
//   );
// }




