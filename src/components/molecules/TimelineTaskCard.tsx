/**
 * TimelineTaskCard - 任务时间线卡片
 * 
 * Data keys:
 * - task_id: string - 任务ID
 * - title: string - 任务标题
 * - desc: string - 任务描述
 * - time: string - 任务时间
 * - status: 'done' | 'in_progress' | 'pending' - 任务状态
 * 
 * States: done, in_progress, pending, active (高亮)
 */

import { CheckCircle, Clock, Circle, ChevronRight } from 'lucide-react';

interface TimelineTaskCardProps {
  taskId: string;
  title: string;
  desc: string;
  time: string;
  status: 'done' | 'in_progress' | 'pending';
  isActive?: boolean;
  buttonText?: string;
  onButtonClick?: () => void;
  isLast?: boolean;
}

export function TimelineTaskCard({
  taskId,
  title,
  desc,
  time,
  status,
  isActive = false,
  buttonText = 'Check summary',
  onButtonClick,
  isLast = false,
}: TimelineTaskCardProps) {
  const getStatusIcon = () => {
    switch (status) {
      case 'done':
        return <CheckCircle className="w-4 h-4 text-success" />;
      case 'in_progress':
        return <Clock className="w-4 h-4 text-primary" />;
      case 'pending':
        return <Circle className="w-4 h-4 text-muted-foreground" />;
    }
  };

  const getStatusText = () => {
    switch (status) {
      case 'done':
        return '已完成';
      case 'in_progress':
        return '进行中';
      case 'pending':
        return '待开始';
    }
  };

  return (
    <div className="flex gap-3">
      {/* 时间线 */}
      <div className="flex flex-col items-center pt-1">
        <div
          className={`w-2 h-2 rounded-full ${
            status === 'done'
              ? 'bg-success'
              : status === 'in_progress'
              ? 'bg-primary'
              : 'bg-muted-foreground'
          }`}
        />
        {!isLast && <div className="w-0.5 flex-1 bg-border mt-2" />}
      </div>

      {/* 卡片内容 */}
      <div className="flex-1 pb-4">
        <div
          className={`rounded-2xl p-4 border transition-all ${
            isActive
              ? 'bg-primary text-primary-foreground border-primary shadow-lg'
              : 'bg-card text-card-foreground border-border shadow-sm'
          }`}
        >
          <div className="flex items-start justify-between mb-2">
            <div className="flex-1">
              <h4 className={`text-sm mb-1 ${isActive ? 'text-primary-foreground' : 'text-foreground'}`}>
                {title}
              </h4>
              <p
                className={`text-xs line-clamp-2 ${
                  isActive ? 'text-primary-foreground/80' : 'text-muted-foreground'
                }`}
              >
                {desc}
              </p>
            </div>
            <div className="flex flex-col items-end gap-1 ml-2">
              <span
                className={`text-xs ${
                  isActive ? 'text-primary-foreground/70' : 'text-tertiary-foreground'
                }`}
              >
                {time}
              </span>
              {getStatusIcon()}
            </div>
          </div>

          <div className="flex items-center justify-between mt-3">
            <span
              className={`text-xs px-2 py-1 rounded-full ${
                isActive
                  ? 'bg-primary-foreground/20 text-primary-foreground'
                  : status === 'done'
                  ? 'bg-success/10 text-success'
                  : status === 'in_progress'
                  ? 'bg-primary/10 text-primary'
                  : 'bg-muted text-muted-foreground'
              }`}
            >
              {getStatusText()}
            </span>
            <button
              onClick={onButtonClick}
              className={`flex items-center gap-1 text-xs transition-colors ${
                isActive
                  ? 'text-primary-foreground hover:text-primary-foreground/80'
                  : 'text-primary hover:text-primary/80'
              }`}
            >
              {buttonText}
              <ChevronRight className="w-3 h-3" />
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}
