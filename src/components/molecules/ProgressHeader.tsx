import { ProgressBar } from '../atoms/ProgressBar';

interface ProgressHeaderProps {
  level: number;
  xp: number;
  maxXp: number;
}

export function ProgressHeader({ level, xp, maxXp }: ProgressHeaderProps) {
  const progress = (xp / maxXp) * 100;

  return (
    <div className="bg-card border border-border rounded-2xl p-4 shadow-md">
      {/* Header */}
      <div className="flex items-center justify-between mb-3">
        <span className="text-sm text-tertiary-foreground">NEXT LEVEL</span>
        <div className="px-3 py-1 bg-primary/20 border border-primary/30 rounded-lg">
          <span className="text-sm text-primary">LEVEL {level}</span>
        </div>
      </div>

      {/* Progress Bar */}
      <ProgressBar progress={progress} height={8} />

      {/* XP Info */}
      <div className="flex items-center justify-between mt-2">
        <span className="text-xs text-tertiary-foreground">{xp} XP</span>
        <span className="text-xs text-tertiary-foreground">{maxXp} XP</span>
      </div>
    </div>
  );
}
