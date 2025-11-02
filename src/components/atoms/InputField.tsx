import { ReactNode, useState } from 'react';

interface InputFieldProps {
  icon: ReactNode;
  type: string;
  placeholder: string;
  value: string;
  onChange: (value: string) => void;
}

export function InputField({ icon, type, placeholder, value, onChange }: InputFieldProps) {
  const [isFocused, setIsFocused] = useState(false);

  return (
    <div
      className={`flex items-center gap-3 px-4 py-3 rounded-lg bg-background border transition-all duration-150 ${
        isFocused ? 'border-2 border-primary' : 'border border-border'
      }`}
    >
      <div
        className={`flex-shrink-0 transition-colors duration-150 ${
          isFocused ? 'text-primary' : 'text-tertiary-foreground'
        }`}
      >
        {icon}
      </div>
      <input
        type={type}
        placeholder={placeholder}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        onFocus={() => setIsFocused(true)}
        onBlur={() => setIsFocused(false)}
        className="flex-1 bg-transparent text-foreground placeholder:text-tertiary-foreground outline-none"
      />
    </div>
  );
}
