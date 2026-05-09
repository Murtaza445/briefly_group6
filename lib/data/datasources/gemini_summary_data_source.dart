import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/news_item.dart';

class GeminiSummaryDataSource {
  final http.Client client;
  final String apiKey;

  GeminiSummaryDataSource({http.Client? client, String? apiKey})
      : client = client ?? http.Client(),
        apiKey = apiKey ?? const String.fromEnvironment('GEMINI_API_KEY');

  static const _endpoint =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent';

  Future<String> fetchCuratedSummary(List<NewsItem> news) async {
    if (apiKey.isEmpty) {
      throw Exception('Missing GEMINI_API_KEY. Pass it with --dart-define.');
    }

    final prompt = _buildPrompt(news);
    final response = await client.post(
      Uri.parse('$_endpoint?key=$apiKey'),
      headers: const {'Content-Type': 'application/json'},
      body: jsonEncode({
        'contents': [
          {
            'role': 'user',
            'parts': [
              {'text': prompt},
            ],
          }
        ],
        'generationConfig': {
          'temperature': 0.4,
          'maxOutputTokens': 500,
        },
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Gemini request failed (${response.statusCode})');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final candidates = decoded['candidates'] as List<dynamic>?;

    if (candidates == null || candidates.isEmpty) {
      throw Exception('Gemini returned no summary');
    }

    final content = candidates.first as Map<String, dynamic>;
    final text = _extractText(content);

    if (text.isEmpty) {
      throw Exception('Gemini summary was empty');
    }

    return text.trim();
  }

  String _buildPrompt(List<NewsItem> news) {
    final items = news
        .map((item) => '- ${item.headline}: ${item.body}')
        .join('\n');

    return '''
You are a tech news editor. Create a concise curated summary of the latest tech news below.

Requirements:
- Write 3 to 5 bullet points.
- Focus on the most important trends and company/product developments.
- Use clear, student-friendly language.
- Do not add a title.
- Keep it under 120 words.

News:
$items
''';
  }

  String _extractText(Map<String, dynamic> candidate) {
    final content = candidate['content'] as Map<String, dynamic>?;
    final parts = content?['parts'] as List<dynamic>?;

    if (parts == null) {
      return '';
    }

    return parts
        .map((part) => (part as Map<String, dynamic>)['text']?.toString() ?? '')
        .join('\n');
  }
}