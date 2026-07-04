import React from 'react';
import { BarChart, Bar, LineChart, Line, XAxis, YAxis, CartesianGrid, Tooltip, Legend, ResponsiveContainer } from 'recharts';

const Analytics = () => {
  const dailyData = [
    { date: 'Jan 1', users: 120, revenue: 2400 },
    { date: 'Jan 2', users: 150, revenue: 2210 },
    { date: 'Jan 3', users: 200, revenue: 2290 },
    { date: 'Jan 4', users: 180, revenue: 2000 },
    { date: 'Jan 5', users: 250, revenue: 2181 },
    { date: 'Jan 6', users: 220, revenue: 2500 },
  ];

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Analytics</h1>

      {/* Daily Users Chart */}
      <div className="bg-gray-800 rounded-lg p-6 shadow-lg">
        <h2 className="text-xl font-bold text-white mb-4">Daily Active Users</h2>
        <ResponsiveContainer width="100%" height={300}>
          <LineChart data={dailyData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#444" />
            <XAxis dataKey="date" stroke="#999" />
            <YAxis stroke="#999" />
            <Tooltip
              contentStyle={{
                backgroundColor: '#1a1a1a',
                border: '1px solid #444',
              }}
            />
            <Legend />
            <Line type="monotone" dataKey="users" stroke="#00d9ff" strokeWidth={2} />
          </LineChart>
        </ResponsiveContainer>
      </div>

      {/* Daily Revenue Chart */}
      <div className="bg-gray-800 rounded-lg p-6 shadow-lg">
        <h2 className="text-xl font-bold text-white mb-4">Daily Revenue (AED)</h2>
        <ResponsiveContainer width="100%" height={300}>
          <BarChart data={dailyData}>
            <CartesianGrid strokeDasharray="3 3" stroke="#444" />
            <XAxis dataKey="date" stroke="#999" />
            <YAxis stroke="#999" />
            <Tooltip
              contentStyle={{
                backgroundColor: '#1a1a1a',
                border: '1px solid #444',
              }}
            />
            <Legend />
            <Bar dataKey="revenue" fill="#ffd700" />
          </BarChart>
        </ResponsiveContainer>
      </div>
    </div>
  );
};

export default Analytics;
