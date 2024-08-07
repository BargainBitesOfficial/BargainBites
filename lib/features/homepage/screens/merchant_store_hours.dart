import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_styles.dart';

class StoreHoursPage extends StatefulWidget {
  final String merchantId;
  final String merchantName;

  StoreHoursPage({required this.merchantId, required this.merchantName});

  @override
  _StoreHoursPageState createState() => _StoreHoursPageState();
}

class _StoreHoursPageState extends State<StoreHoursPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = true; // Flag to indicate if data is being loaded
  bool isError = false; // Flag to indicate if an error occurred

  Map<String, StoreTiming> storeHours = {
    'Monday': StoreTiming(day: 'Monday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Tuesday': StoreTiming(day: 'Tuesday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Wednesday': StoreTiming(day: 'Wednesday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Thursday': StoreTiming(day: 'Thursday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Friday': StoreTiming(day: 'Friday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Saturday': StoreTiming(day: 'Saturday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Sunday': StoreTiming(day: 'Sunday', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
  };

  @override
  void initState() {
    super.initState();
    _fetchStoreHours();
  }

  Future<void> _fetchStoreHours() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('Merchants')
          .doc(widget.merchantId)
          .get();

      if (snapshot.exists && snapshot.data()!.containsKey('storeTiming')) {
        Map<String, StoreTiming> fetchedHours = (snapshot.data()!['storeTiming'] as Map<String, dynamic>).map((key, value) {
          var v = Map<String, String>.from(value);
          return MapEntry(key, StoreTiming.fromMap(v));
        });
        setState(() {
          storeHours = fetchedHours;
          isLoading = false; // Data loaded successfully
        });
      } else {
        setState(() {
          isLoading = false; // Data loaded but storeTiming key not found
        });
      }
    } catch (e) {
      setState(() {
        isError = true;
        isLoading = false; // Error occurred during data fetching
      });
    }
  }

  void _saveStoreHours() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Convert storeHours map to a format suitable for Firestore
      Map<String, Map<String, String>> storeHoursData = storeHours.map((key, value) => MapEntry(key, value.toMap()));

      // Save to Firestore
      await FirebaseFirestore.instance.collection('Merchants').doc(widget.merchantId).update({
        'storeTiming': storeHoursData,
      });

      print("Store hours updated successfully!");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Store hours updated successfully', style: TextStyle(fontFamily: "Poppins")),
          backgroundColor: TColors.primary,
        ),
      );
    }
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(
        hour: int.parse(controller.text.split(":")[0]),
        minute: int.parse(controller.text.split(":")[1].split(" ")[0]),
      ),
    );
    if (picked != null) {
      final localizations = MaterialLocalizations.of(context);
      final formattedTime = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);
      setState(() {
        controller.text = formattedTime;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.primary,
          title: Text(widget.merchantName, style: TextStyles.regulartext(color: TColors.bWhite)),
        ),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (isError) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: TColors.primary,
          title: Text(widget.merchantName, style: TextStyles.regulartext(color: TColors.bWhite)),
        ),
        body: Center(child: Text('Error: Failed to load store hours')),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text(widget.merchantName, style: TextStyles.regulartext(color: TColors.bWhite)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Center(
                child: Text(
                  'Standard Hours',
                  style: TextStyles.heading(color: TColors.bBlack),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView(
                  children: storeHours.keys.map((day) {
                    return StoreHourTile(
                      storeHour: storeHours[day]!,
                      onChanged: (updatedStoreHour) {
                        setState(() {
                          storeHours[day] = updatedStoreHour;
                        });
                      },
                    );
                  }).toList(),
                ),
              ),
              Center(
                child: ElevatedButton(
                  onPressed: _saveStoreHours,
                  child: Text('Update Store Hours', style: TextStyles.button()),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    backgroundColor: TColors.primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class StoreHourTile extends StatefulWidget {
  final StoreTiming storeHour;
  final ValueChanged<StoreTiming> onChanged;

  StoreHourTile({required this.storeHour, required this.onChanged});

  @override
  _StoreHourTileState createState() => _StoreHourTileState();
}

class _StoreHourTileState extends State<StoreHourTile> {
  late bool isOpen;
  late TextEditingController openTimeController;
  late TextEditingController closeTimeController;

  @override
  void initState() {
    super.initState();
    isOpen = widget.storeHour.isOpen;
    openTimeController = TextEditingController(text: widget.storeHour.openTime);
    closeTimeController = TextEditingController(text: widget.storeHour.closeTime);
  }

  @override
  void dispose() {
    openTimeController.dispose();
    closeTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(BuildContext context, TextEditingController controller) async {
    if (isOpen) {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: TimeOfDay(
          hour: int.parse(controller.text.split(":")[0]),
          minute: int.parse(controller.text.split(":")[1].split(" ")[0]),
        ),
      );
      if (picked != null) {
        final localizations = MaterialLocalizations.of(context);
        final formattedTime = localizations.formatTimeOfDay(picked, alwaysUse24HourFormat: false);
        setState(() {
          controller.text = formattedTime;
          widget.onChanged(widget.storeHour.copyWith(
            openTime: controller == openTimeController ? formattedTime : widget.storeHour.openTime,
            closeTime: controller == closeTimeController ? formattedTime : widget.storeHour.closeTime,
          ));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Expanded(
            child: Text(widget.storeHour.day, style: TextStyles.name(color: TColors.bBlack)),
          ),
          Switch(
            value: isOpen,
            onChanged: (value) {
              setState(() {
                isOpen = value;
                widget.onChanged(widget.storeHour.copyWith(isOpen: isOpen));
              });
            },
            activeColor: TColors.bGreen,
          ),
          Text(isOpen ? 'Open' : 'Closed', style: TextStyles.regulartext(color: TColors.bBlack)),
          SizedBox(width: 10),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: openTimeController,
              decoration: InputDecoration(
                hintText: '00:00 AM',
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: !isOpen,
              onTap: () {
                if (isOpen) _selectTime(context, openTimeController);
              },
              validator: (value) {
                if (isOpen && (value == null || value.isEmpty)) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  widget.onChanged(widget.storeHour.copyWith(openTime: value));
                }
              },
            ),
          ),
          SizedBox(width: 5),
          Text(' - ', style: TextStyles.regulartext(color: TColors.bBlack)),
          SizedBox(width: 5),
          SizedBox(
            width: 80,
            child: TextFormField(
              controller: closeTimeController,
              decoration: InputDecoration(
                hintText: '08:00 PM',
                contentPadding: EdgeInsets.symmetric(horizontal: 5),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              readOnly: !isOpen,
              onTap: () {
                if (isOpen) _selectTime(context, closeTimeController);
              },
              validator: (value) {
                if (isOpen && (value == null || value.isEmpty)) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                if (value != null) {
                  widget.onChanged(widget.storeHour.copyWith(closeTime: value));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoreTiming {
  final String day;
  final bool isOpen;
  final String? openTime;
  final String? closeTime;

  StoreTiming({required this.day, required this.isOpen, this.openTime, this.closeTime});

  StoreTiming copyWith({
    String? day,
    bool? isOpen,
    String? openTime,
    String? closeTime,
  }) {
    return StoreTiming(
      day: day ?? this.day,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  Map<String, String> toMap() {
    return {
      'day': day,
      'isOpen': isOpen.toString(),
      'openTime': openTime ?? '',
      'closeTime': closeTime ?? '',
    };
  }

  factory StoreTiming.fromMap(Map<String, String> map) {
    return StoreTiming(
      day: map['day']!,
      isOpen: map['isOpen'] == 'true',
      openTime: map['openTime'],
      closeTime: map['closeTime'],
    );
  }

  @override
  String toString() {
    return '$day: ${isOpen ? 'Open from $openTime to $closeTime' : 'Closed'}';
  }
}
