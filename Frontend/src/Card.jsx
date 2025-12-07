import React from 'react';

const Card = ({ children, className = '' }) => {
  return (
    <div className={`bg-slate-900 rounded-xl p-6 shadow-lg border border-slate-800/50 ${className}`}>
      {children}
    </div>
  );
};

export default Card;