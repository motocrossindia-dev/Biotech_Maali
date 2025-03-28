import 'package:biotech_maali/config/config.dart';
import 'package:biotech_maali/src/payment_and_order/order_history_detail/model/order_history_detail_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timeline_tile/timeline_tile.dart';

class DeliveryTrackingWidget extends StatelessWidget {
  final List<TrackingUpdate> trackingUpdates;

  const DeliveryTrackingWidget({
    super.key,
    required this.trackingUpdates,
  });

  String _formatTimestamp(DateTime timestamp) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(timestamp);
  }

  @override
  Widget build(BuildContext context) {
    final sortedUpdates = List<TrackingUpdate>.from(trackingUpdates)
      ..sort((a, b) => a.timestamp.compareTo(b.timestamp));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade300,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Tracking',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  decoration: TextDecoration.none,
                ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedUpdates.length,
            itemBuilder: (context, index) {
              final update = sortedUpdates[index];
              final isFirst = index == 0;
              final isLast = index == sortedUpdates.length - 1;

              return TimelineTile(
                alignment: TimelineAlign.start,
                isFirst: isFirst,
                isLast: isLast,
                indicatorStyle: IndicatorStyle(
                  width: 30,
                  color: _getStatusColor(update.status),
                  indicatorXY: 0.5,
                  iconStyle: IconStyle(
                    color: Colors.white,
                    iconData: _getStatusIcon(update.status),
                  ),
                ),
                beforeLineStyle: LineStyle(
                  color: _getStatusColor(update.status).withOpacity(0.5),
                  thickness: 3,
                ),
                afterLineStyle: LineStyle(
                  color: _getStatusColor(update.status).withOpacity(0.5),
                  thickness: 3,
                ),
                endChild: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        update.status,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: _getStatusColor(update.status),
                          decoration: TextDecoration.none,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        _formatTimestamp(update.timestamp),
                        style: TextStyle(
                          fontSize: 14,
                          color: cBorderGrey,
                          fontWeight: FontWeight.w600,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    return cButtonGreen;
  }

  IconData _getStatusIcon(String status) {
    switch (status.toLowerCase()) {
      case 'delivered':
        return Icons.check_circle;
      case 'out for delivery':
        return Icons.local_shipping;
      case 'on the way':
        return Icons.directions_car;
      case 'dispatched':
        return Icons.send;
      case 'order confirmed':
        return Icons.check_circle_outline;
      case 'processing':
        return Icons.hourglass_empty;
      default:
        return Icons.info_outline;
    }
  }
}
