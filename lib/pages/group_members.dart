import 'package:flutter/material.dart';

class GroupMembersPage extends StatelessWidget {
  const GroupMembersPage({super.key});

  // Data anggota + foto masing-masing
  final List<Map<String, String>> members = const [
    {
      "name": "Rapolo",
      "id": "124230049",
      "photo": "assets/images/rapolo.jpg",
    },
    {
      "name": "Latief",
      "id": "124230067",
      "photo": "assets/images/latief.jpg",
    },
    {
      "name": "Rikza",
      "id": "124230054",
      "photo": "assets/images/rikza.jpg",
    },
    {
      "name": "Duki",
      "id": "124230070",
      "photo": "assets/images/duki.jpg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Judul
              const Text(
                "Our",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const Text(
                "Members",
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "People behind this project :",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white70,
                ),
              ),
              const SizedBox(height: 24),

              // Grid anggota
              Expanded(
                child: GridView.builder(
                  itemCount: members.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 kolom
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context, index) {
                    final member = members[index];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage(member["photo"]!),
                          backgroundColor: Colors.white12,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          member["name"]!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          member["id"]!,
                          style: const TextStyle(
                            fontSize: 15,
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
