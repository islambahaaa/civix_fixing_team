import 'package:civix_teams/core/widgets/shimmer_widgets.dart';
import 'package:civix_teams/features/home/presentation/manager/home_cubit/home_cubit.dart';
import 'package:civix_teams/features/home/presentation/views/widgets/report_item.dart';
import 'package:civix_teams/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

class AssignedToMeListView extends StatelessWidget {
  const AssignedToMeListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return _buildShimmerLoading();
        } else if (state is HomeSuccess) {
          if (state.reports.isEmpty) {
            return SliverToBoxAdapter(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  child: Text(
                    S.of(context).no_reports,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
            );
          }
          final reports = state.reports;
          return SliverList.separated(
            itemCount: reports.length,
            separatorBuilder:
                (context, index) => const Divider(thickness: 0.15),
            itemBuilder: (context, index) {
              return ReportItem(report: reports[index]);
            },
          );
        } else if (state is HomeFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }
        return const SliverToBoxAdapter(); // Return empty if state is unknown
      },
    );
  }

  /// Builds the shimmer loading effect
  Widget _buildShimmerLoading() {
    return const SliverFillRemaining(child: ShimmerNewestListView());
  }
}
