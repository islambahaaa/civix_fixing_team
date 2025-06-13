import 'package:civix_teams/core/errors/failures.dart';
import 'package:civix_teams/features/notifications/data/models/notification_model.dart';
import 'package:dartz/dartz.dart';

abstract class NotificationRepo {
  Future<Either<Failure, List<NotificationModel>>> getNotifications();
}
