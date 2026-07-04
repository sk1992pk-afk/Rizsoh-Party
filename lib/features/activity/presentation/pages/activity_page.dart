import 'package:flutter/material.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text('Activity'),
            centerTitle: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                // Quick Actions
                GridView.count(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    _buildQuickActionCard('Recharge', Icons.account_balance_wallet),
                    _buildQuickActionCard('Daily Tasks', Icons.assignment),
                    _buildQuickActionCard('Weekly Star', Icons.star),
                    _buildQuickActionCard('Special ID', Icons.verified),
                  ],
                ),
                const SizedBox(height: 24),
                Text(
                  'Active Events',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 12),
                _buildEventBanner('🏆 King & Queen Tournament'),
                const SizedBox(height: 8),
                _buildEventBanner('💰 Complete Levels, Get Gold Coins'),
                const SizedBox(height: 8),
                _buildEventBanner('🎁 Mystery Box - Win 1,000 Times'),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionCard(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF7B2CBF), width: 1.5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 32, color: const Color(0xFFFFD700)),
          const SizedBox(height: 8),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Widget _buildEventBanner(String title) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFF00D9FF),
          width: 1.5,
        ),
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: Color(0xFF00D9FF),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
