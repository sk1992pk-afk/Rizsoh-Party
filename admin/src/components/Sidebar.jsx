import React from 'react';
import { Link, useLocation } from 'react-router-dom';

const Sidebar = () => {
  const location = useLocation();

  const menuItems = [
    { label: 'Dashboard', path: '/', icon: '📊' },
    { label: 'Users', path: '/users', icon: '👥' },
    { label: 'Managers', path: '/managers', icon: '👔' },
    { label: 'Rooms', path: '/rooms', icon: '🎤' },
    { label: 'Transactions', path: '/transactions', icon: '💳' },
    { label: 'Analytics', path: '/analytics', icon: '📈' },
  ];

  return (
    <div className="w-64 bg-gray-800 text-white p-6 shadow-lg">
      <div className="mb-8">
        <h1 className="text-2xl font-bold text-yellow-400">Rizsoh</h1>
        <p className="text-sm text-gray-400">Admin Panel</p>
      </div>

      <nav className="space-y-2">
        {menuItems.map((item) => (
          <Link
            key={item.path}
            to={item.path}
            className={`flex items-center gap-3 px-4 py-3 rounded-lg transition ${
              location.pathname === item.path
                ? 'bg-yellow-500 text-gray-900 font-bold'
                : 'text-gray-300 hover:bg-gray-700'
            }`}
          >
            <span>{item.icon}</span>
            <span>{item.label}</span>
          </Link>
        ))}
      </nav>

      <div className="mt-8 pt-8 border-t border-gray-700">
        <button className="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded-lg transition">
          Logout
        </button>
      </div>
    </div>
  );
};

export default Sidebar;
