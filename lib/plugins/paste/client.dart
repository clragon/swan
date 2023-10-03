import 'package:http/http.dart' as http;

class PastebinClient {
  PastebinClient(this.apiKey);
  final String apiKey;

  Future<String> upload(
    String content, {
    String? name,
    String? language,
  }) async {
    final Map<String, String> postData = {
      'api_dev_key': apiKey,
      'api_option': 'paste',
      'api_paste_code': content,
      'api_paste_expire_date': '1W',
      'api_paste_name': name ?? 'Untitled',
    };

    if (language != null) {
      postData['api_paste_format'] = language;
    }

    final response = await http.post(
      Uri.parse('https://pastebin.com/api/api_post.php'),
      body: postData,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw PasteClientException(response.body);
    }
  }
}

class PasteClientException implements Exception {
  const PasteClientException(this.message);

  final String message;

  @override
  String toString() => 'PasteClientException: $message';
}
