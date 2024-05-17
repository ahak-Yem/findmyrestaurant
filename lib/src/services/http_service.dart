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
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.post(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> put(String endpoint, {Map<String, String>? headers, dynamic body}) async {
    final response = await http.put(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint, {Map<String, String>? headers}) async {
    final response = await http.delete(
      Uri.parse(_buildUrl(endpoint)),
      headers: {..._defaultHeaders, if (headers != null) ...headers},
    );
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    final responseBody = response.body;
    final statusCode = response.statusCode;

    if (statusCode >= 200 && statusCode < 300) {
      if (responseBody.isNotEmpty) {
        return json.decode(responseBody);
      } else {
        return null;
      }
    } else {
      throw HttpException(
        'Request failed with status: $statusCode',
        uri: response.request?.url,
      );
    }
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
