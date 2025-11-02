/**
 * TaskTitleItem - 简化的任务标题行组件
 * 仅显示状态图标、标题和箭头，用于嵌入进度卡片
 * 
 * Data keys:
 * - id: string - 任务ID
 * - title: string - 任务标题
 * - status: 'pending' | 'in_progress' | 'done' - 任务状态
 * 
 * States: pending, in_progress, done
 */

import { CheckCircle, Circle, Clock, ChevronRight } from 'lucide-react';

interface TaskTitleItemProps {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'done';
  onClick?: (id: string) => void;
}

export function TaskTitleItem({ id, title, status, onClick }: TaskTitleItemProps) {
  const getStatusIcon = () => {
    switch (status) {
      case 'done':
        return <CheckCircle className="w-4 h-4 text-success flex-shrink-0" />;
      case 'in_progress':
        return <Clock className="w-4 h-4 text-primary flex-shrink-0" />;
      case 'pending':
        return <Circle className="w-4 h-4 text-muted-foreground flex-shrink-0" />;
    }
  };

  return (
    <button
      onClick={() => onClick?.(id)}
      className="w-full flex items-center gap-3 px-3 py-2.5 rounded-xl bg-background/30 hover:bg-background/50 transition-all duration-200 group min-h-[44px]"
    >
      {/* 状态图标 */}
      {getStatusIcon()}

      {/* 任务标题 */}
      <span
        className={`flex-1 text-left text-sm line-clamp-1 ${
          status === 'done' ? 'text-muted-foreground line-through' : 'text-foreground'
        }`}
      >
        {title}
      </span>

      {/* 箭头 */}
      <ChevronRight className="w-4 h-4 text-tertiary-foreground group-hover:text-foreground transition-colors flex-shrink-0" />
    </button>
  );
}
