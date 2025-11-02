/**
 * ProgressCardLeft - 左侧进度卡片（整合版）
 * 包含环形进度条 + 今日任务标题列表
 * 
 * Data keys:
 * - daily_progress_pct: number (0-100) - 今日进度百分比
 * - done_count: number - 已完成任务数
 * - total_count: number - 总任务数
 * - tasks_today: Array<{id, title, status}> - 今日任务列表
 * 
 * Props:
 * - showList: boolean - 是否显示任务列表
 * - maxVisible: number - 最多显示任务数
 * 
 * States: default, loading, empty, withTasks
 */

import { ChevronRight } from 'lucide-react';
import { ProgressRing } from '../atoms/ProgressRing';
import { TaskTitleItem } from '../atoms/TaskTitleItem';
import { Skeleton } from '../ui/skeleton';

interface Task {
  id: string;
  title: string;
  status: 'pending' | 'in_progress' | 'done';
}

interface ProgressCardLeftProps {
  dailyProgressPct: number;
  doneCount: number;
  totalCount: number;
  tasksToday?: Task[];
  showList?: boolean;
  maxVisible?: number;
  isLoading?: boolean;
  onTaskClick?: (taskId: string) => void;
  onViewAll?: () => void;
  onCreateTask?: () => void;
}

export function ProgressCardLeft({
  dailyProgressPct,
  doneCount,
  totalCount,
  tasksToday = [],
  showList = true,
  maxVisible = 4,
  isLoading = false,
  onTaskClick,
  onViewAll,
  onCreateTask,
}: ProgressCardLeftProps) {
  const visibleTasks = tasksToday.slice(0, maxVisible);
  const isEmpty = tasksToday.length === 0;

  // Loading 状态
  if (isLoading) {
    return (
      <div className="bg-white/5 backdrop-blur-sm rounded-2xl p-4 shadow-lg border border-white/10 h-full">
        <Skeleton className="h-4 w-32 mb-3" />
        <div className="flex justify-center mb-3">
          <div className="w-[100px] h-[100px] rounded-full bg-progress-track animate-pulse" />
        </div>
        <Skeleton className="h-3 w-24 mx-auto mb-4" />
        {showList && (
          <div className="space-y-2">
            <Skeleton className="h-10 w-full rounded-xl" />
            <Skeleton className="h-10 w-full rounded-xl" />
            <Skeleton className="h-10 w-full rounded-xl" />
          </div>
        )}
      </div>
    );
  }

  return (
    <div className="bg-white/5 backdrop-blur-sm rounded-2xl p-4 shadow-lg border border-white/10 h-full flex flex-col">
      {/* 顶部标题 */}
      <h3 className="text-foreground text-sm mb-3">今日目标完成度</h3>

      {/* 中部环形进度 */}
      <div className="flex justify-center mb-2">
        <ProgressRing percentage={dailyProgressPct} size={100} strokeWidth={10} />
      </div>

      {/* 进度说明 */}
      <p className="text-xs text-center text-muted-foreground mb-4">
        {doneCount}/{totalCount} 已完成
      </p>

      {/* 任务列表 */}
      {showList && (
        <div className="flex-1 flex flex-col min-h-0">
          {isEmpty ? (
            // Empty 状态
            <div className="flex-1 flex flex-col items-center justify-center py-4">
              <p className="text-xs text-muted-foreground mb-3 text-center">今天没有任务</p>
              <button
                onClick={onCreateTask}
                className="text-xs text-primary hover:text-primary/80 transition-colors flex items-center gap-1"
              >
                去创建
                <ChevronRight className="w-3 h-3" />
              </button>
            </div>
          ) : (
            <>
              {/* 任务标题列表 */}
              <div className="flex-1 overflow-y-auto scrollbar-hide space-y-2 mb-3">
                {visibleTasks.map((task) => (
                  <TaskTitleItem
                    key={task.id}
                    id={task.id}
                    title={task.title}
                    status={task.status}
                    onClick={onTaskClick}
                  />
                ))}
              </div>

              {/* 底部查看全部按钮 */}
              <button
                onClick={onViewAll}
                className="w-full py-2 bg-secondary/50 text-foreground rounded-lg text-xs hover:bg-secondary/70 transition-colors flex items-center justify-center gap-1 mt-auto"
              >
                查看全部 To-do
                <ChevronRight className="w-3 h-3" />
              </button>
            </>
          )}
        </div>
      )}
    </div>
  );
}
