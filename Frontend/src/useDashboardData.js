import { useState, useEffect } from 'react';

// Função auxiliar para gerar dados falsos
const generateMockData = () => {
    const historyData = Array.from({ length: 8 }, (_, i) => {
        const labels = ['12am', '4am', '8am', '12pm', '4pm', '8pm', 'Now'];
        const baseTemp = 22 + Math.sin(i) * 2 + Math.random(); 
        const baseHum = 45 + Math.cos(i) * 5 + Math.random() * 2;
        return {
            time: labels[i % labels.length] || '',
            temp: parseFloat(baseTemp.toFixed(1)),
            humidity: Math.round(baseHum),
        };
    }).slice(0, 7);

  return {
    status: 'Normal',
    currentTemp: 22.5,
    currentHumidity: 45,
    tempTrend: '+1.2%',
    humidityTrend: '-0.5%',
    history: historyData,
    alerts: [
      { id: 1, type: 'error', title: 'High Temp Alert', value: 'Value: 30.2°C', time: '14:35' },
      { id: 2, type: 'error', title: 'High Temp Alert', value: 'Value: 29.8°C', time: '11:15' },
      { id: 3, type: 'warning', title: 'Low Humidity Alert', value: 'Value: 25%', time: '22:05' },
    ]
  };
};

export const useDashboardData = () => {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const timer = setTimeout(() => {
      setData(generateMockData());
      setLoading(false);
    }, 1000);
    return () => clearTimeout(timer);
  }, []);

  return { data, loading };
};