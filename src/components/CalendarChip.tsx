interface CalendarChipProps {
  day: string;
  date: number;
  isSelected: boolean;
  onClick: () => void;
  disabled?: boolean;
}

export function CalendarChip({ day, date, isSelected, onClick, disabled = false }: CalendarChipProps) {
  return (
    <button
      onClick={onClick}
      disabled={disabled}
      className={`flex flex-col items-center justify-center px-3 py-2 rounded-2xl transition-all duration-300 min-w-[60px] border ${
        disabled
          ? 'bg-card/50 text-muted-foreground/50 border-border/50 cursor-not-allowed opacity-50'
          : isSelected
          ? 'bg-primary text-primary-foreground shadow-lg border-primary scale-105'
          : 'bg-card text-foreground shadow-sm hover:shadow-md hover:scale-102 border-border hover:border-primary/30'
      }`}
    >
      <span className={`text-sm ${disabled ? 'opacity-50' : isSelected ? 'opacity-90' : 'text-tertiary-foreground'}`}>
        {day}
      </span>
      <span className="text-lg mt-0.5">{date}</span>
    </button>
  );
}
