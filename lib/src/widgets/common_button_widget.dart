import '../../import.dart';

class CommonButtonWidget extends StatelessWidget {
 final String title;
 final VoidCallback? event;
  const CommonButtonWidget({required this.title,this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30,right: 30),
      child: SizedBox(
        width: double.infinity,
        height: 44,
        child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: cButtonGreen, // background
            foregroundColor: cButtonText, // foreground
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))
        ),
        onPressed: (){},
        child: Text(title),
        ),
      ),
    );
  }
}