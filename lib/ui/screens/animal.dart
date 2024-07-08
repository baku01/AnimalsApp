import 'package:flutter/material.dart';

import '../../data/api/data_api.dart';

class Animal extends StatelessWidget {
  const Animal({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: DataApi().getEntries(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                final entry = snapshot.data?[index];
                return ListTile(
                  title: Text(entry!.name),
                  leading: Image.network(entry.image),
                  subtitle: Text(entry.description),
                );
              },
            );
          }
        },
      ),
    );
  }
}