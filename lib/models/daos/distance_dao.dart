import 'package:floor/floor.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class DistanceDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Distance table of a certain date
  @Query('SELECT * FROM Distance WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Distance>> findDistancebyTime(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Distance table
  @Query('SELECT * FROM Distance')
  Future<List<Distance>> findAllDistance();

  //Query #2: INSERT -> this allows to add a Distance in the table
  @insert
  Future<void> insertDistance(Distance distance);

  //Query #3: DELETE -> this allows to delete a Distance from the table
  @delete
  Future<void> deleteDistance(Distance distance);

  //Query #4: UPDATE -> this allows to update a Distance entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateDistance(Distance distance);

  @Query('SELECT * FROM Distance ORDER BY dateTime ASC LIMIT 1')
  Future<Distance?> findFirstDayInDb();

  @Query('SELECT * FROM Distance ORDER BY dateTime DESC LIMIT 1')
  Future<Distance?> findLastDayInDb();
  
}