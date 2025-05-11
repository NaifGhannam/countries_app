import 'package:flutter/material.dart';
import 'models/country.dart';
import 'services/api_service.dart';

void main() {
  runApp(const CountriesApp());
}

class CountriesApp extends StatelessWidget {
  const CountriesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '🌍 Countries App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.grey[100],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(fontSize: 18),
        ),
      ),
      home: const CountriesPage(),
    );
  }
}

class CountriesPage extends StatefulWidget {
  const CountriesPage({super.key});

  @override
  State<CountriesPage> createState() => _CountriesPageState();
}

class _CountriesPageState extends State<CountriesPage> {
  late Future<List<Country>> _futureCountries;

  @override
  void initState() {
    super.initState();
    _futureCountries = ApiService.fetchCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('🌍 Countries'),
        centerTitle: true,
        backgroundColor: Colors.teal[700],
        elevation: 4,
      ),
      body: FutureBuilder<List<Country>>(
        future: _futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(' Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final countries = snapshot.data!;
            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: countries.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (context, index) {
                final country = countries[index];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: const Icon(Icons.flag, color: Colors.teal),
                    title: Text(
                      country.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
