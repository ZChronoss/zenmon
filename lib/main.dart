import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/data/data_source/pokemon_remote_data_source.dart';
import 'package:zenmon/data/repository_impl/pokemon_repository_impl.dart';
import 'package:zenmon/domain/pokemon/use_case/get_pokemon_use_case.dart';
import 'package:zenmon/presentation/pages/home/home_page.dart';
import 'package:http/http.dart' as http;
import 'package:zenmon/presentation/pages/home/home_view_model.dart';

void main() {
  final client = http.Client();
  final pokemonRemoteDataSource = PokemonRemoteDataSourceImpl(client);
  final pokemonRepository = PokemonRepositoryImpl(pokemonRemoteDataSource);
  final getPokemonUseCase = GetPokemonUseCase(pokemonRepository);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => HomeViewModel(getPokemonUseCase)
        )
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
