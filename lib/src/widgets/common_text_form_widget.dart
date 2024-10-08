import '../../import.dart';

class CommonTextFormWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hint;
  const CommonTextFormWidget(
      {required this.controller, required this.title, this.hint, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:30.0, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          sizedBoxHeight5,
          SizedBox(
            height: 45,
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: cBorderGrey,
                      ))),
            ),
          ),
        ],
      ),
    );
  }
}
