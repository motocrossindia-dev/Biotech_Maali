import '../../../../../import.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: cButtonGreen,
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(5))),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CommonTextWidget(
                        title: 'About The Product',
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: cButtonGreen)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CommonTextWidget(
                        title: "What's in the box",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: cButtonGreen)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CommonTextWidget(
                        title: "Video",
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        // color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: CommonTextWidget(
                title:
                    'Are you a sucker for succulents? Then the Mini Jade succulent will be your dream plant! As one of the easiest houseplants to look after, the Crassula Green Mini plant boasts a lush foliage which beautifies any room. The Jade is also considered lucky as per Feng Shui for its coin-like round plump leaves. So, go ahead and bring Jade home… luck just tags along!', textAlign: TextAlign.justify,),
          ),
        ],
      ),
    );
  }
}
