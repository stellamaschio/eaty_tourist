import 'package:floor/floor.dart';
import 'package:eaty_tourist/models/entities/entities.dart';

//Here, we are saying that the following class defines a dao.

@dao
abstract class SelectedDao {
  //Query #0: SELECT -> this allows to obtain all the entries of the Selected table of a certain date
  @Query('SELECT * FROM Selected WHERE dateTime between :startTime and :endTime ORDER BY dateTime ASC')
  Future<List<Selected>> findSelectedbyTime(DateTime startTime, DateTime endTime);

  //Query #1: SELECT -> this allows to obtain all the entries of the Selected table
  @Query('SELECT * FROM Selected')
  Future<List<Selected>> findAllSelected();

  //Query #2: INSERT -> this allows to add a Selected in the table
  @insert
  Future<void> insertSelected(Selected selected);

  //Query #3: DELETE -> this allows to delete a Selected from the table
  @delete
  Future<void> deleteSelected(Selected selected);

  //Query #4: UPDATE -> this allows to update a Selected entry
  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateSelected(Selected selected);

  @Query('SELECT * FROM Selected ORDER BY dateTime ASC LIMIT 1')
  Future<Selected?> findFirstDayInDb();

  @Query('SELECT * FROM Selected ORDER BY dateTime DESC LIMIT 1')
  Future<Selected?> findLastDayInDb();
  
}