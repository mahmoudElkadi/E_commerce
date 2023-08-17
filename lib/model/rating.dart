import 'dart:convert';

class Rating{
  final String userId;
  final double rating;

  Rating({
    required this.userId,
    required this.rating,
});
  Map<String,dynamic> toMap(){
    return{
      'userId':userId,
      'rating':rating,
    };
  }

  factory Rating.fromMap(Map<String,dynamic> json){
    return Rating(
      userId:json['userId']??'',
      rating:json['rating']as double,
    );
  }

  String toJson()=> json.encode(toMap());
  factory Rating.fromJson(String source)=>Rating.fromJson(json.decode(source));


  }


