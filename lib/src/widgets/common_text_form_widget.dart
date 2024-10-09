import '../../import.dart';

class CommonTextFormWidget extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final String? hint;
  final TextInputType? inputType;
  const CommonTextFormWidget(
      {required this.controller, required this.title, this.hint,this.inputType, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
          ),
          sizedBoxHeight05,
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: controller,
              keyboardType: inputType,
              decoration: InputDecoration(
                
                hintText: hint,
                hintStyle: GoogleFonts.poppins(color: cBorderGrey,fontWeight: FontWeight.w300),
                // alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: cBorderGrey,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
