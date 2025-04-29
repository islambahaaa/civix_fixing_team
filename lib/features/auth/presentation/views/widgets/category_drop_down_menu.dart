import 'package:civix_teams/core/utils/app_colors.dart' show AppColors;
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class DropdownMenuExample extends StatefulWidget {
  final Function(String) onSelected;

  const DropdownMenuExample({super.key, required this.onSelected});

  @override
  _DropdownMenuExampleState createState() => _DropdownMenuExampleState();
}

class _DropdownMenuExampleState extends State<DropdownMenuExample> {
  String? selectedValue;
  final List<String> items = [
    S.current.pothole,
    S.current.garbage,
    S.current.broken_streetlight,
    S.current.manhole,
    S.current.flooding,
    S.current.graffiti,
    S.current.other,
  ];

  Map<String, int> categoryMap = {
    S.current.pothole: 1,
    S.current.broken_streetlight: 2,
    S.current.garbage: 3,
    S.current.manhole: 4,
    S.current.graffiti: 5, // Fixed spelling
    S.current.flooding: 6,
    S.current.other: 7,
  };
  int _getCategoryId(String category) {
    return categoryMap[category] ?? 0; // Returns 0 if category is not found
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.secondaryColor,
          width: 2,
        ), // Border Styling
        // Background color
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          padding: const EdgeInsets.all(4),
          isExpanded: true,
          hint: Text(S.of(context).select_your_team),
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.secondaryColor,
          ),
          value: selectedValue,
          iconSize: 32,
          elevation: 16,

          style: TextStyle(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black
                    : Colors.white,
            fontSize: 16,
          ),
          onChanged: (String? newValue) {
            setState(() {
              selectedValue = newValue;
            });
            // int categoryId = _getCategoryId(newValue!);
            widget.onSelected(newValue!);
          }, // Use widget.onChanged
          items:
              items.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: const TextStyle(fontSize: 16)),
                );
              }).toList(),
        ),
      ),
    );
  }
}
