import React from 'react';
import { useAuth } from '../context/AuthContext';

const Dashboard = () => {
  const { user } = useAuth();

  return (
    <div>
      <h1 className="text-2xl font-bold mb-6 text-gray-900 dark:text-white">Dashboard</h1>
      <div className="bg-white dark:bg-gray-800 shadow rounded-lg p-6">
        <h2 className="text-lg font-medium text-gray-900 dark:text-white mb-4">Welcome, {user?.email}!</h2>
        <p className="text-gray-600 dark:text-gray-400">
          This is the dashboard of your budget tracker. More features will be added soon.
        </p>
      </div>
    </div>
  );
};

export default Dashboard;