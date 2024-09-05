// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_note.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookNoteAdapter extends TypeAdapter<BookNote> {
  @override
  final int typeId = 0;

  @override
  BookNote read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BookNote(
      title: fields[0] as String,
      author: fields[1] as String,
      note: fields[2] as String,
      date: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, BookNote obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.author)
      ..writeByte(2)
      ..write(obj.note)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookNoteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
