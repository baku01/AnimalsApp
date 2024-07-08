
---

# Animal App

Este é um exemplo de aplicativo Flutter que exibe uma lista de animais, com dados sendo recuperados de uma API.

## Estrutura do Projeto

- `main.dart`: Ponto de entrada do aplicativo.
- `animal.dart`: Contém a tela principal do aplicativo que exibe a lista de animais.
- `entry.dart`: Define a classe `Entry` que representa um animal.
- `data_api.dart`: Responsável por buscar os dados da API.

## Dependências

- [flutter/material.dart](https://flutter.dev/docs/development/ui/widgets/material)
- [dart:convert](https://api.dart.dev/stable/2.13.4/dart-convert/dart-convert-library.html)

## Código

### main.dart

O ponto de entrada do aplicativo. Aqui, definimos o tema e a tela inicial.

```dart
import 'package:animals/ui/screens/animal.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent, brightness: Brightness.dark),
        useMaterial3: true,
      ),
      home: const Animal(),
    );
  }
}
```

### animal.dart

Contém a tela principal que exibe a lista de animais. Utiliza `FutureBuilder` para buscar os dados da API e exibir um `CircularProgressIndicator` enquanto os dados são carregados.

```dart
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
```

### entry.dart

Define a classe `Entry`, que representa um animal. Inclui métodos para serialização e desserialização de JSON.

```dart
import 'dart:convert';

class Entry {
  final String name;
  final String description;
  final String family;
  final String image;

  Entry({
    required this.name,
    required this.description,
    required this.family,
    required this.image,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'family': family,
      'image': image,
    };
  }

  factory Entry.fromMap(Map<String, dynamic> map) {
    return Entry(
      name: map['name'] as String,
      description: map['description'] as String,
      family: map['family'] as String,
      image: map['image'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Entry.fromJson(String source) => Entry.fromMap(json.decode(source) as Map<String, dynamic>);
}
```

### data_api.dart

Contém o código para buscar os dados da API. Substitua a URL da API conforme necessário.

```dart
import 'package:animals/domain/entities/entry.dart';
import '../../utils/utils.dart';
import 'package:dio/dio.dart';

class DataApi {
  final Dio _dio = Dio();

  Future<List<Entry>> getEntries() async {
    final response = await _dio.get(apiUrl);
    final List<Entry> entries = List<Entry>.from(
        response.data.map((error) => Entry.fromMap((error))));
    return entries;
  }
}
```

---
