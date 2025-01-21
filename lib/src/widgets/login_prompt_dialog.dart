import '../../import.dart';

class LoginPromptDialog extends StatelessWidget {
  const LoginPromptDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Not Logged In'),
      content: const Text('You are not logged in. Please login to continue.'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const MobileNumberScreen(),
              ),
            );
            // Add your login navigation logic here
            // For example:
            // Navigator.pushNamed(context, '/login');
          },
          child: const Text('Login'),
        ),
      ],
    );
  }
}
