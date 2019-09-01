import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

RandomUserModel parseData(String data){
  RandomUserModel requestModel = getRequestModelFromMap(data);
  return requestModel;
}

Future<RandomUserModel> getData(String url) async{
  http.Response response = await http.Client().get(url);
  if(response.statusCode == 200){
    return compute(parseData, response.body);
  }
  else{
    print("error: ${response.statusCode}");
    return null;
  }
}

RandomUserModel getRequestModelFromMap(String jsonMap){
  var map = json.decode(jsonMap);
  return RandomUserModel.fromMap(map);
}


class RandomUserModel{
  List<Result> results;
  Info info;
  RandomUserModel({this.results, this.info});

  factory RandomUserModel.fromMap(Map<String, dynamic> map){

    var list = map['results'] as List;
    List<Result> results = list.map((r)=> Result.fromMap(r)).toList();

    return RandomUserModel(
      results: results,
      info: Info.fromMap(map['info']),
    );
  }
}

class Result{
  String gender, phone, cell, nat;
  Name name;
  Picture picture;
  //write into db
  Result({this.gender = "genderno", this.phone = "phoneno", this.cell = "cellno", this.nat = "natno",this.name,this.picture});

  //read from db
  factory Result.fromMap(Map<String, dynamic> map){
    return Result(
      gender: map['gender'] ?? "nogender",
      phone: map['phone'] ?? "nophone",
      cell: map['cell'] ?? "nocell",
      nat: map['nat'] ?? "nonat",
      name: Name.fromMap(map['name']),
      picture: Picture.fromMap(map['picture']),
    );
  }
}

class Name{
  String title,first,last;
  Name({this.title,this.first,this.last});

  factory Name.fromMap(Map<String, dynamic> map){
    return Name(
      title: map['title']?? 'Notitle',
      first: map['first']?? 'Nofirst',
      last: map['last']?? 'Nolast',
    );
  }
}

class Picture{
  String large, medium;

  Picture({this.large,this.medium});

  factory Picture.fromMap(Map<String,dynamic>map){
    return Picture(
      large: map['large'] ?? 'https://rhondabrowningwhite.files.wordpress.com/2016/05/breaking-news.jpg',
      medium: map['medium'] ?? 'https://rhondabrowningwhite.files.wordpress.com/2016/05/breaking-news.jpg',
    );
  }

}

class Info{
  String seed;
  num resultsNum;
  num pageNum;
  String version;

  Info({this.seed = "seedno", this.resultsNum = 0, this.pageNum = 0, this.version = "versionno"});

  factory Info.fromMap(Map<String, dynamic> map){
    return Info(
      seed: map['seed'] ?? "noseed",
      resultsNum: map['results'] ?? 0,
      pageNum: map['page'] ?? 0,
      version: map['version'] ?? "noversion",
    );
  }
}
