import { ReactNode } from 'react';

interface IconButtonProps {
  children: ReactNode;
  onClick?: () => void;
  className?: string;
}

export function IconButton({ children, onClick, className = '' }: IconButtonProps) {
  return (
    <button
      onClick={onClick}
      className={`w-12 h-12 rounded-full bg-card border border-border flex items-center justify-center shadow-sm hover:shadow-md transition-shadow ${className}`}
    >
      {children}
    </button>
  );
}
