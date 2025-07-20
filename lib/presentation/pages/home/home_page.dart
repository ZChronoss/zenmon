import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';
import 'package:zenmon/presentation/widgets/focus_timer.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();

    Future.microtask(() => 
      context.read<HomeViewModel>().loadPokemon(Random().nextInt(649) + 1)
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            height: 450,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(
                  'assets/images/zenmon_background.png',
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
                if (viewModel.isLoading)
                  const CircularProgressIndicator()
                else if (viewModel.errorMessage != null)
                  Text(
                    "Error: ${viewModel.errorMessage!}",
                    style: const TextStyle(color: Colors.red),
                  )
                else if (viewModel.pokemon != null)
                  Image.network(
                    viewModel.pokemon!.animatedSpriteUrl!,
                    fit: BoxFit.fitHeight,
                    height: 100,
                  )
                else
                  const Text("Click the button to load Pokémon!"),
              ],
            ),
          ),
          const Spacer(),
          FocusTimer(
            duration: const Duration(minutes: 25),
            onFinished: () {},
          ),
          const Spacer(),
        ],
      ),
    );
  }

}
