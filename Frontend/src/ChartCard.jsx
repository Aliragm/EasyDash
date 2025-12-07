import React from 'react';
import {
  AreaChart, Area, XAxis, YAxis, Tooltip, ResponsiveContainer
} from 'recharts';
import Card from './Card'; // Importando do mesmo diretório

const ChartCard = ({ title, value, trend, data, dataKey, color }) => {
  return (
    <Card className="flex flex-col h-[350px]">
      <h3 className="text-slate-400 text-sm font-medium mb-1">{title} History</h3>
      <div className="text-3xl font-bold text-white mb-1">{value}</div>
      <div className={`text-sm mb-6 ${trend.startsWith('+') ? 'text-green-500' : 'text-red-500'}`}>
        Last 24h <span className="font-semibold">{trend}</span>
      </div>
      
      <div className="flex-1 w-full min-h-0">
        <ResponsiveContainer width="100%" height="100%">
          <AreaChart data={data} margin={{ top: 10, right: 10, left: -20, bottom: 0 }}>
            <defs>
              <linearGradient id={`color${dataKey}`} x1="0" y1="0" x2="0" y2="1">
                <stop offset="5%" stopColor={color} stopOpacity={0.8}/>
                <stop offset="95%" stopColor={color} stopOpacity={0}/>
              </linearGradient>
            </defs>
            <XAxis dataKey="time" axisLine={false} tickLine={false} tick={{ fill: '#64748b', fontSize: 12 }} dy={10} />
            <YAxis hide domain={['auto', 'auto']} />
            <Tooltip 
               contentStyle={{ backgroundColor: '#1e293b', borderColor: '#334155', color: '#fff' }}
               itemStyle={{ color: color }}
            />
            <Area type="monotone" dataKey={dataKey} stroke={color} fillOpacity={1} fill={`url(#color${dataKey})`} strokeWidth={3} />
          </AreaChart>
        </ResponsiveContainer>
      </div>
    </Card>
  );
};

export default ChartCard;