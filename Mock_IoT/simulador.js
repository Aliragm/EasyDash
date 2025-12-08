import mqtt from 'mqtt';

// Configurações
const BROKER_URL = 'mqtt://test.mosquitto.org';
const TOPIC = 'sensores/leitura';
const SENSOR_ID = 'sensor_sala_01';

// Conecta no Broker
console.log(`🔌 Conectando ao broker ${BROKER_URL}...`);
const client = mqtt.connect(BROKER_URL);

client.on('connect', () => {
  console.log('✅ Conectado! Iniciando envio de dados...');
  console.log(`📡 Tópico: ${TOPIC} | ID: ${SENSOR_ID}`);
  console.log('------------------------------------------------');

  let tick = 0;

  setInterval(() => {
    tick += 0.1;

    const tempBase = 25 + Math.sin(tick) * 3; 
    const temp = (tempBase + (Math.random() * 0.5)).toFixed(1);

    const umidBase = 50 + Math.cos(tick) * 10;
    const umid = (umidBase + (Math.random() * 2)).toFixed(1);

    const payload = JSON.stringify({
      id: SENSOR_ID,
      temperatura: parseFloat(temp),
      umidade: parseFloat(umid)
    });

    client.publish(TOPIC, payload);
    
    console.log(`📤 [${new Date().toLocaleTimeString()}] Temp: ${temp}°C | Umid: ${umid}%`);

  }, 30000);
});

client.on('error', (err) => {
  console.error('❌ Erro de conexão:', err);
});