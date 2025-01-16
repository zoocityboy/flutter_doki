// {
//   "name": "Human-readable vendor name",
//   "manufacturer": ["name","alias1","alias2"],
//   "url": "/relative-url-to-vendor",
//   "award": number or null,
//   "position": number or null,
//   "explanation": "JSON-escaped HTML",
//   "user_solution": "JSON-escaped HTML",
//   "developer_solution": "JSON-escaped HTML"
// }
class DokiResponse {
  final String name;
  final List<String> manufacturer;
  final String url;
  final int? award;
  final int? position;
  final String explanation;
  final String userSolution;
  final String developerSolution;

  DokiResponse({
    required this.name,
    required this.manufacturer,
    required this.url,
    this.award,
    this.position,
    required this.explanation,
    required this.userSolution,
    required this.developerSolution,
  });

  factory DokiResponse.fromJson(Map<String, dynamic> json) => DokiResponse(
        name: json['name'] as String,
        manufacturer: List<String>.from(json['manufacturer']),
        url: json['url'] as String,
        award: json['award'] as int?,
        position: json['position'] as int?,
        explanation: json['explanation'] as String,
        userSolution: json['user_solution'] as String,
        developerSolution: json['developer_solution'] as String,
      );

  Map<String, dynamic> toJson() => {
        'name': name,
        'manufacturer': manufacturer,
        'url': url,
        'award': award,
        'position': position,
        'explanation': explanation,
        'user_solution': userSolution,
        'developer_solution': developerSolution,
      };

  @override
  String toString() {
    // ignore: lines_longer_than_80_chars
    return 'DokiResponse(name: $name, manufacturer: $manufacturer, url: $url, award: $award, position: $position, explanation: $explanation, userSolution: $userSolution, developerSolution: $developerSolution)';
  }
}
