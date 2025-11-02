/**
 * DateHeader - 日期头部组件
 * 包含大标题星期、完整日期和右侧图标按钮
 * 
 * Data keys:
 * - weekday: string - 星期 (如 "Monday")
 * - fullDate: string - 完整日期 (如 "November 1, 2025")
 */

import { Calendar, User } from 'lucide-react';

interface DateHeaderProps {
  weekday: string;
  fullDate: string;
  onCalendarClick?: () => void;
  onProfileClick?: () => void;
}

export function DateHeader({
  weekday,
  fullDate,
  onCalendarClick,
  onProfileClick,
}: DateHeaderProps) {
  return (
    <div className="flex items-start justify-between mb-4">
      <div>
        <h1 className="text-foreground text-2xl mb-1">{weekday}</h1>
        <p className="text-sm text-muted-foreground">{fullDate}</p>
      </div>
      <div className="flex gap-2">
        <button
          onClick={onCalendarClick}
          className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center hover:bg-secondary transition-colors shadow-sm"
        >
          <Calendar className="w-5 h-5 text-foreground" />
        </button>
        <button
          onClick={onProfileClick}
          className="w-10 h-10 rounded-full bg-card border border-border flex items-center justify-center hover:bg-secondary transition-colors shadow-sm"
        >
          <User className="w-5 h-5 text-foreground" />
        </button>
      </div>
    </div>
  );
}
