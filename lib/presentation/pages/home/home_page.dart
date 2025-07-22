import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zenmon/presentation/pages/home/home_view_model.dart';
import 'package:zenmon/presentation/pages/home/peer_connection_view_model.dart';
import 'package:zenmon/presentation/widgets/focus_timer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

    Widget _buildConnectionState(BuildContext context, bool isConnected) {
      Color bgColor = isConnected ? Colors.green : Colors.grey;
      Color txtColor = Colors.white;
      String txt = isConnected ? "Connected" : "Standby";
      return Container(
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        margin: const EdgeInsets.only(bottom: 16),
        child: Text(
          txt,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(color: txtColor),
        ),
      );
    }

  @override
  void initState() {
    super.initState();

    context.read<HomeViewModel>().loadPokemon(Random().nextInt(649) + 1);
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<HomeViewModel>();
    final peerConnectionVM = Provider.of<PeerConnectionViewModel>(context);
    peerConnectionVM.userImageUrl = viewModel.pokemon?.animatedSpriteUrl ?? "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-v/black-white/animated/12.gif";

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
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
              Consumer<PeerConnectionViewModel>(
                builder: (context, vm, child) {
                  return _buildConnectionState(context, vm.isConnected);
                },
              ),
              const Text(
                'Your Peer ID:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Consumer<PeerConnectionViewModel>(
                builder: (context, vm, child) {
                  return SelectableText(
                    vm.peerId ?? "Loading...",
                    style: const TextStyle(fontSize: 18, color: Colors.blue),
                  );
                },
              ),
              const SizedBox(height: 8),
              TextField(
                controller: peerConnectionVM.remotePeerIdController,
                decoration: InputDecoration(
                  labelText: 'Friend\'s Peer ID',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
              const SizedBox(height: 12),
              FocusTimer(
                duration: const Duration(minutes: 25),
                onFinished: () {},
              ),
              const SizedBox(height: 12),
              ElevatedButton(
                onPressed: () {
                  // if connected will send our own pokemon animation, if not found, send weedle 
                  peerConnectionVM.userImageUrl = viewModel.pokemon?.animatedSpriteUrl;
                  peerConnectionVM.connect();
                },
                child: Text("Connect To Another Trainer!"),
              ),
              const SizedBox(height: 8),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: peerConnectionVM.isConnected ? peerConnectionVM.closeConnection : null,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text("Close connection"),
              ),
              const SizedBox(height: 12),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                padding: const EdgeInsets.all(12.0),
                height: 200, // Set a fixed height for the message list
                child: Consumer<PeerConnectionViewModel>(
                  builder: (context, vm, child) {
                    return ListView.builder(
                      itemCount: vm.messages.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4.0),
                          child: Text(vm.messages[index]),
                        );
                      },
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

}
