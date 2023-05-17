
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Movie {
  String title;
  int year;
  String poster;

  Movie({required this.title, required this.year, required this.poster});
}

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Movie> movieData = [];

  @override
  void initState() {
    super.initState();
    fetchMovieData();
  }

  Future<void> fetchMovieData() async {
    final response = await http.get('https://my-json-server.typicode.com/horizon-code-academy/fake-movies-api/movies' as Uri);
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      List<Movie> movies = [];
      for (var movie in jsonData) {
        Movie newMovie = Movie(
          title: movie['Title'],
          year: movie['Year'],
          poster: movie['Poster'],
        );
        movies.add(newMovie);
      }
      setState(() {
        movieData = movies;
      });
    } else {
      // Handle API error
    }
  }

  void sortMovieData() {
    movieData.sort((a, b) => b.year.compareTo(a.year));
  }

  void deleteMovie(int index) {
    setState(() {
      movieData.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    sortMovieData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie List'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () {
              showYearCalendar(context);
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: movieData.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: Image.network(movieData[index].poster),
            title: Text(movieData[index].title),
            subtitle: Text(movieData[index].year.toString()),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () {
                deleteMovie(index);
              },
            ),
          );
        },
      ),
    );
  }

  Future<void> showYearCalendar(BuildContext context) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      initialDatePickerMode: DatePickerMode.year,
    );

    if (selectedDate != null) {
      setState(() {
        movieData = movieData.where((movie) => movie.year == selectedDate.year).toList();
      });
    }
  }
}



