import 'package:flutter/material.dart';
import '../../../utils/constants/colors.dart';
import '../../../utils/constants/text_styles.dart';






class StoreHoursPage extends StatefulWidget {
  @override
  _StoreHoursPageState createState() => _StoreHoursPageState();
}

class _StoreHoursPageState extends State<StoreHoursPage> {
  final _formKey = GlobalKey<FormState>();

  Map<String, StoreHour> storeHours = {
    'Monday': StoreHour(day: 'Mon', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Tuesday': StoreHour(day: 'Tues', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Wednesday': StoreHour(day: 'Wed', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Thursday': StoreHour(day: 'Thur', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Friday': StoreHour(day: 'Fri', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Saturday': StoreHour(day: 'Sat', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
    'Sunday': StoreHour(day: 'Sun', isOpen: false, openTime: '00:00 AM', closeTime: '00:00 PM'),
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TColors.primary,
        title: Text("Hi, Circle K", style: TextStyles.regulartext(color: TColors.bWhite)),
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
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      // Handle the form submission, e.g., save to the database
                      print(storeHours);
                    }
                  },
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
  final StoreHour storeHour;
  final ValueChanged<StoreHour> onChanged;

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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                widget.onChanged(widget.storeHour.copyWith(openTime: value));
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
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Required';
                }
                return null;
              },
              onSaved: (value) {
                widget.onChanged(widget.storeHour.copyWith(closeTime: value));
              },
            ),
          ),
        ],
      ),
    );
  }
}

class StoreHour {
  final String day;
  final bool isOpen;
  final String? openTime;
  final String? closeTime;

  StoreHour({required this.day, required this.isOpen, this.openTime, this.closeTime});

  StoreHour copyWith({
    String? day,
    bool? isOpen,
    String? openTime,
    String? closeTime,
  }) {
    return StoreHour(
      day: day ?? this.day,
      isOpen: isOpen ?? this.isOpen,
      openTime: openTime ?? this.openTime,
      closeTime: closeTime ?? this.closeTime,
    );
  }

  @override
  String toString() {
    return '$day: ${isOpen ? 'Open from $openTime to $closeTime' : 'Closed'}';
  }
}
