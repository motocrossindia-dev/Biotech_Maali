class ServiceEnquiryModel {
  final String name;
  final String contact;
  final String location;
  final String service;
  final String message;

  ServiceEnquiryModel({
    required this.name,
    required this.contact,
    required this.location,
    required this.service,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'contact': contact,
      'location': location,
      'service': service,
      'message': message
    };
  }
}
