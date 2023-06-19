import 'package:floor/floor.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class DataDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Data table of a certain date
  @Query('SELECT * FROM Data WHERE dateTime == :time ORDER BY dateTime ASC')
  Future<List<Data>> findDatabyTime(DateTime time);

  //Query #1: SELECT -> this allows to obtain all the entries of the Data table
  @Query('SELECT * FROM Data')
  Future<List<Data>> findAllData();

  //Query #2: INSERT -> this allows to add a Data in the table
  @insert
  Future<void> insertData(Data data);

  //Query #3: DELETE -> this allows to delete a Data from the table
  @delete
  Future<void> deleteData(Data data);

  //Query #4: UPDATE -> this allows to update a Data entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateData(Data data);

  @Query('SELECT * FROM Data ORDER BY dateTime ASC LIMIT 1')
  Future<Data?> findFirstDayInDb();

  @Query('SELECT * FROM Data ORDER BY dateTime DESC LIMIT 1')
  Future<Data?> findLastDayInDb();
  
}