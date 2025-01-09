import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../api/coinapi.dart';
import '../components/custom_dropdown.dart';
import '../data.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? selectedCurrency = "USD";
  String? selectedCrypto = "BTC";
  double? conversionRate;
  final CoinApiService coinApiService = CoinApiService();

  void fetchExchangeRate() async {
    if (selectedCrypto != null && selectedCurrency != null) {
      final rate = await coinApiService.getExchangeRate(selectedCrypto!, selectedCurrency!);
      setState(() {
        conversionRate = rate;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchExchangeRate(); // Fetch rate on initial load
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cripto Converter"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Select Cryptocurrency:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              CustomDropdown(
                items: cryptoList,
                selectedValue: selectedCrypto,
                onChanged: (value) {
                  setState(() {
                    selectedCrypto = value;
                  });
                  fetchExchangeRate();
                },
              ),
              SizedBox(height: 20),
              Text(
                "Select Currency:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
              ),
              SizedBox(height: 10),
              CustomDropdown(
                items: currencyList,
                selectedValue: selectedCurrency,
                onChanged: (value) {
                  setState(() {
                    selectedCurrency = value;
                  });
                  fetchExchangeRate();
                },
              ),
              SizedBox(height: 30),
              Text(
                conversionRate != null
                    ? "$selectedCrypto = ${conversionRate!.toStringAsFixed(2)} $selectedCurrency"
                    : "Loading exchange rate...",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}