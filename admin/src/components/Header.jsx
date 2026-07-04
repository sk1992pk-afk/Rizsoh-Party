import React from 'react';

const Header = () => {
  return (
    <header className="bg-gray-800 border-b border-gray-700 px-6 py-4 shadow">
      <div className="flex justify-between items-center">
        <h2 className="text-2xl font-bold text-white">Admin Dashboard</h2>
        <div className="flex items-center gap-4">
          <div className="flex items-center gap-3">
            <div className="w-10 h-10 bg-yellow-400 rounded-full flex items-center justify-center">
              <span className="text-gray-900 font-bold">SA</span>
            </div>
            <div>
              <p className="text-white font-semibold">Super Admin</p>
              <p className="text-gray-400 text-sm">admin@rizsoh.app</p>
            </div>
          </div>
        </div>
      </div>
    </header>
  );
};

export default Header;
