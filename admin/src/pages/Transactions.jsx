import React, { useState } from 'react';

const Transactions = () => {
  const [transactions] = useState([
    {
      id: '1',
      userId: 'User #12345',
      type: 'purchase',
      amount: '9000 coins',
      price: 'AED 3.79',
      method: 'TapPay',
      date: '2024-01-15',
      status: 'completed',
    },
    {
      id: '2',
      userId: 'User #54321',
      type: 'gift',
      amount: '1000 coins',
      price: 'N/A',
      method: 'In-app',
      date: '2024-01-15',
      status: 'completed',
    },
    {
      id: '3',
      userId: 'User #99999',
      type: 'withdrawal',
      amount: '$50',
      price: 'N/A',
      method: 'Bank Transfer',
      date: '2024-01-14',
      status: 'pending',
    },
  ]);

  const getStatusColor = (status) => {
    return status === 'completed' ? 'text-green-400' : 'text-yellow-400';
  };

  const getTypeIcon = (type) => {
    const icons = {
      purchase: '💳',
      gift: '🎁',
      withdrawal: '💰',
      exchange: '🔄',
    };
    return icons[type] || '📝';
  };

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Transactions</h1>

      <div className="bg-gray-800 rounded-lg overflow-hidden shadow-lg">
        <table className="w-full text-white">
          <thead className="bg-gray-700">
            <tr>
              <th className="px-6 py-3 text-left">User</th>
              <th className="px-6 py-3 text-left">Type</th>
              <th className="px-6 py-3 text-left">Amount</th>
              <th className="px-6 py-3 text-left">Price</th>
              <th className="px-6 py-3 text-left">Method</th>
              <th className="px-6 py-3 text-left">Date</th>
              <th className="px-6 py-3 text-left">Status</th>
            </tr>
          </thead>
          <tbody>
            {transactions.map((tx) => (
              <tr key={tx.id} className="border-b border-gray-700 hover:bg-gray-700">
                <td className="px-6 py-3 font-semibold">{tx.userId}</td>
                <td className="px-6 py-3">
                  <span className="mr-2">{getTypeIcon(tx.type)}</span>
                  {tx.type}
                </td>
                <td className="px-6 py-3 text-yellow-400">{tx.amount}</td>
                <td className="px-6 py-3 font-semibold">{tx.price}</td>
                <td className="px-6 py-3">{tx.method}</td>
                <td className="px-6 py-3 text-gray-400">{tx.date}</td>
                <td className={`px-6 py-3 ${getStatusColor(tx.status)}`}>
                  {tx.status.toUpperCase()}
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Transactions;
