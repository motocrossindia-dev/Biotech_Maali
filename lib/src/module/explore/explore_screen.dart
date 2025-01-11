import '../../../import.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cScaffoldBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 4,
        shadowColor: Colors.black,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Categories',
          style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w400),
        ),
      ),
      body: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                    height: 650,
                    child: ExploreCategoryWidget(),
                  )
                ],
              ),
            ),
          ),
          SubCategories()
        ],
      ),
    );
  }
}
