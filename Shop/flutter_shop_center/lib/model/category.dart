class CategoryBigModel{
  String mallCategoryId;
  String mallCategoryName;
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image
  });

  factory CategoryBigModel.fromJson(dynamic json){
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image']
    );
  }
}

class CategoryBigListModel{
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);

  factory CategoryBigListModel.fromJson(List json){
    return CategoryBigListModel(
        json.map((i)=>CategoryBigModel.fromJson((i))).toList()
    );
  }
}
