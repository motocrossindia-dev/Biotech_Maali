import 'package:biotech_maali/src/other_modules/carrers/carriers_provider.dart';
import '../../../import.dart';

class CarrersScreen extends StatefulWidget {
  const CarrersScreen({super.key});

  @override
  State<CarrersScreen> createState() => _CarrersScreenState();
}

class _CarrersScreenState extends State<CarrersScreen> {
  static const Color themeColor = Color(0xFF749F09);

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<CarrersProvider>().loadCarriers(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Careers'),
        backgroundColor: Colors.white,
        foregroundColor: themeColor,
        elevation: 0,
      ),
      backgroundColor: Colors.grey.shade100,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            color: Colors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shape the Future with Biotech Maali',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Explore exciting career opportunities and join our team!',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: DefaultTabController(
              length: 2,
              child: Column(
                children: [
                  Container(
                    color: Colors.white,
                    child: const TabBar(
                      tabs: [
                        Tab(text: 'Non-Tech Positions'),
                        Tab(text: 'Technology Positions'),
                      ],
                      labelColor: themeColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: themeColor,
                      indicatorWeight: 3,
                      labelStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: TabBarView(
                      children: [
                        _JobListingsTab(isNonTech: true),
                        _JobListingsTab(isNonTech: false),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _JobListingsTab extends StatelessWidget {
  final bool isNonTech;
  static const Color themeColor = Color(0xFF749F09);

  const _JobListingsTab({required this.isNonTech});

  @override
  Widget build(BuildContext context) {
    return Consumer<CarrersProvider>(
      builder: (context, provider, child) {
        if (provider.isLoading) {
          return const Center(
              child: CircularProgressIndicator(color: themeColor));
        }

        final jobs = isNonTech ? provider.nonTechJobs : provider.techJobs;

        if (jobs.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/svg/images/empty_data.svg',
                  width: 100,
                  height: 100,
                  color: themeColor.withOpacity(0.5),
                ),
                const SizedBox(height: 16),
                const Text(
                  'No openings currently',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Stay tuned for future opportunities!',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
                side: BorderSide(color: themeColor.withOpacity(0.15), width: 1),
              ),
              margin: const EdgeInsets.only(bottom: 18),
              color: Colors.white,
              child: ExpansionTile(
                leading: const Icon(Icons.work, color: themeColor, size: 28),
                title: Text(
                  job.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                    color: themeColor,
                  ),
                ),
                subtitle: Text(
                  job.location,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          job.description,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Experience Required: ${job.experience}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: themeColor,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Requirements:',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                        const SizedBox(height: 8),
                        ...job.requirements.map(
                          (req) => Padding(
                            padding: const EdgeInsets.only(left: 16, bottom: 4),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• ',
                                    style: TextStyle(
                                        fontSize: 14, color: themeColor)),
                                Expanded(
                                  child: Text(req,
                                      style: const TextStyle(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: themeColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                            onPressed: () {
                              // Handle apply action
                            },
                            child: const Text('Apply Now'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
