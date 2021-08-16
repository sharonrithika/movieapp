import 'package:hive/hive.dart';

part 'movielist.g.dart';

@HiveType(typeId: 0)
class MovieList extends HiveObject
{

  @HiveField(0)
  late String name;
   @HiveField(1)
  late String director;
   @HiveField(2)
  late String url;
}
