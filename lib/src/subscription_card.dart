import 'package:flutter/material.dart';
import 'package:revenuecat_subscriber/src/subscription_service.dart';

class SubscriptionCard extends StatelessWidget {
  final String subscriptionTitle;
  final String subtitle;
  final String subscriptionDescription;
  final String price;
  final String productId;
  final String entitlementId;
  final VoidCallback onSubscribed; // Callback for when subscription succeeds
  final Widget? customButton; // Optional custom button

  const SubscriptionCard({
    Key? key,
    required this.subscriptionTitle,
    required this.subtitle,
    required this.subscriptionDescription,
    required this.price,
    required this.productId,
    required this.entitlementId,
    required this.onSubscribed,
    this.customButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleSubscription(context),
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: const LinearGradient(
              colors: [Color(0xFFB2DFDB), Color(0xFF80CBC4)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                subscriptionTitle,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subscriptionDescription,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16, color: Colors.black87),
              ),
              const SizedBox(height: 8),
              Text(
                '\$$price',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              const SizedBox(height: 16),
              customButton ??
                  ElevatedButton(
                    onPressed: () => _handleSubscription(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text(
                      'Subscribe',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleSubscription(BuildContext context) {
    SubscriptionService.subscribe(
      context: context,
      productId: productId,
      entitlementId: entitlementId,
      onSuccess: onSubscribed,
      onError: (message) => SubscriptionService.showError(context, message),
    );
  }
}
