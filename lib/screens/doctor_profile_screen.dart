import 'package:flutter/material.dart';
import '../models/doctor.dart';
import '../widgets/rating_stars.dart';
import '../widgets/availability_calendar.dart';
import '../models/review.dart';
import '../services/appointment_service.dart';

class DoctorProfileScreen extends StatefulWidget {
  final Doctor doctor;

  const DoctorProfileScreen({super.key, required this.doctor});

  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final AppointmentService _appointmentService = AppointmentService();
  bool _isFavorite = false;
  DateTime? _selectedDate;
  String? _selectedTimeSlot;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _buildDoctorInfo(),
                _buildQuickActions(),
                _buildTabBar(),
              ],
            ),
          ),
          SliverFillRemaining(
            child: TabBarView(
              controller: _tabController,
              children: [
                _buildAboutTab(),
                _buildAvailabilityTab(),
                _buildReviewsTab(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomBar(),
    );
  }

  Widget _buildSliverAppBar() {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            Hero(
              tag: 'doctor_${widget.doctor.id}',
              child: Image.network(
                widget.doctor.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        ),
        title: Text(widget.doctor.name),
      ),
      actions: [
        IconButton(
          icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
          onPressed: () => setState(() => _isFavorite = !_isFavorite),
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: _shareDoctorProfile,
        ),
      ],
    );
  }

  Widget _buildDoctorInfo() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.doctor.name,
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      widget.doctor.specialty,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              RatingStars(
                rating: widget.doctor.rating,
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoCard(),
        ],
      ),
    );
  }

  Widget _buildInfoCard() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildInfoItem(
              icon: Icons.work,
              label: 'Experience',
              value: '${widget.doctor.experience}+ years',
            ),
            _buildInfoItem(
              icon: Icons.people,
              label: 'Patients',
              value: '1000+',
            ),
            _buildInfoItem(
              icon: Icons.star,
              label: 'Rating',
              value: widget.doctor.rating.toString(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon, color: Theme.of(context).primaryColor),
        const SizedBox(height: 8),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildActionButton(
            icon: Icons.video_call,
            label: 'Video\nConsult',
            onTap: () => _startVideoConsultation(),
          ),
          _buildActionButton(
            icon: Icons.chat,
            label: 'Chat\nNow',
            onTap: () => _startChat(),
          ),
          _buildActionButton(
            icon: Icons.directions,
            label: 'Get\nDirections',
            onTap: () => _showDirections(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
            child: Icon(icon, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildTabBar() {
    return TabBar(
      controller: _tabController,
      tabs: const [
        Tab(text: 'About'),
        Tab(text: 'Availability'),
        Tab(text: 'Reviews'),
      ],
    );
  }

  Widget _buildAboutTab() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        _buildSectionTitle('About Doctor'),
        const Text(
          'Dr. Smith is a board-certified physician with extensive experience...',
        ),
        _buildSectionTitle('Specializations'),
        _buildSpecializations(),
        _buildSectionTitle('Education'),
        _buildEducation(),
        _buildSectionTitle('Languages'),
        _buildLanguages(),
      ],
    );
  }

  Widget _buildAvailabilityTab() {
    return Column(
      children: [
        AvailabilityCalendar(
          onDateSelected: (date) => setState(() => _selectedDate = date),
        ),
        if (_selectedDate != null) _buildTimeSlots(),
      ],
    );
  }

  Widget _buildReviewsTab() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 10,
      itemBuilder: (context, index) => _buildReviewCard(
        Review(
          userName: 'Patient $index',
          rating: 4.5,
          comment: 'Great doctor, very professional and knowledgeable.',
          date: DateTime.now().subtract(Duration(days: index)),
        ),
      ),
    );
  }

  Widget _buildBottomBar() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton(
          onPressed: _selectedDate != null && _selectedTimeSlot != null
              ? _bookAppointment
              : null,
          child: const Text('Book Appointment'),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge,
      ),
    );
  }

  Widget _buildSpecializations() {
    return Wrap(
      spacing: 8,
      children: [
        'Cardiology',
        'Heart Surgery',
        'Cardiac Rehabilitation',
        'Vascular Medicine'
      ].map((spec) => Chip(label: Text(spec))).toList(),
    );
  }

  Widget _buildEducation() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          leading: const Icon(Icons.school),
          title: const Text('MBBS - Medical University'),
          subtitle: const Text('2010-2016'),
        ),
        ListTile(
          leading: const Icon(Icons.school),
          title: const Text('MD - Cardiology'),
          subtitle: const Text('2016-2019'),
        ),
      ],
    );
  }

  Widget _buildLanguages() {
    return Wrap(
      spacing: 8,
      children: [
        'English',
        'Spanish',
        'French'
      ].map((lang) => Chip(
        avatar: const Icon(Icons.language, size: 16),
        label: Text(lang),
      )).toList(),
    );
  }

  Widget _buildTimeSlots() {
    return FutureBuilder<List<TimeOfDay>>(
      future: _appointmentService.getAvailableSlots(_selectedDate!),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final slots = snapshot.data ?? [];
        return Wrap(
          spacing: 8,
          children: slots.map((time) => ChoiceChip(
            label: Text('${time.hour}:${time.minute.toString().padLeft(2, '0')}'),
            selected: _selectedTimeSlot == time.toString(),
            onSelected: (selected) {
              setState(() => _selectedTimeSlot = selected ? time.toString() : null);
            },
          )).toList(),
        );
      },
    );
  }

  Widget _buildReviewCard(Review review) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        title: Row(
          children: [
            Text(review.userName),
            const Spacer(),
            RatingStars(rating: review.rating, size: 16),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(review.comment),
            Text(
              review.date.toString().split(' ')[0],
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }

  // Add implementation methods here...
  void _shareDoctorProfile() {
    // Implement share functionality
  }

  void _startVideoConsultation() {
    // Implement video consultation
  }

  void _startChat() {
    // Implement chat functionality
  }

  void _showDirections() {
    // Implement directions
  }

  Future<void> _bookAppointment() async {
    // Implement booking logic
  }
} 