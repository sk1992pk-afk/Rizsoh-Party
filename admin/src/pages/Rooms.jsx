import React, { useState } from 'react';

const Rooms = () => {
  const [rooms] = useState([
    {
      id: '1',
      title: 'Gaming Squad',
      host: 'ProGamer_',
      status: 'live',
      viewers: 234,
      category: 'Competitive',
    },
    {
      id: '2',
      title: 'Casual Hangout',
      host: 'SocialButterfly',
      status: 'live',
      viewers: 156,
      category: 'Social',
    },
    {
      id: '3',
      title: 'Tournament Mode',
      host: 'TourneyMaster',
      status: 'ended',
      viewers: 512,
      category: 'Tournament',
    },
  ]);

  const getStatusColor = (status) => {
    return status === 'live'
      ? 'bg-red-600 animate-pulse'
      : 'bg-gray-600';
  };

  return (
    <div className="space-y-6">
      <h1 className="text-3xl font-bold text-white">Rooms Management</h1>

      <div className="bg-gray-800 rounded-lg overflow-hidden shadow-lg">
        <table className="w-full text-white">
          <thead className="bg-gray-700">
            <tr>
              <th className="px-6 py-3 text-left">Room Title</th>
              <th className="px-6 py-3 text-left">Host</th>
              <th className="px-6 py-3 text-left">Category</th>
              <th className="px-6 py-3 text-left">Status</th>
              <th className="px-6 py-3 text-left">Viewers</th>
              <th className="px-6 py-3 text-left">Actions</th>
            </tr>
          </thead>
          <tbody>
            {rooms.map((room) => (
              <tr key={room.id} className="border-b border-gray-700 hover:bg-gray-700">
                <td className="px-6 py-3 font-semibold">{room.title}</td>
                <td className="px-6 py-3">{room.host}</td>
                <td className="px-6 py-3">{room.category}</td>
                <td className="px-6 py-3">
                  <span className={`${getStatusColor(room.status)} px-3 py-1 rounded-full text-sm font-bold text-white`}>
                    {room.status.toUpperCase()}
                  </span>
                </td>
                <td className="px-6 py-3">{room.viewers.toLocaleString()}</td>
                <td className="px-6 py-3">
                  <button className="bg-blue-600 hover:bg-blue-700 px-3 py-1 rounded text-sm mr-2">
                    View
                  </button>
                  <button className="bg-red-600 hover:bg-red-700 px-3 py-1 rounded text-sm">
                    Close
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

export default Rooms;
