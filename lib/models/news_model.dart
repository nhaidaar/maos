class NewsModel {
  final String? title;
  final String? link;
  final String? description;
  final String? content;
  final String? pubDate;
  final String? imageUrl;
  final String? sourceId;
  final String? category;

  NewsModel({
    this.title,
    this.link,
    this.description,
    this.content,
    this.pubDate,
    this.imageUrl,
    this.sourceId,
    this.category,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json['title'],
        link: json['link'],
        description: json['description'],
        content: json['content'],
        pubDate: json['pubDate'],
        imageUrl: json['image_url'],
        sourceId: json['source_id'],
        category: json['category'][0],
      );
}
