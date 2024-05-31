import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_rent/presentation/themes/colors.dart';
import '../../../../data/sources/api_source.dart';
import '../../../../data/sources/local_source.dart';


class PaymentScreen extends StatefulWidget {
  final CategoryItem item;

  PaymentScreen({required this.item});

  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final _formKey = GlobalKey<FormState>();
  final _cardNumberController = TextEditingController();
  final _expiryDateController = TextEditingController();
  final _cvvController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  Future<void> _processPayment() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // Handle the case when the user is not signed in
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      await _firebaseService.savePaymentDetails(
        user.uid, // Use the current user's ID
        widget.item.title,
        _cardNumberController.text,
        _expiryDateController.text,
        _cvvController.text,
        widget.item.price,
      );

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Payment Success'),
          content: Text('Your payment of EGP ${widget.item.price} has been successfully processed.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.of(context).pop(); // Go back to the previous screen
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rent ${widget.item.title}'),
        backgroundColor: kColorAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Payment Details',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20),
              _buildTextField(
                controller: _cardNumberController,
                label: 'Card Number',
                hintText: '1234 5678 9012 3456',
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your card number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      controller: _expiryDateController,
                      label: 'Expiry Date',
                      hintText: 'MM/YY',
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your card\'s expiry date';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(width: 20),
                  Expanded(
                    child: _buildTextField(
                      controller: _cvvController,
                      label: 'CVV',
                      hintText: '123',
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your card\'s CVV';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              ElevatedButton(
                onPressed: _processPayment,
                style: ElevatedButton.styleFrom(
                  primary: kColorAccent,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                  'Pay Now',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hintText,
    TextInputType keyboardType = TextInputType.text,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
    );
  }
}