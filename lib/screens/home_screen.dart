import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:safemind/providers/therapists_provider.dart';
import 'package:safemind/screens/detail_screen.dart';

import '../model/therapist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String searchString = "";
  List<Therapist> filteredTherapists = [];
  List<Therapist> therapists = [];
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = "";

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
    });

    try {
      final value = await Provider.of<TherapistsProvider>(context, listen: false).fetchTherapists();
      setState(() {
        therapists = value;
        filteredTherapists = value;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _refreshData() async {
    await _fetchData();
  }

  void _filterTherapists(String query) {
    final filtered = therapists.where((therapist) {
      return therapist.name.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredTherapists = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Container(
        color: Colors.grey[200],
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (_hasError) {
      return Container(
        color: Colors.grey[200],
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 48),
              const SizedBox(height: 16),
              const Text(
                "Falha ao buscar dados",
                style: TextStyle(fontSize: 18, color: Colors.red),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _fetchData,
                child: const Text("Tentar novamente"),
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextField(
            onChanged: (value) {
              _filterTherapists(value);
            },
            decoration: InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
                borderSide: BorderSide.none,
              ),
              filled: true,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
              fillColor: Colors.grey[200],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: RefreshIndicator(
            onRefresh: _refreshData,
            child: ListView.builder(
              itemCount: filteredTherapists.length,
              itemBuilder: (ctx, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    elevation: 4,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                          DetailsScreen.ROUTE_NAME,
                          arguments: filteredTherapists[index],
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              height: 200,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: filteredTherapists[index].urlImage.isNotEmpty
                                    ? Image.network(
                                  filteredTherapists[index].urlImage,
                                  width: 120,
                                  height: 200,
                                  fit: BoxFit.cover, // Use BoxFit.cover to maintain aspect ratio
                                )
                                    : const Icon(
                                  Icons.error,
                                  size: 50,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredTherapists[index].name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    filteredTherapists[index].description,
                                    style: const TextStyle(fontSize: 14),
                                    maxLines: 8,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
