import '../../../../import.dart';

class ProductRatingScreen extends StatelessWidget {
  const ProductRatingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: const CommonTextWidget(
          title: 'Product Ratings',
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Consumer<ProductRatingProvider>(
                builder: (context, provider, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CommonTextWidget(
                        title: 'Please give rating*',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return IconButton(
                            icon: Icon(
                              Icons.star,
                              size: 40,
                              color: index < provider.rating
                                  ? cButtonGreen
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              provider.setRating(index);
                            },
                          );
                        }),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        maxLength: 50,
                        maxLines: 2,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(),
                          hintStyle: GoogleFonts.poppins(),
                          labelText: 'Review Title*',
                          hintText: 'Max 50 Characters',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        maxLength: 300,
                        maxLines: 4,
                        decoration: InputDecoration(
                          labelStyle: GoogleFonts.poppins(),
                          hintStyle: GoogleFonts.poppins(),
                          labelText: 'Comment*',
                          hintText: 'Max 300 Characters',
                          border: const OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 20),
                      const CommonTextWidget(
                        title: 'Will you recommend this product*',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Radio<String>(
                            
                            value: "Yes",
                            groupValue: provider.recommend,
                            activeColor: cButtonGreen,
                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              provider.setRecommend(value);
                            },
                          ),
                          const CommonTextWidget(title: 'YES'),
                          const SizedBox(width: 20),
                          Radio<String>(
                            // fillColor: cButtonGreen,
                            value: "No",
                            groupValue: provider.recommend,
                            activeColor: cButtonGreen,

                            onChanged: (value) {
                              if (value == null) {
                                return;
                              }
                              provider.setRecommend(value);
                            },
                          ),
                          const CommonTextWidget(title: 'NO'),
                        ],
                      ),
                      sizedBoxHeight70,
                      sizedBoxHeight70,
                      sizedBoxHeight70,
                      // const Spacer(),
                    ],
                  );
                },
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 60,
              color: cWhiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SizedBox(
                    width: 183,
                    height: 48,
                    child: CustomizableBorderColoredButton(
                        title: 'CANCEL', event: () {}),
                  ),
                  SizedBox(
                    width: 183,
                    height: 48,
                    child: CustomizableButton(
                      title: 'SUBMIT',
                      event: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => const ProductRatingScreen(),
                        //     ));
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
