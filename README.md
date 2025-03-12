# revenuecat_subscriber

A Flutter package for integrating RevenueCat subscriptions, featuring a reusable subscription service and an optional customizable `SubscriptionCard` widget.

## Features
- Simplified subscription handling with RevenueCat.
- Optional pre-built `SubscriptionCard` widget with a modern UI.
- Customizable success and error callbacks.

## Installation
Add this to your `pubspec.yaml`:

```yaml
dependencies:
  revenuecat_subscriber: ^1.0.0
```

Run:

```bash
flutter pub get
```

## Usage
This package provides two main ways to handle subscriptions:
- Use `SubscriptionCard` for a pre-built UI component.
- Use `SubscriptionService` directly for custom UI or logic.

## Prerequisites
Before using the package, configure RevenueCat in your app with your API key.

### Example
Below is a complete example showing how to set up and use both `SubscriptionCard` and `SubscriptionService`:

### Configure RevenueCat in Your App

```dart
import 'package:purchases_flutter/purchases_flutter.dart';

void main() {
  Purchases.configure(PurchasesConfiguration('your_revenuecat_api_key'));
  runApp(MyApp());
}
```

### Using `SubscriptionCard`

```dart
import 'package:flutter/material.dart';
import 'package:revenuecat_subscriber/revenuecat_subscriber.dart';

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Subscription Demo')),
      body: Center(
        child: SubscriptionCard(
          subscriptionTitle: 'VIP Plan',
          subtitle: 'VIP Access',
          subscriptionDescription: 'Unlock premium features!',
          price: '4.99',
          productId: 'vip_monthly',
          entitlementId: 'vip_access',
          onSubscribed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => VIPPage()));
          },
        ),
      ),
    );
  }
}

class VIPPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('VIP Page')),
      body: Center(child: Text('Welcome, VIP!')),
    );
  }
}
```

### Using `SubscriptionService` Directly
For custom UI or logic:

```dart
import 'package:flutter/material.dart';
import 'package:revenuecat_subscriber/revenuecat_subscriber.dart';

void subscribeToPlan(BuildContext context) {
  SubscriptionService.subscribe(
    context: context,
    productId: 'vip_monthly',
    entitlementId: 'vip_access',
    onSuccess: () {
      print('Subscription successful!');
      // Navigate or update UI
    },
    onError: (message) => SubscriptionService.showError(context, message),
  );
}
```

## Notes
- Replace `productId` and `entitlementId` with your actual RevenueCat configuration.
- Customize the `SubscriptionCard` UI by passing a `customButton` widget if desired.