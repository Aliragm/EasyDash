import React, { useState, useEffect } from 'react';
import ReactDOM from 'react-dom/client';
import EasyDash from './EasyDash';
import Login from './Login';
import './index.css';

const App = () => {
  const [token, setToken] = useState(localStorage.getItem('token'));

  const handleLogin = (newToken, userId) => {
    localStorage.setItem('token', newToken);
    setToken(newToken);
  };

  const handleLogout = () => {
    localStorage.removeItem('token');
    setToken(null);
  };

  return (
    <React.StrictMode>
      {token ? (
        <EasyDash token={token} onLogout={handleLogout} />
      ) : (
        <Login onLogin={handleLogin} />
      )}
    </React.StrictMode>
  );
};

ReactDOM.createRoot(document.getElementById('root')).render(<App />);