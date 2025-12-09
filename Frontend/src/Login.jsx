import React, { useState } from 'react';

const Login = ({ onLogin }) => {
  const [isRegistering, setIsRegistering] = useState(false);
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');
  const [success, setSuccess] = useState('');

  const API_URL = import.meta.env.VITE_API_URL || "http://localhost:4000/api";

  const handleSubmit = async (e) => {
    e.preventDefault();
    setError('');
    setSuccess('');

    const endpoint = isRegistering ? '/register' : '/login';
    
    let bodyPayload;
    if (isRegistering) {
        bodyPayload = { user: { email, password } };
    } else {
        bodyPayload = { email, password };
    }

    try {
      // --- USO DA VARIÁVEL AQUI ---
      const res = await fetch(`${API_URL}${endpoint}`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(bodyPayload)
      });
      
      const data = await res.json();
      
      if (res.ok) {
        if (isRegistering) {
            setSuccess('Conta criada! Faça login agora.');
            setIsRegistering(false);
            setPassword('');
        } else {
            onLogin(data.token, data.user_id);
        }
      } else {
        const msg = data.error || (data.errors ? JSON.stringify(data.errors) : 'Erro na requisição');
        setError(msg);
      }
    } catch (err) {
      console.error(err); // Bom logar o erro pra debug
      setError('Erro de conexão com o servidor');
    }
  };

  return (
    <div className="min-h-screen bg-slate-900 flex items-center justify-center p-4 font-sans">
      <div className="bg-slate-800 p-8 rounded-xl shadow-lg w-full max-w-md border border-slate-700">
        <h1 className="text-2xl font-bold text-white mb-2 text-center">EasyDash IoT</h1>
        <p className="text-slate-400 text-center mb-6 text-sm">
            {isRegistering ? 'Crie sua nova conta' : 'Acesse seu dashboard'}
        </p>

        {error && <div className="bg-red-500/10 text-red-500 p-3 rounded mb-4 text-sm border border-red-500/20">{error}</div>}
        {success && <div className="bg-green-500/10 text-green-500 p-3 rounded mb-4 text-sm border border-green-500/20">{success}</div>}
        
        <form onSubmit={handleSubmit} className="space-y-4">
          <div>
            <label className="text-slate-400 text-sm font-medium">Email</label>
            <input 
              type="email" 
              required
              value={email}
              onChange={e => setEmail(e.target.value)}
              className="w-full bg-slate-900 border border-slate-700 rounded p-2.5 text-white mt-1 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all"
              placeholder="exemplo@email.com"
            />
          </div>
          <div>
            <label className="text-slate-400 text-sm font-medium">Senha</label>
            <input 
              type="password" 
              required
              minLength={3}
              value={password}
              onChange={e => setPassword(e.target.value)}
              className="w-full bg-slate-900 border border-slate-700 rounded p-2.5 text-white mt-1 focus:outline-none focus:border-blue-500 focus:ring-1 focus:ring-blue-500 transition-all"
              placeholder="••••••"
            />
          </div>
          
          <button 
            type="submit" 
            className="w-full bg-blue-600 hover:bg-blue-500 text-white font-bold py-2.5 rounded-lg transition-colors shadow-lg shadow-blue-500/20"
          >
            {isRegistering ? 'Cadastrar' : 'Entrar'}
          </button>
        </form>

        <div className="mt-6 text-center border-t border-slate-700 pt-4">
            <button 
                onClick={() => {
                    setIsRegistering(!isRegistering);
                    setError('');
                    setSuccess('');
                }}
                className="text-slate-400 text-sm hover:text-white transition-colors underline decoration-slate-600 hover:decoration-white"
            >
                {isRegistering ? 'Já tem uma conta? Faça Login' : 'Não tem conta? Crie uma agora'}
            </button>
        </div>
      </div>
    </div>
  );
};

export default Login;