import '../../../../import.dart';

class AddQuantityWidget extends StatelessWidget {
  final Function() addition;
  final Function() substaction;
  final int quantity;
  const AddQuantityWidget(
      {required this.quantity,
      required this.addition,
      required this.substaction,
      super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 28,
      child: Row(
        children: [
          InkWell(
            onTap: substaction,
            child: Container(
              height: 28,
              width: 26,
              color: cButtonGreen,
              child: const Center(
                child: CommonTextWidget(
                  title: '-',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            height: 28,
            width: 26,
            color: cQuantity,
            child: Center(
              child: CommonTextWidget(
                title: quantity.toString(),
                fontSize: 16,
                // color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          InkWell(
            onTap: addition,
            child: Container(
              height: 28,
              width: 26,
              color: cButtonGreen,
              child: const Center(
                child: CommonTextWidget(
                  title: '+',
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
