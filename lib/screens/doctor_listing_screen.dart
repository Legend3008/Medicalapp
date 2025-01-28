import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/doctor_card.dart';
import '../services/doctor_service.dart';
import '../widgets/doctor_filter_sheet.dart';
import 'doctor_profile_screen.dart';

class DoctorListingScreen extends StatefulWidget {
  const DoctorListingScreen({super.key});

  @override
  State<DoctorListingScreen> createState() => _DoctorListingScreenState();
}

class _DoctorListingScreenState extends State<DoctorListingScreen> {
  final DoctorService _doctorService = DoctorService();
  late Future<List<Doctor>> _doctors;
  String _selectedSpecialty = 'All';
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _doctors = _doctorService.getDoctors();
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search doctors...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          setState(() {
            _doctors = _doctorService.searchDoctors(value);
          });
        },
      ),
    );
  }

  Widget _buildSpecialtyFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          'All',
          'Cardiology',
          'Neurology',
          'Orthopedics',
          'Pediatrics',
          'Dermatology'
        ].map((specialty) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(specialty),
              selected: _selectedSpecialty == specialty,
              onSelected: (selected) {
                setState(() {
                  _selectedSpecialty = specialty;
                  _doctors = _doctorService.filterDoctorsBySpecialty(specialty);
                });
              },
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Find Doctors'),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              // Show advanced filters
              _showFilterBottomSheet(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildSpecialtyFilter(),
          Expanded(
            child: FutureBuilder<List<Doctor>>(
              future: _doctors,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                }

                final doctors = snapshot.data ?? [];
                
                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: doctors.length,
                  itemBuilder: (context, index) {
                    return DoctorCard(
                      doctor: doctors[index],
                      onTap: () => _navigateToDoctorProfile(doctors[index]),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.9,
        minChildSize: 0.5,
        builder: (_, controller) => const DoctorFilterSheet(),
      ),
    );
  }

  void _navigateToDoctorProfile(Doctor doctor) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DoctorProfileScreen(doctor: doctor),
      ),
    );
  }
}