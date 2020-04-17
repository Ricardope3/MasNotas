import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final int id;
  final int idClass;
  final String url;

  Note(
      {this.id,
      this.idClass, 
      this.url});
  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['id'] as int,
      idClass: json['idClass'] as int,
      url: json['url'] as String
    );
  }

  @override
  List<Object> get props => [id, idClass, url];
}
