final String tableNotes = 'notes';

class NotFields {
  static final List<String> values = [
    id,
    isImportant,
    number,
    title,
    description,
    time
  ];
  static const String id = '_id';
  static const String isImportant = 'isImportant';
  static const String number = 'number';
  static const String title = 'title';
  static const String description = 'description';
  static const String time = 'time';
}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String description;
  final DateTime createdTime;

  Note({
    required this.id,
    required this.isImportant,
    required this.number,
    required this.title,
    required this.description,
    required this.createdTime,
  });

  static Note fromJson(Map<String, Object?> json) => Note(
        id:json[NotFields.id]  as int?,
        isImportant:json[NotFields.isImportant] ==1,
        number:json[NotFields.number]  as int ,
        title: json[NotFields.title]  as String ,
        description:json[NotFields.description]  as String ,
        createdTime:DateTime.parse(json[NotFields.time] as String),
      );

  Map<String, Object?> toJson() => {
        NotFields.id: id,
        NotFields.time: createdTime.toIso8601String(),
        NotFields.title: title,
        NotFields.description: description,
        NotFields.number: number,
        NotFields.isImportant: isImportant ? 1 : 0,
      };

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? description,
    DateTime? createdTime,
  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        description: description ?? this.description,
        createdTime: createdTime ?? this.createdTime,
      );
}
