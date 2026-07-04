import 'package:flutter/material.dart';

class GamesPage extends StatelessWidget {
  const GamesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Games Arena'),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildSectionHeader('Play Together', context),
                const SizedBox(height: 12),
                _buildGameGrid(['WorldCup', 'Domino']),
                const SizedBox(height: 24),
                _buildSectionHeader('Friend\'s Games', context),
                const SizedBox(height: 12),
                _buildGameGrid(['Ludo', 'Carrom', 'UNO', 'Baloott', 'Domino', 'Pool8']),
                const SizedBox(height: 24),
                _buildSectionHeader('Hot Games', context),
                const SizedBox(height: 12),
                _buildGameGrid(['Fishing', 'HappyFish', 'Greedystar']),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title, BuildContext context) {
    return Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    );
  }

  Widget _buildGameGrid(List<String> games) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 1,
      ),
      itemCount: games.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _buildGameCard(games[index]);
      },
    );
  }

  Widget _buildGameCard(String gameName) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF7B2CBF), width: 2),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.sports_esports, size: 40, color: Color(0xFFFFD700)),
            const SizedBox(height: 8),
            Text(
              gameName,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
