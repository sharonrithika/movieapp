import 'package:hive/hive.dart';
import 'package:movieapp/movielist.dart';

class Boxes {
  static Box<MovieList> getList() =>
      Hive.box<MovieList>('watchlist');
}