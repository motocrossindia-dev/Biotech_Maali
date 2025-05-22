import 'package:biotech_maali/import.dart';
import 'package:biotech_maali/src/permission_handle/premission_handle_provider.dart';

class PermissionHandleScreen extends StatefulWidget {
  const PermissionHandleScreen({super.key});

  @override
  State<PermissionHandleScreen> createState() => _PermissionHandleScreenState();
}

class _PermissionHandleScreenState extends State<PermissionHandleScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PermissionHandleProvider>().checkPermissions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Consumer<PermissionHandleProvider>(
            builder: (context, provider, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    'Required Permissions',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Please grant the following permissions to use all features of the app',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 40),
                  _buildPermissionTile(
                    title: 'Location',
                    subtitle: 'Required for delivery and store locator',
                    isGranted: provider.locationPermission,
                    onRequest: provider.requestLocationPermission,
                    icon: Icons.location_on_outlined,
                  ),
                  _buildPermissionTile(
                    title: 'Storage',
                    subtitle: 'Required for saving images and files',
                    isGranted: provider.storagePermission,
                    onRequest: provider.requestStoragePermission,
                    icon: Icons.folder_outlined,
                  ),
                  _buildPermissionTile(
                    title: 'Camera',
                    subtitle:
                        'Required for scanning QR codes and taking photos',
                    isGranted: provider.cameraPermission,
                    onRequest: provider.requestCameraPermission,
                    icon: Icons.camera_alt_outlined,
                  ),
                  _buildPermissionTile(
                    title: 'Microphone',
                    subtitle: 'Required for voice search',
                    isGranted: provider.microphonePermission,
                    onRequest: provider.requestMicrophonePermission,
                    icon: Icons.mic_outlined,
                  ),
                  _buildPermissionTile(
                    title: 'Notifications',
                    subtitle: 'Required for order updates and offers',
                    isGranted: provider.notificationPermission,
                    onRequest: provider.requestNotificationPermission,
                    icon: Icons.notifications_outlined,
                  ),
                  const Spacer(),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: provider.allPermissionsGranted
                          ? () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              prefs.setBool('permissionGranted', true);
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BottomNavWidget(),
                                ),
                              );
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text('Continue'),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPermissionTile({
    required String title,
    required String subtitle,
    required bool isGranted,
    required Function() onRequest,
    required IconData icon,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: ListTile(
        leading: Icon(
          icon,
          size: 28,
          color: isGranted ? Colors.green : Colors.grey,
        ),
        title: Text(title),
        subtitle: Text(subtitle),
        trailing: ElevatedButton(
          onPressed: isGranted ? null : onRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: isGranted ? Colors.green : null,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(isGranted ? 'Granted' : 'Grant'),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
      ),
    );
  }
}
