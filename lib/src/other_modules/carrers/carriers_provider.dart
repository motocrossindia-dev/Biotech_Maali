import '../../../import.dart';
import 'carrier_model.dart';
import 'carriers_service.dart';

class JobListing {
  final String title;
  final String description;
  final String location;
  final String experience;
  final List<String> requirements;

  JobListing({
    required this.title,
    required this.description,
    required this.location,
    required this.experience,
    required this.requirements,
  });
}

class CarrersProvider with ChangeNotifier {
  final CarriersService _service = CarriersService();
  List<JobListing> _nonTechJobs = [];
  List<JobListing> _techJobs = [];
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  List<JobListing> get nonTechJobs => _nonTechJobs;
  List<JobListing> get techJobs => _techJobs;

  Future<void> loadCarriers() async {
    try {
      _isLoading = true;
      notifyListeners();

      final carriers = await _service.getCarriers();

      final techJobs = carriers
          .where((c) => c.categories == 'Tech Positions')
          .map((c) => JobListing(
                title: c.positionName,
                description: c.jobSummary,
                location: 'India', // Default location
                experience: 'Required',
                requirements: c.responsibilities
                    .split('\n')
                    .where((r) => r.trim().isNotEmpty)
                    .map((r) => r.trim())
                    .toList(),
              ))
          .toList();

      final nonTechJobs = carriers
          .where((c) => c.categories == 'Non-Tech Positions')
          .map((c) => JobListing(
                title: c.positionName,
                description: c.jobSummary,
                location: 'India', // Default location
                experience: 'Required',
                requirements: c.responsibilities
                    .split('\n')
                    .where((r) => r.trim().isNotEmpty)
                    .map((r) => r.trim())
                    .toList(),
              ))
          .toList();

      _techJobs = techJobs;
      _nonTechJobs = nonTechJobs;
    } catch (e) {
      // Handle error
      print('Error loading carriers: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
