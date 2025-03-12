import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

class SubscriptionService {
  static Future<void> subscribe({
    required BuildContext context,
    required String productId,
    required String entitlementId,
    required VoidCallback onSuccess,
    required Function(String) onError,
  }) async {
    try {
      final products = await Purchases.getProducts([productId]);
      if (products.isNotEmpty) {
        final product = products.first; // No need for null check here
        CustomerInfo customerInfo = await Purchases.getCustomerInfo();
        if (customerInfo.entitlements.all[entitlementId]?.isActive == true) {
          onSuccess();
        } else {
          final purchaserInfo = await Purchases.purchaseStoreProduct(product);
          if (purchaserInfo.entitlements.all[entitlementId]?.isActive == true) {
            onSuccess();
          } else {
            onError('Subscription not active.');
          }
        }
      } else {
        onError('Product not available.');
      }
    } on PlatformException catch (e) {
      onError('An error occurred: ${e.message}');
    }
  }

  static Future<void> showError(BuildContext context, String message) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
