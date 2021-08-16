import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:movieapp/boxes.dart';
import 'package:movieapp/movielist.dart';
import 'package:movieapp/formpage.dart';
//import 'package:intl/intl.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override

  void dispose()
  {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.grey[900],
        appBar: AppBar(
          title: Text('My List'),
          backgroundColor: Colors.grey[850],
          centerTitle: true,
        ),
        body: ValueListenableBuilder<Box<MovieList>>(
          valueListenable: Boxes.getList().listenable(),
          builder: (context, box, _) {
            final watchlist = box.values.toList().cast<MovieList>();

            return buildList(watchlist);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          
          onPressed: () => showDialog(
            context: context,
            builder: (context) => FormPage(
              onClickedDone: addMovie,
            ),
          ),
        ),
      );

  Widget buildList(List<MovieList> watchlist) {
    if (watchlist.isEmpty) {
      return Center(
        child: Text(
          'Add a Movie!',
          
          style: TextStyle(
            fontSize: 24,
            color: Colors.white,
            ),
        ),
      );
    } else {
      
      return Column(
        children: [
          const SizedBox(height: 24),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: watchlist.length,
              itemBuilder: (BuildContext context, int index) {
                final movie = watchlist[index];

                return buildbody(context, movie);
              },
            ),
          ),
        ],
      );
    }
  }

  Widget buildbody(
    BuildContext context,
    MovieList movie,
  ) {
    //final color = transaction.isExpense ? Colors.red : Colors.green;
    //final date = DateFormat.yMMMd().format(transaction.createdDate);
    //final amount = '\$' + transaction.amount.toStringAsFixed(2);

    return Card(
      child: ListTile(
                title: Text(movie.name),
                subtitle: Text(movie.director),
                leading: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  child: Image.network(
                    movie.url,
                    fit: BoxFit.cover,
                    width: 50,
                    height: 100,
                  ),
                ),
                trailing: Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FormPage(
                    movie: movie,
                    onClickedDone: (name, director, url) =>
                        editMovie(movie, name, director, url),
                  ),
                ),
              );
                        },
                        icon: Icon(Icons.edit),
                        color: Colors.grey,
                      ),
                      IconButton(
                        onPressed: () {
                          deleteMovie(movie);
                        },
                        icon: Icon(Icons.delete),
                        color: Colors.red,
                      )
                    ],
                  ),
                ),
              ),
      
    );
  }


  Future addMovie(String name, String director, String url) async {
    final movie = MovieList()
      ..name = name
      ..director = director
      ..url = url;

    final box = Boxes.getList();
    box.add(movie);
  }

  void editMovie(
    MovieList movie,
    String name,
    String director,
    String url,
  ) {
    movie.name = name;
    movie.director = director;
    movie.url = url;

    final box = Boxes.getList();
    box.put(movie.key, movie);

    movie.save();
  }

  void deleteMovie(MovieList movie) {
     final box = Boxes.getList();
     box.delete(movie.key);

    movie.delete();

  }
  
}