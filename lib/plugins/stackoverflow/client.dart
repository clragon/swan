import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:swan/plugins/stackoverflow/post.dart';

class StackOverflowClient {
  StackOverflowClient({
    this.apiKey,
  });

  final String? apiKey;

  Future<StackOverflowPost> getPost({
    required int postId,
  }) async {
    final Uri uri = Uri(
      scheme: 'https',
      host: 'api.stackexchange.com',
      pathSegments: ['2.3', 'questions', '$postId'],
      queryParameters: {
        'order': 'desc',
        'sort': 'activity',
        'site': 'stackoverflow',
        'key': apiKey,
        'filter': ')3ge1MECEwhFd81bjDSJB6uO5sKq7_Q.',
      },
    );

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse['items'] != null && jsonResponse['items'].isNotEmpty) {
        return StackOverflowPost.fromJson(jsonResponse['items'][0]);
      }
    }
    throw StackOverflowClientException('Failed to load post');
  }
}

class StackOverflowClientException implements Exception {
  StackOverflowClientException(this.message);

  final String message;
}
