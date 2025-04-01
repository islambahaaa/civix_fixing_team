import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onItemSelected;

  const CustomBottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color:
                Theme.of(context).brightness == Brightness.light
                    ? Colors.black.withOpacity(0.1) // Soft shadow in light mode
                    : Colors.white.withOpacity(0.1), // Subtle glow in dark mode
            spreadRadius: 2,
            blurRadius:
                Theme.of(context).brightness == Brightness.light ? 6 : 10,
            offset: const Offset(0, 4), // Keeps shadow position consistent
          ),
        ],
      ),
      width: double.infinity,
      child: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        elevation: 0,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Theme.of(context).colorScheme.onSurface,
            fontSize: 14,
          ),
        ),
        labelPadding: const EdgeInsets.all(4),
        indicatorShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        indicatorColor: Theme.of(context).indicatorColor,
        onDestinationSelected: onItemSelected,
        selectedIndex: selectedIndex,
        labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
        destinations: [
          NavigationDestination(
            selectedIcon: const Icon(Icons.home, color: AppColors.primaryColor),
            icon: Icon(
              Icons.home_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: S.of(context).home,
          ),
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.people,
              color: AppColors.primaryColor,
            ),
            icon: Icon(
              Icons.people_alt_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: 'My Team',
          ),
          NavigationDestination(
            selectedIcon: const Icon(
              Icons.person,
              color: AppColors.primaryColor,
            ),
            icon: Icon(
              Icons.person_outline_outlined,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            label: S.of(context).profile,
          ),
        ],
      ),
    );
  }
}
