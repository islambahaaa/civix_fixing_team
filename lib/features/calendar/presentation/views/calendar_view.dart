import 'package:civix_teams/core/utils/app_colors.dart';
import 'package:civix_teams/features/calendar/presentation/views/widgets/events_list_view.dart';
import 'package:civix_teams/features/home/data/models/report_model.dart';
import 'package:civix_teams/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is HomeFailure) {
            return Center(child: Text(state.message));
          }

          if (state is HomeSuccess) {
            final allReports = [...state.reports, ...state.solvedReports];
            final events = groupReportsByDate(allReports);
            final normalizedSelectedDay =
                _selectedDay != null
                    ? DateTime(
                      _selectedDay!.year,
                      _selectedDay!.month,
                      _selectedDay!.day,
                    )
                    : DateTime.now();

            return Column(
              children: [
                TableCalendar<ReportModel>(
                  availableCalendarFormats: const {
                    CalendarFormat.month: 'Month',
                  },

                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  eventLoader: (day) {
                    final normalizedDay = DateTime(
                      day.year,
                      day.month,
                      day.day,
                    );
                    return events[normalizedDay] ?? [];
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Colors.orange,
                      shape: BoxShape.circle,
                    ),
                    markersMaxCount: 2,
                    markerDecoration: BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                  ),
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                ),
                const SizedBox(height: 16),
                EventsListView(
                  events: events,
                  normalizedSelectedDay: normalizedSelectedDay,
                ),
              ],
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  /// Group reports by normalized DateTime (removing time component)
  Map<DateTime, List<ReportModel>> groupReportsByDate(
    List<ReportModel> reports,
  ) {
    final Map<DateTime, List<ReportModel>> grouped = {};

    for (var report in reports) {
      try {
        final date = DateFormat('dd/MM/yyyy').parse(report.date);
        final key = DateTime(date.year, date.month, date.day);

        if (!grouped.containsKey(key)) {
          grouped[key] = [];
        }
        grouped[key]!.add(report);
      } catch (e) {
        print('Error parsing date: $e');
      }
    }

    return grouped;
  }
}
