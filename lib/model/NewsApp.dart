import 'Source.dart';

class NewsModel {
  final Source? source;
  final String title;
  final String description;
  final String urlToImage;
  final String url;

  NewsModel({
    this.source,
    required this.title,
    required this.description,
    required this.urlToImage,
    required this.url,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      source: Source.fromJson(json['source'] ?? {}),
      title: json['title'] ?? 'No Title',
      description: json['description'] ?? '',
      // nullable
      urlToImage:
          json['urlToImage'] ??
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuSwHPruhQUDxnalPJQeikGDTiAggFK7uUEA&s',
      // nullable
      url: json['url'] ?? '', // nullable
    );
  }
}


