class PortfolioModel {

  int? id;
  int userId;

  String title;
  String description;
  String image;

  PortfolioModel({
    this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.image,
  });

  Map<String, dynamic> toMap() {

    return {

      "id": id,

      "userId": userId,

      "title": title,

      "description": description,

      "image": image,

    };

  }

  factory PortfolioModel.fromMap(Map<String, dynamic> map){

    return PortfolioModel(

      id: map["id"],

      userId: map["userId"],

      title: map["title"],

      description: map["description"],

      image: map["image"],

    );

  }

}