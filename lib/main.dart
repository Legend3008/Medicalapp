import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/doctor_appointment_screen.dart';
import 'screens/bed_booking_screen.dart';
import 'screens/doctor_listing_screen.dart';
import 'screens/prescription_management_screen.dart';
import 'screens/medical_records_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/auth_screen.dart';
import 'screens/doctor_profile_screen.dart';
import 'screens/lab_tests_screen.dart';
import 'services/appointment_service.dart';
import 'services/doctor_service.dart';
import 'services/prescription_service.dart';
import 'services/medical_records_service.dart';
import 'services/auth_service.dart';
import 'providers/user_provider.dart';
import 'providers/theme_provider.dart';
import 'models/doctor.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await initializeServices();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        Provider<AppointmentService>(create: (_) => AppointmentService()),
        Provider<DoctorService>(create: (_) => DoctorService()),
        Provider<PrescriptionService>(create: (_) => PrescriptionService()),
        Provider<MedicalRecordsService>(create: (_) => MedicalRecordsService()),
        Provider<AuthService>(create: (_) => AuthService()),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> initializeServices() async {
  // Initialize any required services, databases, or configurations
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Medical App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: themeProvider.isDarkMode ? Brightness.dark : Brightness.light,
            ),
            appBarTheme: const AppBarTheme(
              centerTitle: true,
              elevation: 0,
            ),
            cardTheme: CardTheme(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              filled: true,
            ),
            chipTheme: const ChipThemeData(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            ),
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.blue,
              brightness: Brightness.dark,
            ),
            // Dark theme configurations...
          ),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: Consumer<UserProvider>(
            builder: (context, userProvider, child) {
              return StreamBuilder(
                stream: AuthService().authStateChanges,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const SplashScreen();
                  }
                  
                  if (snapshot.hasData) {
                    return const HomeScreen();
                  }
                  
                  return const AuthScreen();
                },
              );
            },
          ),
          routes: {
            '/home': (context) => const HomeScreen(),
            '/doctors': (context) => const DoctorListingScreen(),
            '/prescriptions': (context) => const PrescriptionManagementScreen(),
            '/medical_records': (context) => const MedicalRecordsScreen(),
            '/profile': (context) => const ProfileScreen(),
            '/settings': (context) => const SettingsScreen(),
            '/appointments': (context) => const DoctorAppointmentScreen(),
            '/bed_booking': (context) => const BedBookingScreen(),
            '/lab_tests': (context) => const LabTestsScreen(),
          },
          onGenerateRoute: (settings) {
            if (settings.name?.startsWith('/doctor/') ?? false) {
              final doctorId = settings.name!.split('/').last;
              return MaterialPageRoute(
                builder: (context) => FutureBuilder<Doctor>(
                  future: DoctorService().getDoctorById(doctorId),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return DoctorProfileScreen(doctor: snapshot.data!);
                    }
                    return const Center(child: CircularProgressIndicator());
                  },
                ),
              );
            }
            return null;
          },
        );
      },
    );
  }
}

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}