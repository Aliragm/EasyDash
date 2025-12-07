import React, { useState } from 'react';
import { Box, AlertCircle, AlertTriangle, Droplets, Thermometer } from 'lucide-react';
import { AreaChart, Area, XAxis, Tooltip, ResponsiveContainer } from 'recharts';

// --- Mock Data ---
const tempHistoryData = [
  { time: '12am', value: 20 },
  { time: '4am', value: 18 },
  { time: '8am', value: 21 },
  { time: '12pm', value: 24 },
  { time: '4pm', value: 23 },
  { time: '8pm', value: 22 },
  { time: 'Now', value: 22.5 },
];

const humidityHistoryData = [
  { time: '12am', value: 50 },
  { time: '4am', value: 55 },
  { time: '8am', value: 52 },
  { time: '12pm', value: 48 },
  { time: '4pm', value: 46 },
  { time: '8pm', value: 47 },
  { time: 'Now', value: 45 },
];

const alertsData = [
  {
    id: 1,
    type: 'critical',
    title: 'High Temperature Alert',
    value: '30.2°C',
    time: '2023-10-27 14:35:10',
  },
  {
    id: 2,
    type: 'critical',
    title: 'High Temperature Alert',
    value: '29.8°C',
    time: '2023-10-27 11:15:45',
  },
  {
    id: 3,
    type: 'warning',
    title: 'Low Humidity Alert',
    value: '25%',
    time: '2023-10-26 22:05:12',
  },
];

