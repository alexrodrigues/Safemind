import 'package:flutter/material.dart';
import 'package:safemind/widget/sf_card_therapist.dart';

import '../model/therapist.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Therapist> therapists = [
    Therapist(
        "Karen Horney",
        "https://imgs.search.brave.com/vgLJx5a5PhEX7FEQqaQl7JW8MoNTdDUpKTRv5aef2SU/rs:fit:860:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvNTE0/ODc3MTcwL3Bob3Rv/L2VtaW5lbnQtcHN5/Y2hpYXRyaXN0LWFu/ZC1wcm9mZXNzb3It/c2VhdGVkLXdpdGgt/aGVyLXBldC1kb2ct/cGhvdG9ncmFwaC5q/cGc_cz02MTJ4NjEy/Jnc9MCZrPTIwJmM9/SlhvQy1SaGdfV1E4/ckNvX1hLUFgtY0o1/RV9sbklOc0R5Snow/and1MWFIRT0",
        "Major contributions: Neurotic needs: unlike Anna Freud, Karen Horney was a staunch refuter of Sigmund Freud’s ideas, believing them to be inherently biased toward women"),
    Therapist(
        "Carl Rogers",
        "https://imgs.search.brave.com/phE7xnz8YJruHGujod6hKyB358nE77KaEQFyZvmDLis/rs:fit:860:0:0/g:ce/aHR0cHM6Ly93d3cu/cG9zaXRpdmUtcGFy/ZW50aW5nLWFsbHku/Y29tL2ltYWdlLWZp/bGVzL3hjYXJsLXJv/Z2Vycy1jbG9zZXVw/LXBob3RvLmpwZy5w/YWdlc3BlZWQuaWMu/aXp2dWdPdkl2OS5q/cGc",
        "known for his person-centered approach and emphasis on empathy and unconditional positive regard."),
    Therapist(
        "Sigmund Freud",
        "https://imgs.search.brave.com/CrVpi9N618u3_Lz1iJF6SuOfm8bH6uH1D38_e3Svp7s/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9tZWRp/YS5nZXR0eWltYWdl/cy5jb20vaWQvOTE5/NzI0NTcyL3Bob3Rv/L3NpZ211bmQtZnJl/dWQtY2EtMTkyMS1w/cml2YXRlLWNvbGxl/Y3Rpb24uanBnP3M9/NjEyeDYxMiZ3PTAm/az0yMCZjPVluOEht/YVVmZ2o0azZmVFBt/SEl6YWVVTExDN3RJ/eW4tOTBLakJBT1FT/YXM9",
        "the founder of psychoanalysis, who developed the concept of the unconscious mind and the Oedipus complex"),
  ];

  var searchString = "";

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
              setState(() {
                searchString = value.toLowerCase();
              });
            },
            decoration: const InputDecoration(
              hintText: "Search",
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: therapists.length,
            itemBuilder: (ctx, index) {
              return TherapistCard(therapists[index]);
            },
          ),
        )
      ],
    );
  }
}
