import React, { useState } from 'react';
import { Box, Droplets, Thermometer } from 'lucide-react';
import { AreaChart, Area, XAxis, Tooltip, ResponsiveContainer } from 'recharts';
import { useDashboardData } from './useDashboardData';

const EasyDash = ({ token, onLogout }) => {
  // Estado para controlar qual sensor estamos vendo
  const [sensorId, setSensorId] = useState('sensor_sala_01'); 
  const [tempId, setTempId] = useState('sensor_sala_01'); // Só pro input

  // Chama nosso Hook poderoso
  const { history, current, loading, error } = useDashboardData(sensorId, token);

  if (loading && history.length === 0) return <div className="text-white p-10">Carregando dados do IoT...</div>;
  if (error) return <div className="text-red-500 p-10">Erro: {error}</div>;

  return (
    <div className="min-h-screen bg-slate-900 text-slate-100 p-6 font-sans">
      <div className="max-w-7xl mx-auto space-y-6">

        {/* HEADER & CONFIG */}
        <header className="flex flex-col md:flex-row justify-between items-center border-b border-slate-700 pb-4 gap-4">
          <div className="flex items-center gap-3">
            <div className="p-2 bg-blue-500/10 rounded-lg">
              <Box className="w-8 h-8 text-blue-500" strokeWidth={2} />
            </div>
            <h1 className="text-2xl font-bold text-white tracking-tight">EasyDash</h1>
          </div>
          
          <div className="flex gap-2">
            <input 
              value={tempId} 
              onChange={(e) => setTempId(e.target.value)}
              className="bg-slate-800 border border-slate-600 rounded px-3 text-white"
              placeholder="ID do Sensor (ex: sensor_01)"
            />
            <button 
              onClick={() => setSensorId(tempId)}
              className="bg-blue-600 px-4 py-2 rounded text-sm hover:bg-blue-500"
            >
              Monitorar
            </button>
            <button onClick={onLogout} className="text-slate-400 text-sm hover:text-white ml-4">Sair</button>
          </div>
        </header>

        {/* CARDS DE MÉTRICAS */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6">
          {/* Status */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <h3 className="text-slate-400 font-medium mb-1">Status do Sensor</h3>
            <div className={`text-4xl font-bold ${current.temp > 30 ? 'text-red-500' : 'text-green-500'}`}>
              {current.temp > 30 ? 'Alerta' : 'Normal'}
            </div>
            <div className="text-xs text-slate-500 mt-2">ID: {sensorId}</div>
          </div>

          {/* Temperatura */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50 flex justify-between items-start">
            <div>
              <h3 className="text-slate-400 font-medium mb-1">Temperatura</h3>
              <div className="text-4xl font-bold text-white">{current.temp.toFixed(1)}°C</div>
            </div>
            <div className="p-2 bg-blue-500/10 rounded-lg">
              <Thermometer className="w-6 h-6 text-blue-500" />
            </div>
          </div>

          {/* Umidade */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50 flex justify-between items-start">
            <div>
              <h3 className="text-slate-400 font-medium mb-1">Umidade</h3>
              <div className="text-4xl font-bold text-white">{current.humidity.toFixed(1)}%</div>
            </div>
            <div className="p-2 bg-blue-500/10 rounded-lg">
              <Droplets className="w-6 h-6 text-blue-500" />
            </div>
          </div>
        </div>

        {/* GRÁFICOS */}
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          {/* Gráfico Temperatura */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <h3 className="text-slate-400 font-medium text-sm mb-4">Histórico de Temperatura</h3>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={history}>
                  <defs>
                    <linearGradient id="colorTemp" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#3b82f6" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#3b82f6" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <Tooltip contentStyle={{ backgroundColor: '#1e293b', borderColor: '#334155', color: '#f8fafc' }} />
                  <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{ fill: '#94a3b8', fontSize: 12 }} dy={10} />
                  <Area type="monotone" dataKey="temp" stroke="#3b82f6" strokeWidth={3} fillOpacity={1} fill="url(#colorTemp)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>

          {/* Gráfico Umidade */}
          <div className="bg-slate-800 rounded-xl p-6 shadow-lg border border-slate-700/50">
            <h3 className="text-slate-400 font-medium text-sm mb-4">Histórico de Umidade</h3>
            <div className="h-64 w-full">
              <ResponsiveContainer width="100%" height="100%">
                <AreaChart data={history}>
                  <defs>
                    <linearGradient id="colorHum" x1="0" y1="0" x2="0" y2="1">
                      <stop offset="5%" stopColor="#10b981" stopOpacity={0.3} />
                      <stop offset="95%" stopColor="#10b981" stopOpacity={0} />
                    </linearGradient>
                  </defs>
                  <Tooltip contentStyle={{ backgroundColor: '#1e293b', borderColor: '#334155', color: '#f8fafc' }} />
                  <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{ fill: '#94a3b8', fontSize: 12 }} dy={10} />
                  <Area type="monotone" dataKey="humidity" stroke="#10b981" strokeWidth={3} fillOpacity={1} fill="url(#colorHum)" />
                </AreaChart>
              </ResponsiveContainer>
            </div>
          </div>
        </div>

      </div>
    </div>
  );
};

export default EasyDash;