import 'package:floor/floor.dart';

//Here, we are saying to floor that this is a class that defines an entity
@entity
class Steps {
  //id will be the primary key of the table. Moreover, it will be autogenerated.
  //id is nullable since it is autogenerated.
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int value;

  final DateTime dateTime;

  //Default constructor
  Steps(this.id, this.value, this.dateTime);
} //Steps