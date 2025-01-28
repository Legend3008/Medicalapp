import 'package:flutter/material.dart';

class DoctorFilterSheet extends StatefulWidget {
  const DoctorFilterSheet({super.key});

  @override
  State<DoctorFilterSheet> createState() => _DoctorFilterSheetState();
}

class _DoctorFilterSheetState extends State<DoctorFilterSheet> {
  RangeValues _experienceRange = const RangeValues(0, 30);
  double _rating = 3.0;
  String _selectedGender = 'Any';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Experience (years)', style: TextStyle(fontSize: 16)),
          RangeSlider(
            values: _experienceRange,
            min: 0,
            max: 30,
            divisions: 30,
            labels: RangeLabels(
              _experienceRange.start.round().toString(),
              _experienceRange.end.round().toString(),
            ),
            onChanged: (values) => setState(() => _experienceRange = values),
          ),
          const Text('Minimum Rating', style: TextStyle(fontSize: 16)),
          Slider(
            value: _rating,
            min: 0,
            max: 5,
            divisions: 10,
            label: _rating.toString(),
            onChanged: (value) => setState(() => _rating = value),
          ),
          const Text('Gender', style: TextStyle(fontSize: 16)),
          SegmentedButton<String>(
            segments: const [
              ButtonSegment(value: 'Any', label: Text('Any')),
              ButtonSegment(value: 'Male', label: Text('Male')),
              ButtonSegment(value: 'Female', label: Text('Female')),
            ],
            selected: {_selectedGender},
            onSelectionChanged: (Set<String> value) {
              setState(() => _selectedGender = value.first);
            },
          ),
        ],
      ),
    );
  }
} 