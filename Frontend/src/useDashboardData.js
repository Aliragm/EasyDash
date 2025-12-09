import { useState, useEffect, useRef } from 'react';
import { Socket } from 'phoenix';
import { format } from 'date-fns';

// 1. Pega a URL do .env (Railway) ou usa localhost
const API_URL = import.meta.env.VITE_API_URL || "http://localhost:4000/api";

// 2. Converte HTTP -> WS e HTTPS -> WSS automaticamente
const WS_URL = API_URL.replace('http', 'ws').replace('/api', '/socket');

export const useDashboardData = (sensorId, token) => {
  const [history, setHistory] = useState([]);
  const [current, setCurrent] = useState({ temp: 0, humidity: 0 });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState(null);
  
  const socketRef = useRef(null);

  // 1. Busca Histórico Inicial (HTTP)
  useEffect(() => {
    if (!token || !sensorId) return;

    // --- CORREÇÃO: LIMPEZA DE ESTADO ---
    setError(null);     // Limpa o erro do sensor anterior
    setLoading(true);   // Volta pro estado de carregamento
    setHistory([]);     // Limpa o gráfico antigo para não misturar
    // -----------------------------------

    const fetchHistory = async () => {
      try {
        const response = await fetch(`${API_URL}/leituras?sensor_id=${sensorId}`, {
          headers: { 'Authorization': `Bearer ${token}` }
        });
        
        if (!response.ok) {
            // Se der 404 ou 403, lança erro para cair no catch
            const json = await response.json().catch(() => ({})); 
            throw new Error(json.error || 'Sensor não encontrado ou acesso negado');
        }
        
        const json = await response.json();
        
        const formattedData = json.data.map(item => {
            let timeLabel = "--:--";
            try {
                timeLabel = format(new Date(item.data_hora), 'HH:mm');
            } catch (e) { console.warn("Data inválida", item); }

            return {
                time: timeLabel,
                temp: Number(item.temperatura),
                humidity: Number(item.umidade)
            };
        }).reverse();

        setHistory(formattedData);
        
        if (formattedData.length > 0) {
          const last = formattedData[formattedData.length - 1];
          setCurrent({ temp: last.temp, humidity: last.humidity });
        }
      } catch (err) {
        console.error("Erro no fetch:", err);
        setError(err.message);
      } finally {
        setLoading(false);
      }
    };

    fetchHistory();
  }, [sensorId, token]); // <--- Isso garante que roda toda vez que o sensorId muda

  // 2. Conexão Real-Time (WebSocket)
  useEffect(() => {
    if (!token || !sensorId) return;

    const socket = new Socket(WS_URL, { params: { token } });
    socket.connect();
    socketRef.current = socket;

    const channel = socket.channel(`sensor:${sensorId}`, {});

    channel.join()
      .receive("ok", () => console.log(`🟢 Conectado ao ${sensorId}!`))
      .receive("error", resp => console.error("🔴 Erro ao conectar:", resp));

    channel.on("leitura_chegou", (payload) => {
      try {
          // Lógica de proteção contra dados ruins
          const rawDate = payload.hora || payload.data_hora || payload.inserted_at || new Date();
          let timeLabel;
          try { timeLabel = format(new Date(rawDate), 'HH:mm'); } 
          catch (e) { timeLabel = format(new Date(), 'HH:mm'); }

          const newData = {
            time: timeLabel,
            temp: Number(payload.temp || payload.temperatura || 0),
            humidity: Number(payload.umid || payload.umidade || 0)
          };

          setCurrent({ temp: newData.temp, humidity: newData.humidity });
          setHistory(prev => {
            const newHistory = [...prev, newData];
            if (newHistory.length > 20) newHistory.shift(); 
            return newHistory;
          });
      } catch (err) { console.error("🔥 Erro socket:", err); }
    });

    return () => {
      channel.leave();
      socket.disconnect();
    };
  }, [sensorId, token]);

  return { history, current, loading, error };
};
