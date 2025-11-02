interface ProgressBarProps {
  progress: number; // 0-100
  height?: number;
}

export function ProgressBar({ progress, height = 8 }: ProgressBarProps) {
  return (
    <div className="w-full bg-progress-track rounded-full overflow-hidden" style={{ height }}>
      <div
        className="h-full bg-primary rounded-full transition-all duration-300"
        style={{ width: `${Math.min(Math.max(progress, 0), 100)}%` }}
      />
    </div>
  );
}
