import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // For formatting dates and currency

void main() {
  runApp(TruckiveApp());
}

class TruckiveApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Truckive Driver App',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF0d2136), // Primary color
          secondary: Color(0xFF031525), // Secondary color
          brightness: Brightness.dark, // Use dark theme
        ),
      ),
      home: PaymentPage(),
    );
  }
}

class PaymentPage extends StatefulWidget {
  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final currencyFormat = NumberFormat.simpleCurrency(locale: "en_IN");
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  Widget buildPaymentCard({required String title, required String subtitle}) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            SizedBox(height: 8.0),
            Text(subtitle, style: TextStyle(fontSize: 16.0)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payments'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: 10, // Only show the last 10 payments
              itemBuilder: (context, index) {
                // Calculate the month and year for each payment
                DateTime paymentDate = DateTime(2024, 1, 1)
                    .subtract(Duration(days: 30 * (10 - index)));
                String title =
                    DateFormat('MMMM yyyy').format(paymentDate) + ' Payment';
                String subtitle = 'Received on ' +
                    DateFormat('MMM d, y').format(paymentDate) +
                    ' - ' +
                    currencyFormat.format(1000 + (index * 100));

                return buildPaymentCard(title: title, subtitle: subtitle);
              },
            ),
    );
  }
}
