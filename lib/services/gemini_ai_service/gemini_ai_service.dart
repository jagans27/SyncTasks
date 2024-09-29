import 'package:dio/dio.dart';
import 'package:sync_tasks/services/gemini_ai_service/igemini_ai_service.dart';
import 'package:sync_tasks/util/constants.dart';
import 'package:sync_tasks/util/extensions.dart';

class GeminiAIService extends IGeminiAIService {
  final Dio _dio = Dio(BaseOptions(
      baseUrl: Constants.geminiAIConstants.endPoint,
      headers: {"x-goog-api-key": Constants.geminiAIConstants.apiKey}));

  @override
  Future<String?> getWorkScore() async {
    try {
      Response response = await _dio.post("/", data: {
        "contents": [
          {
            "parts": [
              {"text": Constants.geminiAIPrompt}
            ]
          }
        ]
      });

      if (response.statusCode == 200) {
        return response.data["candidates"][0]["content"]["parts"][0]["text"];
      }

      return null;
    } catch (ex) {
      ex.logError();
      return null;
    }
  }
}
