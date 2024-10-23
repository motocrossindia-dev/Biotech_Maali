import '../../import.dart';

class CommonTextWidget extends StatelessWidget {
  final String title;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextDecoration? lineThrough;
  final TextAlign? textAlign;
  const CommonTextWidget(
      {required this.title,
      this.fontSize,
      this.fontWeight,
      this.color,
      this.lineThrough,
      this.textAlign,
      super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      
      title,
      style: GoogleFonts.poppins(
          fontSize: fontSize, fontWeight: fontWeight, color: color, decoration: lineThrough,),
          textAlign: textAlign,
    );
  }
}
