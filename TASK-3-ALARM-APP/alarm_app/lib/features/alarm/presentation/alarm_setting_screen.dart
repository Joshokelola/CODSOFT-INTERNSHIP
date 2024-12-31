import 'dart:io';
import 'package:alarm_app/features/alarm/domain/alarm.dart';
import 'package:alarm_app/features/alarm/services/alarm_service.dart';
import 'package:alarm_app/core/utils/unique_id.dart';
import 'package:flutter/material.dart';

class AlarmSettingScreen extends StatefulWidget {
  @override
  _AlarmSettingScreenState createState() => _AlarmSettingScreenState();
}

class _AlarmSettingScreenState extends State<AlarmSettingScreen> {
  TimeOfDay _selectedTime = TimeOfDay.now();
  String _selectedTone = 'Default Tone';
  String _label = '';
  bool _isVibrationEnabled = true; // New

  final List<String> _alarmSounds = [
    'alarm2.mp3',
    'alarm3.mp3',
    'alarm4.mp3',
    'alarm5.mp3',
  ];

  @override
  Widget build(BuildContext context) {
    void _showSoundSelectionDialog() {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Alarm Sound'),
            content: Container(
              width: double.maxFinite,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _alarmSounds.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text(_alarmSounds[index]),
                    trailing: _selectedTone == _alarmSounds[index]
                        ? Icon(Icons.check,
                            color: Theme.of(context).colorScheme.primary)
                        : null,
                    onTap: () {
                      setState(() {
                        _selectedTone = _alarmSounds[index];
                      });
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        leading: IconButton(
          icon:
              Icon(Icons.close, color: Theme.of(context).colorScheme.onPrimary),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Alarm',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              var alarmModel = Alarm(
                id: UniqueIdGenerator.generateId().toString(),
                time: _selectedTime,
                label: _label,
                isActive: true,
                allowVibration: _isVibrationEnabled,
                alarmTone: _selectedTone,
              );
              debugPrint(alarmModel.alarmTone);
              await AlarmService.addAlarm(alarmModel);
              Navigator.pop(context);
            },
            child: Text(
              'Save',
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Time Picker Section
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 32),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  GestureDetector(
                    onTap: () async {
                      final TimeOfDay? time = await showTimePicker(
                        context: context,
                        initialTime: _selectedTime,
                      );
                      if (time != null) {
                        if (!AlarmService.isValidAlarmTime(
                            AlarmService.timeOfDayToDateTime(time))) {
                          showDialog(
                            // ignore: use_build_context_synchronously
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('Invalid Time'),
                              content: const Text(
                                  'The alarm time must be later than the current time.'),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('OK'),
                                ),
                              ],
                            ),
                          );
                        } else {
                          setState(() => _selectedTime = time);
                        }
                      }
                    },
                    child: Text(
                      '${_selectedTime.hour.toString().padLeft(2, '0')}:${_selectedTime.minute.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 60,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Settings Section
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Alarm Settings',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Label Input
                  TextField(
                    onChanged: (value) => setState(() => _label = value),
                    decoration: InputDecoration(
                      labelText: 'Label',
                      prefixIcon: Icon(Icons.label_outline),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      filled: true,
                      fillColor: Theme.of(context).colorScheme.surface,
                    ),
                  ),
                  SizedBox(height: 16),

                  // Alarm Tone Selection
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.music_note),
                      title: Text('Alarm Sound'),
                      subtitle: Text(_selectedTone),
                      trailing: Icon(Icons.chevron_right),
                      onTap: _showSoundSelectionDialog,
                    ),
                  ),
                  SizedBox(height: 8),

                  // Vibration Option
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: Icon(Icons.vibration),
                      title: Text('Vibration'),
                      trailing: Switch(
                        value: _isVibrationEnabled,
                        onChanged: (value) {
                          setState(() {
                            _isVibrationEnabled = value;
                          });
                        },
                        activeColor: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
