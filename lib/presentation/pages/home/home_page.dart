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

  Widget _buildBackgroundStack(BuildContext context, HomeViewModel viewModel, Widget pokemonSprite, Widget peerPokemonSprite) {
    return SizedBox(
      width: double.infinity,
      height: 450,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/images/zenmon_background.png',
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
                pokemonSprite,
                peerPokemonSprite,
              ],
            )
          else
            const Text("Click the button to load Pokémon!"),
        ],
      ),
    );
  }

  Widget _buildConnectButton(BuildContext context) {
    return ElevatedButton(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final peerConnectionVM = Provider.of<PeerConnectionViewModel>(context);
    peerConnectionVM.userImageUrl = viewModel.pokemon?.animatedSpriteUrl ??
        "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/12.gif";

    final pokemonSprite = Image.network(
      viewModel.pokemon?.animatedSpriteUrl ?? "",
      fit: BoxFit.fitHeight,
      height: 100,
    );

    final peerPokemonSprite = Consumer<PeerConnectionViewModel>(
      builder: (context, vm, child) {
        var peerImageUrl = vm.peerImageUrl;
        if (peerImageUrl != null) {
          return Image.network(
            peerImageUrl,
            fit: BoxFit.fitHeight,
            height: 100,
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildBackgroundStack(context, viewModel, pokemonSprite, peerPokemonSprite),
              const SizedBox(height: 16),
              FocusTimer(
                duration: const Duration(minutes: 25),
                onFinished: () {},
              ),
              const SizedBox(height: 12),
              _buildConnectButton(context),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}