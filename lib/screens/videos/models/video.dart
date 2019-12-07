
class Video {
  String kind;
  String etag;
  Id id;
  Snippet snippet;

  Video({this.kind, this.etag, this.id, this.snippet});

  Video.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    etag = json['etag'];
    id = json['id'] != null ? new Id.fromJson(json['id']) : null;
    snippet = json['snippet'] != null ? new Snippet.fromJson(json['snippet']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['etag'] = this.etag;
    if (this.id != null) {
      data['id'] = this.id.toJson();
    }
    if (this.snippet != null) {
      data['snippet'] = this.snippet.toJson();
    }
    return data;
  }
}

class Id {
  String kind;
  String videoId;

  Id({this.kind, this.videoId});

  Id.fromJson(Map<String, dynamic> json) {
    kind = json['kind'];
    videoId = json['videoId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['kind'] = this.kind;
    data['videoId'] = this.videoId;
    return data;
  }
}

class Snippet {
  String publishedAt;
  String channelId;
  String title;
  String description;
  Thumbnails thumbnails;
  String channelTitle;
  String liveBroadcastContent;

  Snippet({this.publishedAt, this.channelId, this.title, this.description, this.thumbnails, this.channelTitle, this.liveBroadcastContent});

  Snippet.fromJson(Map<String, dynamic> json) {
    publishedAt = json['publishedAt'];
    channelId = json['channelId'];
    title = json['title'];
    description = json['description'];
    thumbnails = json['thumbnails'] != null ? new Thumbnails.fromJson(json['thumbnails']) : null;
    channelTitle = json['channelTitle'];
    liveBroadcastContent = json['liveBroadcastContent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['publishedAt'] = this.publishedAt;
    data['channelId'] = this.channelId;
    data['title'] = this.title;
    data['description'] = this.description;
    if (this.thumbnails != null) {
      data['thumbnails'] = this.thumbnails.toJson();
    }
    data['channelTitle'] = this.channelTitle;
    data['liveBroadcastContent'] = this.liveBroadcastContent;
    return data;
  }
}

class Thumbnails {
  Thumb medium;
  Thumb high;

  Thumbnails({this.medium, this.high});

  Thumbnails.fromJson(Map<String, dynamic> json) {
    medium = json['medium'] != null ? new Thumb.fromJson(json['medium']) : null;
    high = json['high'] != null ? new Thumb.fromJson(json['high']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.medium != null) {
    data['medium'] = this.medium.toJson();
    }
    if (this.high != null) {
    data['high'] = this.high.toJson();
    }
    return data;
  }
}

class Thumb {
  String url;
  int width;
  int height;

  Thumb({this.url, this.width, this.height});

  Thumb.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    width = json['width'];
    height = json['height'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['width'] = this.width;
    data['height'] = this.height;
    return data;
  }
}