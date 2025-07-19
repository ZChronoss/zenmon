import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';
import 'package:zenmon/presentation/widgets/focus_timer.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200, 
              child: Center(
                child: (viewModel.isLoading)
                    ? const CircularProgressIndicator()
                    : (viewModel.errorMessage != null)
                        ? Text(
                            "Error: ${viewModel.errorMessage!}",
                            style: const TextStyle(color: Colors.red),
                          )
                        : (viewModel.pokemon != null)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center, 
                                children: [
                                  Text(
                                    viewModel.pokemon!.name,
                                    style: Theme.of(context).textTheme.headlineMedium,
                                  ),
                                  Image.network(
                                    viewModel.pokemon!.animatedSpriteUrl!,
                                    height: 150,
                                  ),
                                ],
                              )
                            : const Text("Click the button to load Pokémon!"),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                viewModel.loadPokemon(Random().nextInt(649) + 1);
              },
              child: const Text("Get Random Pokémon"),
            ),
            const Spacer(),
            FocusTimer(
              duration: const Duration(minutes: 25),
              onFinished: () {
                
              },
            ),
            const Spacer(), 
          ],
        ),
      ),
    );
  }
}
