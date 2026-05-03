import 'package:flutter/material.dart';

import '../dto/country_dto.dart';
import '../services/fetch_countries.dart';
import '../services/get_holidays_by_countrycode.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late Future<List<CountryDTO>> _futureCountries;
  List<CountryDTO> _allCountries = [];
  List<CountryDTO> _filteredCountries = [];

  @override
  void initState() {
    super.initState();
    _futureCountries = fetchCountries();
  }

  void _filterCountries(String query) {
    final filtered = _allCountries.where((country) {
      return country.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      _filteredCountries = filtered;
    });
  }

  void _showImportDialog(CountryDTO country) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Import Holidays'),
        content: Text('Import holidays for ${country.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              getHolidaysFromAPI(context, country.countryCode);
              Navigator.pop(context);
            },
            child: Text('Import'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Country')),
      body: FutureBuilder<List<CountryDTO>>(
        future: _futureCountries,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error loading countries'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No countries found'));
          }

          // Initialize lists once
          if (_allCountries.isEmpty) {
            _allCountries = snapshot.data!;
            _filteredCountries = _allCountries;
          }

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Search country',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: _filterCountries,
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: _filteredCountries.length,
                  itemBuilder: (context, index) {
                    final country = _filteredCountries[index];
                    return ListTile(
                      title: Text(country.name),
                      subtitle: Text(country.countryCode),
                      onTap: () => _showImportDialog(country),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}