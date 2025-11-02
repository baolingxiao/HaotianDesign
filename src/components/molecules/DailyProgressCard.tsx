/**
 * DailyProgressCard - 今日目标完成度卡片
 * 
 * Data keys:
 * - daily_progress_pct: number (0-100) - 今日进度百分比
 * - done_count: number - 已完成任务数
 * - total_count: number - 总任务数
 * 
 * States: default, loading, empty
 */

import { ProgressRing } from '../atoms/ProgressRing';
import { ChevronRight } from 'lucide-react';

interface DailyProgressCardProps {
  dailyProgressPct: number;
  doneCount: number;
  totalCount: number;
  onViewProgress?: () => void;
}

export function DailyProgressCard({
  dailyProgressPct,
  doneCount,
  totalCount,
  onViewProgress,
}: DailyProgressCardProps) {
  return (
    <div className="bg-white/5 backdrop-blur-sm rounded-2xl p-4 shadow-lg border border-white/10">
      <div className="flex items-start justify-between mb-3">
        <div>
          <h3 className="text-foreground text-sm mb-1">今日目标完成度</h3>
          <p className="text-xs text-muted-foreground">
            {doneCount}/{totalCount} 完成！
          </p>
        </div>
        <button
          onClick={onViewProgress}
          className="flex items-center gap-1 text-xs text-primary hover:text-primary/80 transition-colors"
        >
          查看进度
          <ChevronRight className="w-3 h-3" />
        </button>
      </div>
      
      <div className="flex justify-center">
        <ProgressRing percentage={dailyProgressPct} size={100} strokeWidth={10} />
      </div>
    </div>
  );
}
