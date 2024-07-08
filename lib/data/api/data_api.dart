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