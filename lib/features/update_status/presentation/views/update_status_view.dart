import 'package:civix_teams/features/update_status/presentation/views/widgets/update_status_view_body.dart';
import 'package:flutter/material.dart';

class UpdateStatusView extends StatelessWidget {
  const UpdateStatusView({super.key});
  static const routeName = 'update-status';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Update Status")),
      body: UpdateStatusViewBody(),
    );
  }
}
