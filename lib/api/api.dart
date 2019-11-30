import 'dart:async';
import 'dart:convert' show json, utf8;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:date_format/date_format.dart';
import 'package:git_client_mobile/api/repo.dart';
import 'package:git_client_mobile/api/projects.dart';
import 'package:shared_preferences/shared_preferences.dart';

Dio dio = _initDio();

class Api {
  static final HttpClient _httpClient = HttpClient();
  static final String _url = "api.github.com";

  static Future<List<Repo>> getRepositoriesWithSearchQuery(String query) async {
    final uri = Uri.https(_url, '/search/repositories', {
      'q': query,
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<List<Repo>> getTrendingRepositories() async {
    final lastWeek = DateTime.now().subtract(Duration(days: 7));
    final formattedDate = formatDate(lastWeek, [yyyy, '-', mm, '-', dd]);

    final uri = Uri.https(_url, '/search/repositories', {
      'q': 'created:>$formattedDate',
      'sort': 'stars',
      'order': 'desc',
      'page': '0',
      'per_page': '25'
    });

    final jsonResponse = await _getJson(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse['errors'] != null) {
      return null;
    }
    if (jsonResponse['items'] == null) {
      return List();
    }

    return Repo.mapJSONStringToList(jsonResponse['items']);
  }

  static Future<List<ProjectsRepo>> getUserRepositories() async {
    final uri = Uri.https(_url, '/users/viniciusbelloli/repos');

    final jsonResponse = await _getJsonPro(uri);
    if (jsonResponse == null) {
      return null;
    }
    if (jsonResponse != null) {
      return null;
    }
    if (jsonResponse == null) {
      return List();
    }

    return ProjectsRepo.mapJSONStringToList(jsonResponse);
  }

  static Future<Map<String, dynamic>> _getJson(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final data = json.decode(responseBody);
      

      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }

  static Future<List> _getJsonPro(Uri uri) async {
    try {
      final httpRequest = await _httpClient.getUrl(uri);
      final httpResponse = await httpRequest.close();
      if (httpResponse.statusCode != HttpStatus.ok) {
        return null;
      }

      final responseBody = await httpResponse.transform(utf8.decoder).join();
      final data = json.decode(responseBody);
      

      return json.decode(responseBody);
    } on Exception catch (e) {
      print('$e');
      return null;
    }
  }
}

Dio _initDio() {
  Dio dio = new Dio();
  Dio tokenDio = new Dio();
  String token;
  dio.options.baseUrl = 'https://api.github.com';
  tokenDio.options = dio.options;
  dio.interceptors.add(InterceptorsWrapper(onRequest: (RequestOptions options) {
    print(
        'send request：path: ${options.path}，baseURL: ${options.baseUrl}，token: $token');

    if (token == null) {
      print('----------- no token -----------');
      dio.lock();
      return SharedPreferences.getInstance().then((prefs) {
        options.headers['Authorization'] =
            token = prefs.getString('authorization');

        print('token $token');
        return options;
      }).whenComplete(() => dio.unlock());
    } else {
      options.headers['Authorization'] = token;
      return options;
    }
  }, onError: (DioError error) async {
    print('----------- http error -----------');
    token = null;
    return error;
  }));

  return dio;
}
