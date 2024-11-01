import '../../../../import.dart';

class AddQuantityWidget extends StatelessWidget {
  const AddQuantityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 85,
      height: 28,
      child: Row(
        children: [
          Container(
            height: 28,
            width: 26,
            color: cButtonGreen,
            child:const Center(
              child: CommonTextWidget(
                title: '-',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 28,
            width: 26,
            color: cQuantity,
            child:const Center(
              child: CommonTextWidget(
                title: '1',
                fontSize: 16,
                // color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            height: 28,
            width: 26,
            color: cButtonGreen,
            child:const Center(
              child: CommonTextWidget(
                title: '+',
                fontSize: 20,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
