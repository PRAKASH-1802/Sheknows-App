import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:typed_data';

class GeminiService {
  late GenerativeModel model;

  GeminiService() {
    const apiKey = 'AIzaSyByNZOUz6_4_mv8sj-OZXb7tOIUOnHTSUo'; // Replace with your new Gemini API key
    // if (apiKey.isEmpty || apiKey == 'AIzaSyByNZOUz6_4_mv8sj-OZXb7tOIUOnHTSUo') {
    //   throw Exception("API Key is missing or invalid. Please provide a valid GEMINI_API_KEY.");
    // }
    model = GenerativeModel(
      model: 'gemini-2.0-flash', // Updated to Gemini 2.0 Flash
      apiKey: apiKey,
    );
  }

  Future<String> getTextAnswer(String question) async {
    try {
      final String context = """
        Women face many challenges in their daily lives, including health issues, career growth, and societal expectations. 
        Common health concerns include menstrual health, pregnancy, and mental well-being. 
        In terms of career, women often seek advice on work-life balance, leadership roles, and overcoming gender bias. 
        Empowerment topics include education, financial independence, and self-confidence.
      """;

      final prompt = "Context: $context\nQuestion: $question\nAnswer in a concise and helpful way.";
      final content = [Content.text(prompt)];
      final response = await model.generateContent(content);

      return response.text ?? "Sorry, I couldn't find an answer.";
    } catch (e) {
      print("Error in getTextAnswer: $e");
      if (e.toString().contains("rate limit")) {
        return "Rate limit exceeded. Please try again later.";
      } else if (e.toString().contains("network")) {
        return "Network error. Please check your internet connection.";
      } else if (e.toString().contains("invalid API key")) {
        return "Invalid API key. Please check your GEMINI_API_KEY.";
      }
      return "Error occurred while fetching the answer: $e";
    }
  }

  Future<String> getImageAnswer(String question, String mimeType, Uint8List imageBytes) async {
    try {
      final content = Content('user', [
        TextPart("Question: $question\nAnalyze this image and provide a general description of what it might be. Note: I am not a medical professional, so please consult a doctor for an accurate diagnosis."),
        DataPart(mimeType, imageBytes),
      ]);

      final response = await model.generateContent([content]);

      return response.text ?? "Sorry, I couldn't analyze the image.";
    } catch (e) {
      print("Error in getImageAnswer: $e");
      if (e.toString().contains("rate limit")) {
        return "Rate limit exceeded. Please try again later.";
      } else if (e.toString().contains("network")) {
        return "Network error. Please check your internet connection.";
      } else if (e.toString().contains("invalid API key")) {
        return "Invalid API key. Please check your GEMINI_API_KEY.";
      }
      return "Error occurred while analyzing the image: $e";
    }
  }
}