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
    context.read<HomeViewModel>().initialize();
  }

  Widget _buildBackgroundStack(BuildContext context, HomeViewModel viewModel, Widget pokemonSprite, Widget peerPokemonSprite) {
    return SizedBox(
      width: double.infinity,
      height: 350,
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
            SizedBox.shrink()
        ],
      ),
    );
  }

  Widget _buildOpenPokemonButton(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.pokemon == null || viewModel.pokemon!.level >= 50) {
      return ElevatedButton(
        onPressed: () async {
          await viewModel.openNewPokemon();
        },
        child: const Text("Open Your Next Pokémon!"),
      );
    } else {
      return SizedBox.shrink();
    }
  }

  Widget _buildPokemonInfo(BuildContext context, HomeViewModel viewModel) {
    if (viewModel.pokemon != null){
        return Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Level: ${viewModel.pokemon!.level}",
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                "Experience: ${viewModel.pokemon!.experience}",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          ),
        );
    }
    return const SizedBox.shrink();
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
              _buildPokemonInfo(context, viewModel),
              const SizedBox(height: 16),
              FocusTimer(
                duration: const Duration(minutes: 25),
                onFinished: (elapsedMinutes) {
                  // use elapsed minutes as exp (1 minute = 1 exp)
                  viewModel.checkForLevelUp(elapsedMinutes);
                },
              ),
              const SizedBox(height: 12),
              _buildConnectButton(context),
              const SizedBox(height: 24),
              _buildOpenPokemonButton(context, viewModel)
            ],
          ),
        ),
      ),
    );
  }
}