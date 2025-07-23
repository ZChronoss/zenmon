import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';
import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';
import 'package:zenmon/presentation/widgets/focus_timer.dart';
import 'package:zenmon/presentation/widgets/peer_connection.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomeViewModel>().loadPokemon(Random().nextInt(649) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final backgroundImageUrl = 'assets/images/zenmon_background.png';
    final viewModel = context.watch<HomeViewModel>();
    final peerConnectionVM = Provider.of<PeerConnectionViewModel>(context);
    peerConnectionVM.userImageUrl = viewModel.pokemon?.animatedSpriteUrl ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/12.gif";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                height: 450,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      backgroundImageUrl,
                      fit: BoxFit.fitWidth,
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
                      Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // user's pokemon image
                        Image.network(
                          viewModel.pokemon!.animatedSpriteUrl!,
                          fit: BoxFit.fitHeight,
                          height: 100,
                        ),

                        // peer's pokemon image
                        Consumer<PeerConnectionViewModel>(
                          builder: (context, vm, child) {
                            var peerImageUrl = vm.peerImageUrl;
                            if(peerImageUrl != null) {
                              return Image.network(
                                  peerImageUrl,
                                  fit: BoxFit.fitHeight,
                                  height: 100,
                              );
                            } else {
                              return SizedBox.shrink();
                            }
                        },),
                          
                      ],
                    )
                    else
                      const Text("Click the button to load Pokémon!"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              FocusTimer(
                duration: const Duration(minutes: 25),
                onFinished: () {},
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                    ),
                    builder: (context) => const PeerConnection(),
                  );
                },
                child: const Text("Connect To Another Trainer!"),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}