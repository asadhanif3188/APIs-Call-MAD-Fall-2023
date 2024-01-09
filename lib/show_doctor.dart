import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'models/doctor.dart';

class ShowDoctor extends StatefulWidget {
  const ShowDoctor({super.key});

  @override
  State<ShowDoctor> createState() => _ShowDoctorState();
}

class _ShowDoctorState extends State<ShowDoctor> {

  late Future<Doctor> futureDoctor;

  @override
  void initState() {
    super.initState();
    futureDoctor = fetchDoctor();
  }

// -----------------------------------------------

  Future<http.Response> createAlbum(Doctor doc) {
    return http.post(
      Uri.parse('http://localhost:8000/api/doctors'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': doc.name,
        'specialization': doc.specialization,
        'experience': doc.experience,
        'designation': doc.designation,
        'gender': doc.gender,
      }),
    );
  }

  Future<http.Response> updateAlbum(Doctor doc) {
    int id = doc.id;
    return http.put(
      Uri.parse('http://localhost:8000/api/doctors/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'name': doc.name,
        'specialization': doc.specialization,
        'experience': doc.experience,
        'designation': doc.designation,
        'gender': doc.gender,
      }),
    );
  }

  Future<http.Response> deleteAlbum(int id) async {
    final http.Response response = await http.delete(
      Uri.parse('http://localhost:8000/api/doctors/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );


    // ----------------------------------------------

  Future<Doctor> fetchDoctor() async {
    final response = await http
        .get(Uri.parse('http://localhost:8000/api/doctors/1'));

    // print(response.body);
    // print(response.statusCode);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.

      print(jsonDecode(response.body));

      return Doctor.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load doctor');
    }
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data From API',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data From API'),
        ),

        body: Center(
          child: FutureBuilder<Doctor>(
            future: futureDoctor,
            builder: (context, snapshot){

              if (snapshot.hasData) {
                return Text(snapshot.data!.name);
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();

            },
          ),
        ),

      ),
    );
  }
}
