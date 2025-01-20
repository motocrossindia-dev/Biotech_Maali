import '../../../import.dart';

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
  List<JobListing> _nonTechJobs = [
    JobListing(
      title: 'HR Manager',
      description: 'Looking for an experienced HR professional to lead our human resources department.',
      location: 'Mumbai, India',
      experience: '5+ years',
      requirements: [
        'Bachelor\'s degree in HR or related field',
        'Experience in talent acquisition and retention',
        'Strong communication skills',
        'Knowledge of labor laws and regulations'
      ],
    ),
    JobListing(
      title: 'Marketing Specialist',
      description: 'Join our marketing team to develop and execute marketing strategies for biotech products.',
      location: 'Bangalore, India',
      experience: '3+ years',
      requirements: [
        'Bachelor\'s degree in Marketing',
        'Digital marketing experience',
        'Content creation skills',
        'Experience in healthcare/biotech sector preferred'
      ],
    ),
    JobListing(
      title: 'Finance Analyst',
      description: 'Seeking a detail-oriented finance analyst to join our growing team.',
      location: 'Delhi, India',
      experience: '2+ years',
      requirements: [
        'Bachelor\'s degree in Finance/Accounting',
        'Proficiency in Excel and financial modeling',
        'Experience with financial reporting',
        'Knowledge of accounting principles'
      ],
    ),
  ];

  List<JobListing> _techJobs = [
    JobListing(
      title: 'Senior Flutter Developer',
      description: 'Looking for an experienced Flutter developer to lead mobile app development.',
      location: 'Bangalore, India',
      experience: '4+ years',
      requirements: [
        'Strong experience with Flutter and Dart',
        'Knowledge of state management solutions',
        'Experience with REST APIs',
        'Understanding of mobile app architecture'
      ],
    ),
    JobListing(
      title: 'Backend Developer',
      description: 'Join our backend team to develop scalable APIs and services.',
      location: 'Hyderabad, India',
      experience: '3+ years',
      requirements: [
        'Experience with Node.js/Python',
        'Database design and optimization',
        'Knowledge of cloud services (AWS/GCP)',
        'Understanding of microservices architecture'
      ],
    ),
    JobListing(
      title: 'DevOps Engineer',
      description: 'Seeking a DevOps engineer to improve our deployment and infrastructure.',
      location: 'Mumbai, India',
      experience: '3+ years',
      requirements: [
        'Experience with Docker and Kubernetes',
        'Knowledge of CI/CD pipelines',
        'Infrastructure as Code experience',
        'Cloud platform expertise (AWS/GCP)'
      ],
    ),
  ];
  
  List<JobListing> get nonTechJobs => _nonTechJobs;
  List<JobListing> get techJobs => _techJobs;
  
  void setJobs({List<JobListing>? nonTechJobs, List<JobListing>? techJobs}) {
    if (nonTechJobs != null) _nonTechJobs = nonTechJobs;
    if (techJobs != null) _techJobs = techJobs;
    notifyListeners();
  }
}