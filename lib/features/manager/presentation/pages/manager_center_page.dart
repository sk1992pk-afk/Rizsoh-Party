import 'package:flutter/material.dart';

class ManagerCenterPage extends StatefulWidget {
  const ManagerCenterPage({Key? key}) : super(key: key);

  @override
  State<ManagerCenterPage> createState() => _ManagerCenterPageState();
}

class _ManagerCenterPageState extends State<ManagerCenterPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Center'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Regulations'),
            Tab(text: 'Management'),
            Tab(text: 'Salary'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildRegulationsTab(),
          _buildManagementTab(),
          _buildSalaryTab(),
        ],
      ),
    );
  }

  Widget _buildRegulationsTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWarningBanner(),
          const SizedBox(height: 24),
          Text(
            'Platform Regulations',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildRegulationItem('No Spam or Harassment',
              'Maintain respectful communication with all users'),
          _buildRegulationItem('No Illegal Content',
              'Do not share or promote illegal activities'),
          _buildRegulationItem('Fair Play Policy',
              'No cheating or exploiting in games'),
          _buildRegulationItem('Payment Security',
              'Protect your account credentials'),
        ],
      ),
    );
  }

  Widget _buildManagementTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          GridView.count(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            children: [
              _buildManagerCard(
                title: 'Add Team Members',
                icon: Icons.person_add,
                onTap: () {},
              ),
              _buildManagerCard(
                title: 'Add Guild/Agency',
                icon: Icons.business,
                onTap: () {},
              ),
              _buildManagerCard(
                title: 'Send Gifts',
                icon: Icons.card_giftcard,
                onTap: () {},
              ),
              _buildManagerCard(
                title: 'Weekly Reward',
                icon: Icons.card_giftcard,
                onTap: () {},
              ),
              _buildManagerCard(
                title: 'Violating Users',
                icon: Icons.warning,
                onTap: () {},
              ),
              _buildManagerCard(
                title: 'Update Wealth',
                icon: Icons.trending_up,
                onTap: () {},
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Promotion Levels',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 12),
          _buildPromotionLevel('Associate', '★', 0, 50),
          _buildPromotionLevel('Senior Associate', '★★', 50, 100),
          _buildPromotionLevel('Admin', '★★★', 100, 100),
        ],
      ),
    );
  }

  Widget _buildSalaryTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Current Salary Card
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF7B2CBF), width: 2),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Current Salary',
                  style: TextStyle(color: Colors.white70),
                ),
                const SizedBox(height: 8),
                const Text(
                  '\$153.68',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFFD700),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSalaryComponent('Base', '\$100'),
                    _buildSalaryComponent('Salary 1', '\$30'),
                    _buildSalaryComponent('Salary 2', '\$23.68'),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Salary 1 - Agency Opening
          _buildSalarySection(
            title: 'Salary 1 - Agency Opening',
            target: '0/500,000 Diamonds',
            tiers: [
              {'name': 'T1', 'amount': '\$5'},
              {'name': 'T2', 'amount': '\$15'},
              {'name': 'T3', 'amount': '\$30'},
              {'name': 'T4', 'amount': '\$50'},
            ],
          ),
          const SizedBox(height: 16),
          // Salary 2 - Revenue Commission
          _buildSalarySection(
            title: 'Salary 2 - Revenue Commission',
            subtitle: 'This month: \$33.68 | All guild: \$329.2',
            tiers: [],
          ),
        ],
      ),
    );
  }

  Widget _buildWarningBanner() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFF006E).withOpacity(0.2),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFF006E), width: 1.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning, color: Color(0xFFFF006E)),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Account will be deleted in 7 days. Add 10+ active guilds.',
              style: TextStyle(
                color: const Color(0xFFFF006E),
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRegulationItem(String title, String description) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7B2CBF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            description,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildManagerCard({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPromotionLevel(
    String title,
    String stars,
    int current,
    int target,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7B2CBF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              Text(
                stars,
                style: const TextStyle(
                  color: Color(0xFFFFD700),
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: current / target,
            minHeight: 6,
            backgroundColor: const Color(0xFF0F0F1E),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF7B2CBF)),
          ),
        ],
      ),
    );
  }

  Widget _buildSalaryComponent(String label, String amount) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          amount,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFFD700),
          ),
        ),
      ],
    );
  }

  Widget _buildSalarySection({
    required String title,
    String? subtitle,
    required List<Map<String, String>> tiers,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF7B2CBF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          if (subtitle != null) ...
            [
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
            ]
          else
            ...
            [
              const SizedBox(height: 8),
              Text(
                '0/500,000 Diamonds',
                style: const TextStyle(
                  color: Color(0xFF00D9FF),
                  fontSize: 12,
                ),
              ),
              const SizedBox(height: 12),
              GridView.count(
                crossAxisCount: 4,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: tiers.map((tier) {
                  return Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F1E),
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: const Color(0xFF7B2CBF)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          tier['name']!,
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          tier['amount']!,
                          style: const TextStyle(
                            fontSize: 10,
                            color: Color(0xFFFFD700),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ]
        ],
      ),
    );
  }
}
