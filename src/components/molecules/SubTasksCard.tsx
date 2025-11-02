import { Circle, CheckCircle2 } from 'lucide-react';

interface SubTask {
  id: number;
  title: string;
  completed: boolean;
}

interface SubTasksCardProps {
  tasks: SubTask[];
}

export function SubTasksCard({ tasks }: SubTasksCardProps) {
  return (
    <div className="bg-card border border-border rounded-2xl p-4 shadow-md">
      {/* Title */}
      <div className="mb-3">
        <span className="text-xs text-tertiary-foreground">SUB TASKS</span>
      </div>

      {/* Task List */}
      <div className="space-y-3">
        {tasks.map((task, index) => (
          <div key={task.id}>
            <div className="flex items-center gap-3">
              {task.completed ? (
                <CheckCircle2 className="w-4 h-4 text-success flex-shrink-0" />
              ) : (
                <Circle className="w-4 h-4 text-divider flex-shrink-0" />
              )}
              <span className={`text-sm ${task.completed ? 'text-muted-foreground line-through' : 'text-foreground'}`}>
                {task.title}
              </span>
            </div>
            {index < tasks.length - 1 && (
              <div className="h-px bg-divider/20 my-3" />
            )}
          </div>
        ))}
      </div>
    </div>
  );
}
