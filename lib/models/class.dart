import 'package:equatable/equatable.dart';

class Class extends Equatable {
  final int id;
  final int idSchedule;
  final DateTime start;
  final DateTime end;
  final String name;
  final String imageUrl;

  Class(
      {this.id,
      this.idSchedule, 
      this.start,
      this.end,
      this.name,
      this.imageUrl});
  factory Class.fromJson(Map<String, dynamic> json) {
    return Class(
      id: json['id'] as int,
      idSchedule: json['idSchedule'] as int,
      start: DateTime.parse(json['start']),
      end: DateTime.parse(json['end']),
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
    );
  }

  @override
  String toString() {
    return "{\n\tClase: ${this.name}\n\tStart: ${this.start}\n\tEnd: ${this.end}\n\tURL: ${this.imageUrl}}";
  }

  @override
  List<Object> get props => [id, idSchedule, start, end, name];
}
