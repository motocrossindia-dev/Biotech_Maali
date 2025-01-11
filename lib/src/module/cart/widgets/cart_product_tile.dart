// import '../../../../import.dart';

// class CartProductTile extends StatelessWidget {
//   final String productTitle;
//   final String productImage;
//   final double price;
//   final int quantity;
//   final String stockStatus;
//   final Function(int)? onQuantityChanged;
//   final VoidCallback? onDelete;

//   const CartProductTile({
//     super.key,
//     required this.productTitle,
//     required this.productImage,
//     required this.price,
//     required this.quantity,
//     required this.stockStatus,
//     this.onQuantityChanged,
//     this.onDelete,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final isInStock = stockStatus.toLowerCase() == 'in stock';

//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: const EdgeInsets.all(12),
//       child: Stack(
//         children: [
//           Row(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Image.network(
//                   "${BaseUrl.baseUrlForImages}$productImage",
//                   width: 100,
//                   height: 100,
//                   fit: BoxFit.cover,
//                   errorBuilder: (context, error, stackTrace) => Container(
//                     width: 100,
//                     height: 100,
//                     color: Colors.grey[200],
//                     child: const Icon(Icons.image_not_supported),
//                   ),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     CommonTextWidget(
//                       title: productTitle,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w500,
//                     ),
//                     const SizedBox(height: 8),
//                     Row(
//                       children: [
//                         CommonTextWidget(
//                           title: '₹${price.toStringAsFixed(2)}',
//                           fontSize: 16,
//                           fontWeight: FontWeight.w500,
//                           color: cProductRate,
//                         ),
//                         const SizedBox(width: 8),
//                         if (price < 599.00) ...[
//                           CommonTextWidget(
//                             title: '₹599.00',
//                             fontSize: 14,
//                             fontWeight: FontWeight.w400,
//                             color: cProductRateCrossed,
//                             lineThrough: TextDecoration.lineThrough,
//                           ),
//                         ],
//                       ],
//                     ),
//                     const SizedBox(height: 12),
//                     if (isInStock) ...[
//                       AddQuantityWidget(
//                         quantity: quantity,
//                         addition: () {
//                           if (onQuantityChanged != null) {
//                             onQuantityChanged!(quantity + 1);
//                           }
//                         },
//                         substaction: () {
//                           if (quantity > 1 && onQuantityChanged != null) {
//                             onQuantityChanged!(quantity - 1);
//                           }
//                         },
//                       ),
//                     ] else ...[
//                       Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 8,
//                           vertical: 4,
//                         ),
//                         decoration: BoxDecoration(
//                           color: Colors.red[50],
//                           borderRadius: BorderRadius.circular(4),
//                         ),
//                         child: const CommonTextWidget(
//                           title: 'Out of stock',
//                           color: Colors.red,
//                           fontSize: 12,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           Positioned(
//             top: 0,
//             right: 0,
//             child: IconButton(
//               onPressed: onDelete,
//               icon: SvgPicture.asset(
//                 'assets/svg/icons/delete_icon.svg',
//                 width: 24,
//                 height: 24,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

