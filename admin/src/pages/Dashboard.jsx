import React, { useState, useEffect } from 'react';
import axios from 'axios';

const Dashboard = () => {
  const [stats, setStats] = useState({
    totalUsers: 0,
    activeRooms: 0,
    totalRevenue: 0,
    totalTransactions: 0,
  });

  useEffect(() => {
    const fetchStats = async () => {
      try {
        // Replace with actual API calls
        setStats({
          totalUsers: 5432,
          activeRooms: 128,
          totalRevenue: 45230.5,
          totalTransactions: 12584,
        });
      } catch (error) {
        console.error('Error fetching stats:', error);
      }
    };

    fetchStats();
  }, []);

  const StatCard = ({ title, value, icon, color }) => (
    <div className={`${color} rounded-lg p-6 text-white shadow-lg`}>
      <div className="flex justify-between items-start">
        <div>
          <p className="text-gray-200 text-sm font-medium">{title}</p>
          <p className="text-3xl font-bold mt-2">{value}</p>
        </div>
        <span className="text-4xl opacity-20">{icon}</span>
      </div>
    </div>
  );

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Dashboard</h1>

      {/* Statistics Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
        <StatCard
          title="Total Users"
          value={stats.totalUsers.toLocaleString()}
          icon="👥"
          color="bg-blue-600"
        />
        <StatCard
          title="Active Rooms"
          value={stats.activeRooms.toLocaleString()}
          icon="🎤"
          color="bg-purple-600"
        />
        <StatCard
          title="Total Revenue"
          value={`AED ${stats.totalRevenue.toFixed(2)}`}
          icon="💰"
          color="bg-green-600"
        />
        <StatCard
          title="Transactions"
          value={stats.totalTransactions.toLocaleString()}
          icon="💳"
          color="bg-yellow-600"
        />
      </div>

      {/* Recent Activities */}
      <div className="bg-gray-800 rounded-lg p-6 text-white shadow-lg">
        <h2 className="text-xl font-bold mb-4">Recent Activities</h2>
        <div className="space-y-3">
          {[
            { user: 'User #12345', action: 'Joined room', time: '2 min ago' },
            { user: 'User #54321', action: 'Purchased 9000 coins', time: '5 min ago' },
            { user: 'Manager #001', action: 'Created agency', time: '15 min ago' },
            { user: 'User #99999', action: 'Completed tournament', time: '1 hour ago' },
          ].map((activity, idx) => (
            <div key={idx} className="flex justify-between items-center border-b border-gray-700 pb-3">
              <div>
                <p className="font-semibold">{activity.user}</p>
                <p className="text-gray-400 text-sm">{activity.action}</p>
              </div>
              <span className="text-gray-500 text-sm">{activity.time}</span>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
