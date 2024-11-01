import '../../import.dart';

class CustomizableBorderColoredButton extends StatelessWidget {
  final String title;
  final VoidCallback? event;
  const CustomizableBorderColoredButton({required this.title, required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: cAppBackround,
    
        foregroundColor: cButtonGreen, // foreground
    
        shape: RoundedRectangleBorder(
          side: BorderSide(color: cButtonGreen, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
      onPressed: event,
      child: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
