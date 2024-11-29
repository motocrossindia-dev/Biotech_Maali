import '../../../../import.dart';

class CouponWidget extends StatelessWidget {
  const CouponWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CommonTextWidget(
          title: 'Apply Coupon',
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 45, // Set the same height as the ElevatedButton
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Discount code',
                    contentPadding:
                        const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                    // contentPadding: EdgeInsets.symmetric(vertical: 10), // Adjust vertical padding if needed
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: cButtonGreen),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: cButtonGreen), // Border color when focused
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(
                          color: cBorderGrey), // Border color when enabled
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize:
                    const Size(0, 45), // Set button height to match TextField
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                backgroundColor: Colors.white,
                foregroundColor: cButtonGreen,
                side: BorderSide(color: cButtonGreen),
              ),
              child: const CommonTextWidget(title: 'Apply'),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildOfferItem(),
        _buildOfferItem(),
      ],
    );
  }

  Widget _buildOfferItem() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          const Icon(Icons.local_offer, color: Colors.green, size: 20),
          const SizedBox(width: 8),
          const CommonTextWidget(title: '10% off on orders above ₹1499'),
          const Spacer(),
          TextButton(
            onPressed: () {},
            child:  const CommonTextWidget(
              title: 'APPLY OFFER',
              color: Colors.grey,
              lineThrough: TextDecoration.underline,
            ),
          ),
        ],
      ),
    );
  }
}
