import 'package:equatable/equatable.dart';

class Schedule extends Equatable {
  final int id;
  final String idUser;
  final String url;
  final String name;

  Schedule(
      {this.id,
      this.idUser, 
      this.url,
      this.name});
  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      idUser: json['iduser'] as String,
      url: json['url'] as String,
      name: json['nombre'] as String,
      id: json['id'] as int
    );
  }

  @override
  List<Object> get props => [id, idUser, url, name];
}
