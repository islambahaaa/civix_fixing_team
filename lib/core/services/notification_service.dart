import 'dart:convert';

import 'package:civix_teams/core/constants/api_constants.dart';
import 'package:civix_teams/core/services/dio_client.dart';
import 'package:civix_teams/features/notifications/data/models/notification_model.dart';

class NotificationService {
  DioClient dio;

  NotificationService({required this.dio});

  Future<List<dynamic>> fetchNotifications() async {
    final response = await dio.get(ApiConstants.notificationEndpoint);
    final List<Map<String, dynamic>> data = List<Map<String, dynamic>>.from(
      response.data,
    );
    return data;
  }
}
