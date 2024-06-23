import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpService {
  final String baseUrl;
  final Map<String, String> _defaultHeaders;

  HttpService({required this.baseUrl, required Map<String, String> defaultHeaders}) : _defaultHeaders = defaultHeaders;

  String _buildUrl(String endpoint) {
    return '$baseUrl$endpoint';
  }

  Future<dynamic> get(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.get(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
    );
    return response.statusCode;
  }

  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
      body: json.encode(body),
    );
    return response.statusCode;
  }

  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
      body: json.encode(body),
    );
    return response.statusCode;
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.delete(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
    );
    return response.statusCode;
  }
}

class HttpException implements Exception {
  final String message;
  final Uri? uri;

  HttpException(this.message, {this.uri});

  @override
  String toString() {
    if (uri == null) {
      return 'HttpException: $message';
    }
    return 'HttpException: $message, URI: $uri';
  }
}
