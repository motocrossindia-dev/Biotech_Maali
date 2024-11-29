import 'import.dart';

class BiotechApp extends StatelessWidget {
  const BiotechApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MobileNumberProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create: (context) => BottomNavProvider()),
        ChangeNotifierProvider(create: (context) => HomeProvider()),
        ChangeNotifierProvider(create: (context) => ExploreProvider()),
        ChangeNotifierProvider(create: (context) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (context) => EditProfileProvider()),
        ChangeNotifierProvider(create: (context) => DeleteAccountProvider()),
        ChangeNotifierProvider(create: (context) => FiltersProvider()),
        ChangeNotifierProvider(create: (context) => ProductRatingProvider()),
        ChangeNotifierProvider(create: (context) => RatingAndReviewProvider()),
        ChangeNotifierProvider(create: (context)=> AddEditAddressProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: orderSummaryBackground),
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