const EasyDash = () => {
  const [activeFilter, setActiveFilter] = useState('24h');

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 p-6 font-sans">
      <div className="max-w-7xl mx-auto space-y-6">

        {/* 1. Header */}
        <header className="flex items-center gap-3 border-b border-slate-700 pb-4">
          <div className="p-2 bg-blue-500/10 rounded-lg">
            <Box className="w-8 h-8 text-blue-500" strokeWidth={2} />
          </div>
          <h1 className="text-2xl font-bold text-white tracking-tight">EasyDash</h1>
        </header>

        {/* 2. Top Row (Key Metrics) */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* Card 1: Status */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <h3 className="text-slate-400 font-medium mb-1">Current Status</h3>
            <div className="text-4xl font-bold text-green-500">Normal</div>
          </div>

          {/* Card 2: Temperature */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50 flex justify-between items-start">
            <div>
              <h3 className="text-slate-400 font-medium mb-1">Temperature</h3>
              <div className="text-4xl font-bold text-white">22.5°C</div>
            </div>
            <div className="p-2 bg-blue-500/10 rounded-lg">
              <Thermometer className="w-6 h-6 text-blue-500" />
            </div>
          </div>

          {/* Card 3: Humidity */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50 flex justify-between items-start">
            <div>
              <h3 className="text-slate-400 font-medium mb-1">Humidity</h3>
              <div className="text-4xl font-bold text-white">45%</div>
            </div>
            <div className="p-2 bg-blue-500/10 rounded-lg">
              <Droplets className="w-6 h-6 text-blue-500" />
            </div>
          </div>
        </div>

        {/* 3. Filter Bar */}
        <div className="flex justify-start">
          <div className="bg-slate-800 p-1 rounded-lg inline-flex border border-slate-700/50">
            {['24h', '7d', '30d'].map((filter) => (
              <button
                key={filter}
                onClick={() => setActiveFilter(filter)}
                className={`px-4 py-1.5 rounded-md text-sm font-medium transition-all duration-200 ${activeFilter === filter
                    ? 'bg-slate-700 text-white shadow-sm'
                    : 'text-slate-400 hover:text-slate-200 hover:bg-slate-700/50'
                  }`}
              >
                {filter}
              </button>
            ))}
          </div>
        </div>

        {/* 4. Middle Row (Charts) */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Card 1: Temperature History */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <div className="flex justify-between items-baseline mb-6">
              <div>
                <h3 className="text-slate-400 font-medium text-sm mb-1">Temperature History</h3>
                <div className="flex items-baseline gap-3">
                  <span className="text-3xl font-bold text-white">22.5°C</span>
                  <span className="text-sm font-medium text-green-500 bg-green-500/10 px-2 py-0.5 rounded-full">
                    +1.2% in last 24h
                  </span>
                </div>
              </div>
            </div>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={tempHistoryData}>
                  <defs>
                    <linearGradient id="colorTemp" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <Tooltip
                    contentStyle={{ backgroundColor: '#1e293b', borderColor: '#334155', color: '#f8fafc' }}
                    itemStyle={{ color: '#f8fafc' }}
                    labelStyle={{ color: '#94a3b8' }}
                  />
                  <XAxis
                    dataKey="time"
                    axisLine={false}
                    tickLine={false}
                    tick={{ fill: '#94a3b8', fontSize: 12 }}
                    dy={10}
                  />
                  <Area
                    type="monotone"
                    dataKey="value"
                    stroke="#3b82f6"
                    strokeWidth={3}
                    fillOpacity={1}
                    fill="url(#colorTemp)"
                  />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>

          {/* Card 2: Humidity History */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <div className="flex justify-between items-baseline mb-6">
              <div>
                <h3 className="text-slate-400 font-medium text-sm mb-1">Humidity History</h3>
                <div className="flex items-baseline gap-3">
                  <span className="text-3xl font-bold text-white">45%</span>
                  <span className="text-sm font-medium text-red-500 bg-red-500/10 px-2 py-0.5 rounded-full">
                    -0.5% in last 24h
                  </span>
                </div>
              </div>
            </div>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={humidityHistoryData}>
                  <defs>
                    <linearGradient id="colorHum" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <Tooltip
                    contentStyle={{ backgroundColor: '#1e293b', borderColor: '#334155', color: '#f8fafc' }}
                    itemStyle={{ color: '#f8fafc' }}
                    labelStyle={{ color: '#94a3b8' }}
                  />
                  <XAxis
                    dataKey="time"
                    axisLine={false}
                    tickLine={false}
                    tick={{ fill: '#94a3b8', fontSize: 12 }}
                    dy={10}
                  />
                  <Area
                    type="monotone"
                    dataKey="value"
                    stroke="#3b82f6"
                    strokeWidth={3}
                    fillOpacity={1}
                    fill="url(#colorHum)"
                  />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

        {/* 5. Bottom Row (Recent Alerts) */}
        <div className="bg-slate-800 rounded-xl shadow-lg border border-slate-700/50 overflow-hidden">
          <div className="p-6 border-b border-slate-700/50">
            <h2 className="text-lg font-bold text-white">Recent Alerts</h2>
          </div>
          <div>
            {alertsData.map((alert, index) => (
              <div
                key={alert.id}
                className={`p-4 flex flex-col sm:flex-row sm:items-center justify-between gap-4 hover:bg-slate-700/30 transition-colors ${index !== alertsData.length - 1 ? 'border-b border-slate-700/50' : ''
                  }`}
              >
                <div className="flex items-start gap-4">
                  <div className={`mt-1 p-2 rounded-full ${alert.type === 'critical' ? 'bg-red-500/10 text-red-500' : 'bg-yellow-500/10 text-yellow-500'
                    }`}>
                    {alert.type === 'critical' ? <AlertCircle size={20} /> : <AlertTriangle size={20} />}
                  </div>
                  <div>
                    <h4 className="font-semibold text-white">{alert.title}</h4>
                    <p className="text-slate-400 text-sm mt-0.5">Value: {alert.value}</p>
                  </div>
                </div>
                <div className="text-slate-500 text-sm font-mono whitespace-nowrap pl-14 sm:pl-0">
                  {alert.time}
                </div>
              </div>
            ))}
          </div>
        </div>

      </div>
    </div>
  );
};

export default EasyDash;