import 'package:floor/floor.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class StepsDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Steps table of a certain date
  @Query('SELECT * FROM Steps WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Steps>> findStepsbyTime(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Steps table
  @Query('SELECT * FROM Steps')
  Future<List<Steps>> findAllSteps();

  //Query #2: INSERT -> this allows to add a Steps in the table
  @insert
  Future<void> insertSteps(Steps steps);

  //Query #3: DELETE -> this allows to delete a Steps from the table
  @delete
  Future<void> deleteSteps(Steps steps);

  //Query #4: UPDATE -> this allows to update a Steps entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSteps(Steps steps);

  @Query('SELECT * FROM Steps ORDER BY dateTime ASC LIMIT 1')
  Future<Steps?> findFirstDayInDb();

  @Query('SELECT * FROM Steps ORDER BY dateTime DESC LIMIT 1')
  Future<Steps?> findLastDayInDb();
  
}