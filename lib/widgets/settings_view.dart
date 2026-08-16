import 'package:flutter/material.dart';
import 'package:adhan/adhan.dart';
import '../models/app_theme.dart';
import '../notifiers/theme_notifier.dart';
import '../services/settings_service.dart';

class SettingsView extends StatefulWidget {
  final VoidCallback? onSettingsChanged;

  const SettingsView({super.key, this.onSettingsChanged});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  Madhab _selectedMadhab = Madhab.hanafi;
  AppTheme _selectedTheme = AppTheme.system;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      final madhab = await SettingsService.getMadhab();
      final theme = await SettingsService.getTheme();
      if (mounted) {
        setState(() {
          _selectedMadhab = madhab;
          _selectedTheme = theme;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to load settings: $e')),
        );
      }
    }
  }

  Future<void> _saveMadhab(Madhab? value) async {
    if (value == null) return;
    setState(() => _selectedMadhab = value);
    await SettingsService.setMadhab(value);
    widget.onSettingsChanged?.call();
  }

  Future<void> _saveTheme(AppTheme? value) async {
    if (value == null) return;
    setState(() => _selectedTheme = value);
    await themeNotifier.updateTheme(value);
    widget.onSettingsChanged?.call();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'Asr Calculation Method',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        RadioListTile<Madhab>(
          title: const Text('Hanafi (Standard in South Asia)'),
          subtitle: const Text('Asr time starts when the shadow is twice the length of the object.'),
          value: Madhab.hanafi,
          groupValue: _selectedMadhab,
          onChanged: _saveMadhab,
          activeColor: Colors.deepPurple,
        ),
        RadioListTile<Madhab>(
          title: const Text('Shafi / Maliki / Hanbali'),
          subtitle: const Text('Asr time starts when the shadow is equal to the length of the object.'),
          value: Madhab.shafi,
          groupValue: _selectedMadhab,
          onChanged: _saveMadhab,
          activeColor: Colors.deepPurple,
        ),
        const Divider(),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            'App Theme',
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.deepPurple,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        RadioListTile<AppTheme>(
          title: const Text('System Default'),
          value: AppTheme.system,
          groupValue: _selectedTheme,
          onChanged: _saveTheme,
          activeColor: Colors.deepPurple,
        ),
        RadioListTile<AppTheme>(
          title: const Text('Light'),
          value: AppTheme.light,
          groupValue: _selectedTheme,
          onChanged: _saveTheme,
          activeColor: Colors.deepPurple,
        ),
        RadioListTile<AppTheme>(
          title: const Text('Dark'),
          value: AppTheme.dark,
          groupValue: _selectedTheme,
          onChanged: _saveTheme,
          activeColor: Colors.deepPurple,
        ),
        const Divider(),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Note: Changes will be applied immediately.',
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic, color: Colors.grey),
          ),
        ),
      ],
    );
  }
}
