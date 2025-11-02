import { CheckCircle2, Clock, Loader2, ArrowRight } from 'lucide-react';

interface TaskCardProps {
  time: string;
  title: string;
  description: string;
  status: 'completed' | 'in-progress' | 'pending';
  buttonText: string;
  isPrimary?: boolean;
}

const statusConfig = {
  completed: {
    icon: CheckCircle2,
    color: 'text-success',
  },
  'in-progress': {
    icon: Loader2,
    color: 'text-primary',
  },
  pending: {
    icon: Clock,
    color: 'text-divider',
  },
};

export function TaskCard({ time, title, description, status, buttonText, isPrimary = false }: TaskCardProps) {
  const StatusIcon = statusConfig[status].icon;
  const statusColor = statusConfig[status].color;

  return (
    <div
      className={`rounded-2xl p-5 shadow-md border ${
        isPrimary
          ? 'bg-primary text-primary-foreground border-primary'
          : 'bg-card text-card-foreground border-border'
      }`}
    >
      {/* Time Badge */}
      <div className="flex justify-end mb-3">
        <span className={`text-sm ${isPrimary ? 'text-primary-foreground/70' : 'text-tertiary-foreground'}`}>
          {time}
        </span>
      </div>

      {/* Title */}
      <h3 className={`mb-2 ${isPrimary ? 'text-primary-foreground' : 'text-foreground'}`}>
        {title}
      </h3>

      {/* Description */}
      <p className={`text-sm mb-4 ${isPrimary ? 'text-primary-foreground/80' : 'text-muted-foreground'}`}>
        {description}
      </p>

      {/* Footer */}
      <div className="flex items-center justify-between">
        <StatusIcon className={`w-5 h-5 ${isPrimary ? 'text-primary-foreground/90' : statusColor}`} />
        
        <button
          className={`flex items-center gap-2 px-4 py-2 rounded-xl transition-all ${
            isPrimary
              ? 'bg-primary-foreground/20 text-primary-foreground hover:bg-primary-foreground/30'
              : 'border border-border bg-background/50 text-foreground hover:bg-accent'
          }`}
        >
          <span className="text-sm">{buttonText}</span>
          <ArrowRight className="w-4 h-4" />
        </button>
      </div>
    </div>
  );
}
