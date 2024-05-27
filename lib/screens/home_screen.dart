import 'package:flutter/material.dart';
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
  List<Therapist> therapists = [
    Therapist(
      "Karen Horney",
      "https://imgs.search.brave.com/vgLJx5a5PhEX7FEQqaQl7JW8MoNTdDUpKTRv5aef2SU/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTE0/ODc3MTcwL3Bob3Rv/L2VtaW5lbnQtcHN5/Y2hpYXRyaXN0LWFu/ZC1wcm9mZXNzb3It/c2VhdGVkLXdpdGgt/aGVyLXBldC1kb2ct/cGhvdG9ncmFwaC5q/cGc_cz02MTJ4NjEy/Jnc9MCZrPTIwJmM9/SlhvQy1SaGdfV1E4/ckNvX1hLUFgtY0o1/RV9sbklOc0R5Snow/and1MWFIRT0",
      "Major contributions: Neurotic needs: unlike Anna Freud, Karen Horney was a staunch refuter of Sigmund Freud’s ideas, believing them to be inherently biased toward women",
      "CRP 01/123456",
    ),
    Therapist(
      "Carl Rogers",
      "https://imgs.search.brave.com/phE7xnz8YJruHGujod6hKyB358nE77KaEQFyZvmDLis/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/cG9zaXRpdmUtcGFy/ZW50aW5nLWFsbHku/Y29tL2ltYWdlLWZp/bGVzL3hjYXJsLXJv/Z2Vycy1jbG9zZXVw/LXBob3RvLmpwZy5w/YWdlc3BlZWQuaWMu/aXp2dWdPdkl2OS5q/cGc",
      "known for his person-centered approach and emphasis on empathy and unconditional positive regard.",
      "CRP 01/123456",
    ),
    Therapist(
      "Sigmund Freud",
      "https://imgs.search.brave.com/CrVpi9N618u3_Lz1iJF6SuOfm8bH6uH1D38_e3Svp7s/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvOTE5/NzI0NTcyL3Bob3Rv/L3NpZ211bmQtZnJl/dWQtY2EtMTkyMS1w/cml2YXRlLWNvbGxl/Y3Rpb24uanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPVluOEht/YVVmZ2o0azZmVFBt/SEl6YWVVTExDN3RJ/eW4tOTBLakJBT1FT/YXM9",
      "the founder of psychoanalysis, who developed the concept of the unconscious mind and the Oedipus complex",
      "CRP 01/123456",
    ),
  ];

  @override
  void initState() {
    super.initState();
    filteredTherapists = therapists; // Initialize with the full list
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
                              child: Image.network(
                                filteredTherapists[index].urlImage,
                                width: 120,
                                height: 200,
                                fit: BoxFit
                                    .cover, // Use BoxFit.cover to maintain aspect ratio
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
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  filteredTherapists[index].description,
                                  style: TextStyle(fontSize: 14),
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
      ],
    );
  }
}
