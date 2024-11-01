import '../../../../import.dart';

class SizeIconWidget extends StatelessWidget {
  final String name;
  final VoidCallback event;

  const SizeIconWidget({required this.name,required this.event, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        
        InkWell(
          onTap: event,
          child: Container(
            decoration: BoxDecoration(
               border: Border.all(color: cButtonGreen),
               borderRadius: BorderRadius.circular(6)
            ),
            child:  Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10,top: 10,bottom: 10),
          
              child:  CommonTextWidget(
                title: name,
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}