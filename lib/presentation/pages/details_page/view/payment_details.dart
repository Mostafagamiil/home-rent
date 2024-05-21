import 'package:flutter/material.dart';
import 'package:home_rent/presentation/pages/details_page/view/details1.dart';
import 'package:home_rent/presentation/themes/colors.dart';

class PaymentDetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Display the transaction details
                const Text("Payment Detail",
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const ListTile(
                  title: Text("Period time"),
                  trailing: Text("2 month"),
                ),
                const ListTile(
                  title: Text("Monthly payment"),
                  trailing: Text("\$220"),
                ),
                const ListTile(
                  title: Text("Discount"),
                  trailing: Text("-\$88"),
                ),
                const ListTile(
                  title: Text("Total"),
                  trailing: Text("\$352",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 20),
                ListTile(
                  title: const Text("Payment Method"),
                  subtitle: const Text("••••••an@email.com"),
                  trailing: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: kColorAccent, // Button text color
                        minimumSize: const Size(0, 0) // Button size
                        ),
                    onPressed: () {},
                    child: const Text("Change",
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          // Pay Now button
          Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: kColorAccent, // Background color
                  minimumSize: const Size(double.infinity, 50) // Button size
                  ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text("Transaction Complete"),
                      content: const Text(
                          "Your payment has been successfully processed."),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                          },
                          child: const Text("OK",
                              style: TextStyle(color: kColorAccent)),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Pay Now", style: TextStyle(fontSize: 18)),
            ),
          ),
        ],
      ),
    );
  }
}
