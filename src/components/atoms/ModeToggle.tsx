interface ModeToggleProps {
  options: string[];
  selected: string;
  onSelect: (option: string) => void;
}

export function ModeToggle({ options, selected, onSelect }: ModeToggleProps) {
  return (
    <div className="flex gap-2 w-full">
      {options.map((option) => {
        const isSelected = selected === option;
        return (
          <button
            key={option}
            onClick={() => onSelect(option)}
            className={`flex-1 h-10 rounded-lg transition-all ${
              isSelected
                ? 'bg-primary text-primary-foreground'
                : 'bg-transparent border border-border text-muted-foreground'
            }`}
          >
            {option}
          </button>
        );
      })}
    </div>
  );
}
