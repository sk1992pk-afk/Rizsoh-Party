import React, { useState } from 'react';

const Managers = () => {
  const [managers] = useState([
    {
      id: '1',
      name: 'Manager One',
      role: 'Admin',
      agency: 'Gaming Guild Alpha',
      salary: '$153.68',
      members: 25,
      revenue: '$2,500',
    },
    {
      id: '2',
      name: 'Manager Two',
      role: 'BD',
      agency: 'Gaming Guild Beta',
      salary: '$98.50',
      members: 15,
      revenue: '$1,200',
    },
  ]);

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Manager Center</h1>

      {/* Quick Actions */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
        <button className="bg-blue-600 hover:bg-blue-700 text-white py-3 rounded-lg font-bold transition">
          Create Agency
        </button>
        <button className="bg-green-600 hover:bg-green-700 text-white py-3 rounded-lg font-bold transition">
          Hire Manager
        </button>
        <button className="bg-purple-600 hover:bg-purple-700 text-white py-3 rounded-lg font-bold transition">
          Review Salary
        </button>
      </div>

      {/* Managers Table */}
      <div className="bg-gray-800 rounded-lg overflow-hidden shadow-lg">
        <table className="w-full text-white">
          <thead className="bg-gray-700">
            <tr>
              <th className="px-6 py-3 text-left">Name</th>
              <th className="px-6 py-3 text-left">Role</th>
              <th className="px-6 py-3 text-left">Agency</th>
              <th className="px-6 py-3 text-left">Members</th>
              <th className="px-6 py-3 text-left">Monthly Revenue</th>
              <th className="px-6 py-3 text-left">Salary</th>
              <th className="px-6 py-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {managers.map((manager) => (
              <tr key={manager.id} className="border-b border-gray-700 hover:bg-gray-700">
                <td className="px-6 py-3 font-semibold">{manager.name}</td>
                <td className="px-6 py-3">
                  <span className="bg-yellow-600 px-3 py-1 rounded-full text-sm font-bold">
                    {manager.role}
                  </span>
                </td>
                <td className="px-6 py-3">{manager.agency}</td>
                <td className="px-6 py-3">{manager.members}</td>
                <td className="px-6 py-3 text-green-400 font-bold">{manager.revenue}</td>
                <td className="px-6 py-3 text-yellow-400 font-bold">{manager.salary}</td>
                <td className="px-6 py-3">
                  <button className="bg-blue-600 hover:bg-blue-700 px-3 py-1 rounded text-sm">
                    View
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

export default Managers;
