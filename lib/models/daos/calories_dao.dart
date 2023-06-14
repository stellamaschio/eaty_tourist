import 'package:floor/floor.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class CaloriesDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Calories table of a certain date
  @Query('SELECT * FROM Calories WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Calories>> findCaloriesbyTime(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Calories table
  @Query('SELECT * FROM Calories')
  Future<List<Calories>> findAllCalories();

  //Query #2: INSERT -> this allows to add a Calories in the table
  @insert
  Future<void> insertCalories(Calories calories);

  //Query #3: DELETE -> this allows to delete a Calories from the table
  @delete
  Future<void> deleteCalories(Calories calories);

  //Query #4: UPDATE -> this allows to update a Calories entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateCalories(Calories calories);

  @Query('SELECT * FROM Calories ORDER BY dateTime ASC LIMIT 1')
  Future<Calories?> findFirstDayInDb();

  @Query('SELECT * FROM Calories ORDER BY dateTime DESC LIMIT 1')
  Future<Calories?> findLastDayInDb();
  
}