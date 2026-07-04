import React, { useState } from 'react';

const Users = () => {
  const [users] = useState([
    { id: '1', name: 'Ahmed Ali', email: 'ahmed@email.com', role: 'user', coins: 5000, status: 'active' },
    { id: '2', name: 'Fatima Khan', email: 'fatima@email.com', role: 'bd', coins: 12000, status: 'active' },
    { id: '3', name: 'Mohammed Hassan', email: 'hassan@email.com', role: 'user', coins: 2500, status: 'active' },
    { id: '4', name: 'Sara Ahmad', email: 'sara@email.com', role: 'admin', coins: 50000, status: 'inactive' },
  ]);

  const getRoleColor = (role) => {
    const colors = {
      superAdmin: 'bg-red-600',
      admin: 'bg-blue-600',
      bd: 'bg-purple-600',
      user: 'bg-gray-600',
    };
    return colors[role] || 'bg-gray-600';
  };

  const getStatusColor = (status) => {
    return status === 'active' ? 'text-green-400' : 'text-red-400';
  };

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Users Management</h1>

      <div className="bg-gray-800 rounded-lg overflow-hidden shadow-lg">
        <table className="w-full text-white">
          <thead className="bg-gray-700">
            <tr>
              <th className="px-6 py-3 text-left">User ID</th>
              <th className="px-6 py-3 text-left">Name</th>
              <th className="px-6 py-3 text-left">Email</th>
              <th className="px-6 py-3 text-left">Role</th>
              <th className="px-6 py-3 text-left">Coins</th>
              <th className="px-6 py-3 text-left">Status</th>
              <th className="px-6 py-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {users.map((user) => (
              <tr key={user.id} className="border-b border-gray-700 hover:bg-gray-700">
                <td className="px-6 py-3">#{user.id}</td>
                <td className="px-6 py-3">{user.name}</td>
                <td className="px-6 py-3">{user.email}</td>
                <td className="px-6 py-3">
                  <span className={`${getRoleColor(user.role)} px-3 py-1 rounded-full text-sm font-bold`}>
                    {user.role}
                  </span>
                </td>
                <td className="px-6 py-3 font-semibold text-yellow-400">{user.coins}</td>
                <td className={`px-6 py-3 ${getStatusColor(user.status)}`}>
                  {user.status}
                </td>
                <td className="px-6 py-3">
                  <button className="bg-blue-600 hover:bg-blue-700 px-3 py-1 rounded text-sm mr-2">
                    Edit
                  </button>
                  <button className="bg-red-600 hover:bg-red-700 px-3 py-1 rounded text-sm">
                    Ban
                  </button>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default Users;
