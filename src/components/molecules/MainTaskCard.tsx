import { ProgressBar } from '../atoms/ProgressBar';

interface MainTaskCardProps {
  title: string;
  progress: number;
  status: string;
  deadline: string;
}

export function MainTaskCard({ title, progress, status, deadline }: MainTaskCardProps) {
  return (
    <div className="bg-card border border-border rounded-2xl p-4 shadow-md h-full">
      {/* Title */}
      <div className="mb-3">
        <span className="text-xs text-tertiary-foreground">MAIN TASK</span>
      </div>

      {/* Task Title */}
      <h3 className="text-foreground mb-4">{title}</h3>

      {/* Progress Bar */}
      <ProgressBar progress={progress} height={8} />

      {/* Status Info */}
      <div className="flex items-center justify-between mt-3">
        <span className="text-xs text-muted-foreground">{status}</span>
        <span className="text-xs text-muted-foreground">{deadline}</span>
      </div>
    </div>
  );
}
