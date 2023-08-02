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

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'link': link,
      'description': description,
      'content': content,
      'pubDate': pubDate,
      'imageUrl': imageUrl,
      'sourceId': sourceId,
      'category': category,
    };
  }

  factory NewsModel.fromMap(Map<String, dynamic> map) {
    return NewsModel(
      title: map['title'] as String?,
      link: map['link'] as String?,
      description: map['description'] as String?,
      content: map['content'] as String?,
      pubDate: map['pubDate'] as String?,
      imageUrl: map['imageUrl'] as String?,
      sourceId: map['sourceId'] as String?,
      category: map['category'] as String?,
    );
  }
}
