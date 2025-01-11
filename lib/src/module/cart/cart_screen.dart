import 'package:biotech_maali/src/module/cart/cart_provider.dart';

import '../../../import.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CartProvider>().fetchCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Shopping Cart',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          if (cartProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (cartProvider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(cartProvider.error),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => cartProvider.fetchCartItems(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (cartProvider.cartItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 64),
                  SizedBox(height: 16),
                  Text('Your cart is empty'),
                ],
              ),
            );
          }

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartProvider.cartItems.length,
                      separatorBuilder: (context, index) => Container(
                        height: 8,
                        color: cAppBackround,
                      ),
                      itemBuilder: (context, index) {
                        final item = cartProvider.cartItems[index];
                        return CartProductTile(
                          key: ValueKey(item.id),
                          productId: item.productId,
                          cartId: item.id,
                          productTitle: item.name,
                          productImage: item.image,
                          price: double.parse(item.price),
                          quantity: item.quantity,
                          stockStatus: item.stockStatus,
                          onQuantityChanged: (newQuantity) async {
                            await cartProvider.updateCartItemQuantity(
                                item.id, newQuantity);
                          },
                          onDelete: () async {
                            await cartProvider.deleteCartItem(item.id);
                          },
                        );
                      },
                    ),
                    Container(
                      height: 8,
                      color: cAppBackround,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const CommonTextWidget(
                            title: 'Price Details',
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                          ),
                          const Divider(),
                          const SizedBox(height: 16),
                          _PriceDetailRow(
                            title:
                                'Price (${cartProvider.cartItems.length} Items)',
                            amount: cartProvider.totalAmount,
                          ),
                          const SizedBox(height: 16),
                          const _PriceDetailRow(
                            title: 'Discount',
                            amount: -266.00,
                            color: Colors.green,
                          ),
                          const SizedBox(height: 16),
                          const _DeliveryChargesRow(),
                          const SizedBox(height: 16),
                          _PriceDetailRow(
                            title: 'Total Amount',
                            amount: cartProvider.totalAmount - 266.00,
                            isBold: true,
                          ),
                          const SizedBox(height: 16),
                          const Center(
                            child: CommonTextWidget(
                              title: 'You will save ₹266.00 on this order',
                              color: Colors.green,
                              fontWeight: FontWeight.w400,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 80),
                  ],
                ),
              ),
              _buildBottomButtons(context),
            ],
          );
        },
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        height: 60,
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 160,
              height: 48,
              child: CustomizableBorderColoredButton(
                title: 'CANCEL',
                event: () => Navigator.of(context).pop(),
              ),
            ),
            SizedBox(
              width: 160,
              height: 48,
              child: CustomizableButton(
                title: 'PLACE ORDER',
                event: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderSummaryScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PriceDetailRow extends StatelessWidget {
  final String title;
  final double amount;
  final Color? color;
  final bool isBold;

  const _PriceDetailRow({
    required this.title,
    required this.amount,
    this.color,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          title: title,
          fontSize: 16,
          fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
        ),
        CommonTextWidget(
          title: '₹${amount.toStringAsFixed(2)}',
          fontSize: 16,
          fontWeight: isBold ? FontWeight.w500 : FontWeight.w400,
          color: color,
        ),
      ],
    );
  }
}

class _DeliveryChargesRow extends StatelessWidget {
  const _DeliveryChargesRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CommonTextWidget(
          title: 'Delivery Charges',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        Row(
          children: [
            CommonTextWidget(
              title: '₹80',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              lineThrough: TextDecoration.lineThrough,
            ),
            SizedBox(width: 4),
            CommonTextWidget(
              title: 'Free',
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: Colors.green,
            ),
          ],
        ),
      ],
    );
  }
}

// cart_product_tile.dart
class CartProductTile extends StatelessWidget {
  final int productId;
  final int cartId;
  final String productTitle;
  final String productImage;
  final double price;
  final int quantity;
  final String stockStatus;
  final Function(int) onQuantityChanged;
  final VoidCallback onDelete;

  const CartProductTile({
    super.key,
    required this.productId,
    required this.cartId,
    required this.productTitle,
    required this.productImage,
    required this.price,
    required this.quantity,
    required this.stockStatus,
    required this.onQuantityChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isInStock = stockStatus.toLowerCase() == 'in stock';

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.all(12),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  "${BaseUrl.baseUrlForImages}$productImage",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: 100,
                    height: 100,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      title: productTitle,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        CommonTextWidget(
                          title: '₹${price.toStringAsFixed(2)}',
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: cProductRate,
                        ),
                        const SizedBox(width: 8),
                        if (price < 599.00) ...[
                          CommonTextWidget(
                            title: '₹599.00',
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: cProductRateCrossed,
                            lineThrough: TextDecoration.lineThrough,
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 12),
                    if (isInStock) ...[
                      AddQuantityWidget(
                        quantity: quantity,
                        addition: () => onQuantityChanged(quantity + 1),
                        substaction: () {
                          if (quantity > 1) {
                            onQuantityChanged(quantity - 1);
                          }
                        },
                      ),
                    ] else ...[
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: const CommonTextWidget(
                          title: 'Out of stock',
                          color: Colors.red,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: IconButton(
              onPressed: onDelete,
              icon: SvgPicture.asset(
                'assets/svg/icons/delete_icon.svg',
                width: 24,
                height: 24,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
