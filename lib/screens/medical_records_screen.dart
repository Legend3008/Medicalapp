import 'package:flutter/material.dart';
import '../models/medical_record.dart';
import '../services/medical_records_service.dart';
import '../widgets/record_card.dart';
import 'package:file_picker/file_picker.dart';
import '../widgets/upload_progress_dialog.dart';
import '../widgets/add_record_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'record_viewer_screen.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> 
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MedicalRecordsService _recordsService = MedicalRecordsService();
  late Future<List<MedicalRecord>> _records;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _records = _recordsService.getRecords();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Medical Records'),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'All Records'),
            Tab(text: 'Lab Reports'),
            Tab(text: 'Prescriptions'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.upload_file),
            onPressed: () => _uploadNewRecord(),
          ),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRecordsList('all'),
          _buildRecordsList('lab'),
          _buildRecordsList('prescription'),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddRecordDialog(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildRecordsList(String type) {
    return FutureBuilder<List<MedicalRecord>>(
      future: _records,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text('Error: ${snapshot.error}'),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _records = _recordsService.getRecords();
                    });
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        final records = snapshot.data ?? [];
        final filteredRecords = type == 'all' 
            ? records 
            : records.where((record) => record.type == type).toList();

        if (filteredRecords.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.folder_open, size: 48, color: Colors.grey),
                const SizedBox(height: 16),
                const Text('No records found'),
                TextButton(
                  onPressed: () => _showAddRecordDialog(),
                  child: const Text('Add New Record'),
                ),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: filteredRecords.length,
          itemBuilder: (context, index) {
            return RecordCard(
              record: filteredRecords[index],
              onTap: () => _viewRecord(filteredRecords[index]),
              onDelete: () => _deleteRecord(filteredRecords[index].id),
              onShare: () => _shareRecord(filteredRecords[index]),
            );
          },
        );
      },
    );
  }

  Future<void> _uploadNewRecord() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'jpg', 'png'],
      );

      if (result != null) {
        // Show upload progress dialog
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return const UploadProgressDialog();
          },
        );

        // Upload file
        await _recordsService.uploadRecord(result.files.first);

        // Refresh records
        setState(() {
          _records = _recordsService.getRecords();
        });

        // Hide progress dialog
        Navigator.pop(context);

        // Show success message
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record uploaded successfully')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error uploading record: $e')),
      );
    }
  }

  Future<void> _showAddRecordDialog() async {
    final result = await showDialog<MedicalRecord>(
      context: context,
      builder: (BuildContext context) {
        return const AddRecordDialog();
      },
    );

    if (result != null) {
      setState(() {
        _records = _recordsService.getRecords();
      });
    }
  }

  Future<void> _deleteRecord(String recordId) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Record'),
          content: const Text('Are you sure you want to delete this record?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await _recordsService.deleteRecord(recordId);
        setState(() {
          _records = _recordsService.getRecords();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Record deleted successfully')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error deleting record: $e')),
        );
      }
    }
  }

  Future<void> _shareRecord(MedicalRecord record) async {
    try {
      await Share.shareFiles(
        [record.filePath],
        text: 'Medical Record - ${record.title}',
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Record shared successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error sharing record: $e')),
      );
    }
  }

  void _viewRecord(MedicalRecord record) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RecordViewerScreen(record: record),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}