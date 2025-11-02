import { CheckCircle2 } from 'lucide-react';
import { ProgressBar } from '../atoms/ProgressBar';

interface AchievementsCardProps {
  completed: number;
  total: number;
}

export function AchievementsCard({ completed, total }: AchievementsCardProps) {
  const progress = (completed / total) * 100;

  return (
    <div className="bg-card border border-border rounded-2xl p-4 shadow-md h-full flex flex-col">
      {/* Title */}
      <div className="mb-3">
        <span className="text-xs text-tertiary-foreground">ACHIEVEMENTS</span>
      </div>

      {/* Icons */}
      <div className="flex gap-2 mb-4">
        {[...Array(3)].map((_, i) => (
          <CheckCircle2 key={i} className="w-5 h-5 text-success" />
        ))}
      </div>

      {/* Stats */}
      <div className="flex-1 flex flex-col justify-center">
        <span className="text-xs text-tertiary-foreground mb-1">TASKS COMPLETED</span>
        <span className="text-foreground mb-3">
          {completed} / {total}
        </span>
      </div>

      {/* Progress Bar */}
      <ProgressBar progress={progress} height={6} />
    </div>
  );
}
