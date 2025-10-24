

import 'appearance_model.dart';
import 'biography_model.dart';
import 'connections_model.dart';
import 'image_model.dart';
import 'powerstats_model.dart';
import 'work_model.dart';

class HeroModel {
  
  String? response;
  String? id;
  String? name;
  Powerstats? powerstats;
  Biography? biography;
  Appearance? appearance;
  Work? work;
  Connections? connections;
  Image? image;

  HeroModel({
     this.response = 'success',   
     this.id,
     this.name,
     this.powerstats,
     this.biography,
     this.appearance,
     this.work,
     this.connections,
     this.image,
  });

  factory HeroModel.fromJson(Map<String, dynamic> json) {

    return HeroModel(
      response: json['response'],
      id: json['id'],
      name: json['name'],
      powerstats: Powerstats.fromJson(json['powerstats']),
      biography: Biography.fromJson(json['biography']),
      appearance: Appearance.fromJson(json['appearance']),
      work: Work.fromJson(json['work']),
      connections: Connections.fromJson(json['connections']),
      image: Image.fromJson(json['image']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'response': response,
      'id': id,
      'name': name,
      'powerstats': powerstats?.toJson(),
      'biography': biography?.toJson(),
      'appearance': appearance?.toJson(),
      'work': work?.toJson(),
      'connections': connections?.toJson(),
      'image': image?.toJson(),
    };
  }


  /*static int? _toInt(dynamic value) {     
      if (value == null) { return null; }
      else if (value is int) { return value; }
      else if (value is String) { return int.tryParse(value); }
      else { return null; } 
    }*/


  String? toDisplayString({int? number}) {

    // TODO
    String? s = "";
    
    String name = this.name ?? 'Okänt namn';
    String strength = powerstats?.strength.toString() ?? 'Okänd styrka';

    if (number != null) { s+='$number. ';}
    s+= 'Namn: $name, Styrka: $strength';
    return s;
  }

}