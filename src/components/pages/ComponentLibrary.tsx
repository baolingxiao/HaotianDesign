/**
 * ComponentLibrary - 组件库展示页面
 * 展示Dashboard所有组件的不同状态和用法
 */

import { ProgressRing } from '../atoms/ProgressRing';
import { TaskTitleItem } from '../atoms/TaskTitleItem';
import { CalendarChip } from '../CalendarChip';
import { DailyProgressCard } from '../molecules/DailyProgressCard';
import { ProgressCardLeft } from '../molecules/ProgressCardLeft';
import { FinanceCard } from '../molecules/FinanceCard';
import { TimelineTaskCard } from '../molecules/TimelineTaskCard';
import { VASection } from '../molecules/VASection';
import { DateHeader } from '../molecules/DateHeader';
import { defaultTodayTasks } from '../DashboardData';

export function ComponentLibrary() {
  const mockFinanceData = {
    price: 68.42,
    changePct: 2.35,
    volume: 3250000,
    lastUpdate: '15:30',
    seriesIntraday: [
      { t: '09:30', v: 66.8 },
      { t: '10:00', v: 67.2 },
      { t: '11:00', v: 66.5 },
      { t: '12:00', v: 67.8 },
      { t: '13:00', v: 68.5 },
      { t: '14:00', v: 67.9 },
      { t: '15:00', v: 68.2 },
      { t: '15:30', v: 68.42 },
    ],
  };

  return (
    <div className="min-h-screen bg-background p-8 overflow-y-auto">
      <div className="max-w-6xl mx-auto">
        <h1 className="text-3xl text-foreground mb-2">Dashboard Component Library</h1>
        <p className="text-muted-foreground mb-8">
          展示所有Dashboard组件及其不同状态
        </p>

        {/* 原子组件 */}
        <section className="mb-12">
          <h2 className="text-xl text-foreground mb-4 border-b border-border pb-2">
            Atoms - 原子组件
          </h2>

          {/* ProgressRing */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">ProgressRing - 环形进度条</h3>
            <div className="bg-card rounded-2xl p-6 border border-border">
              <div className="flex gap-8 items-center justify-center">
                <div className="text-center">
                  <ProgressRing percentage={25} />
                  <p className="text-xs text-muted-foreground mt-2">25%</p>
                </div>
                <div className="text-center">
                  <ProgressRing percentage={50} />
                  <p className="text-xs text-muted-foreground mt-2">50%</p>
                </div>
                <div className="text-center">
                  <ProgressRing percentage={75} />
                  <p className="text-xs text-muted-foreground mt-2">75%</p>
                </div>
                <div className="text-center">
                  <ProgressRing percentage={100} />
                  <p className="text-xs text-muted-foreground mt-2">100%</p>
                </div>
              </div>
            </div>
          </div>

          {/* CalendarChip */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">CalendarChip - 日历芯片</h3>
            <div className="bg-card rounded-2xl p-6 border border-border">
              <div className="flex gap-3 items-center justify-center flex-wrap">
                <div className="text-center">
                  <CalendarChip day="Mon" date={1} isSelected={false} onClick={() => {}} />
                  <p className="text-xs text-muted-foreground mt-2">Default</p>
                </div>
                <div className="text-center">
                  <CalendarChip day="Tue" date={2} isSelected={true} onClick={() => {}} />
                  <p className="text-xs text-muted-foreground mt-2">Selected</p>
                </div>
                <div className="text-center">
                  <CalendarChip day="Wed" date={3} isSelected={false} onClick={() => {}} disabled={true} />
                  <p className="text-xs text-muted-foreground mt-2">Disabled</p>
                </div>
              </div>
            </div>
          </div>

          {/* TaskTitleItem */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">TaskTitleItem - 任务标题行</h3>
            <div className="bg-card rounded-2xl p-6 border border-border space-y-2">
              <TaskTitleItem id="1" title="Completed task" status="done" onClick={() => console.log('Task 1')} />
              <TaskTitleItem id="2" title="In progress task" status="in_progress" onClick={() => console.log('Task 2')} />
              <TaskTitleItem id="3" title="Pending task" status="pending" onClick={() => console.log('Task 3')} />
            </div>
          </div>
        </section>

        {/* 分子组件 */}
        <section className="mb-12">
          <h2 className="text-xl text-foreground mb-4 border-b border-border pb-2">
            Molecules - 分子组件
          </h2>

          {/* DateHeader */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">DateHeader - 日期头部</h3>
            <div className="bg-card rounded-2xl p-6 border border-border">
              <DateHeader
                weekday="Saturday"
                fullDate="November 1, 2025"
                onCalendarClick={() => console.log('Calendar')}
                onProfileClick={() => console.log('Profile')}
              />
            </div>
          </div>

          {/* ProgressCardLeft - 新整合版 */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">
              ProgressCardLeft - 左侧进度卡片（整合版）
            </h3>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <ProgressCardLeft
                  dailyProgressPct={75}
                  doneCount={12}
                  totalCount={16}
                  tasksToday={defaultTodayTasks.slice(0, 4)}
                  showList={true}
                  maxVisible={4}
                  onTaskClick={(id) => console.log('Task clicked:', id)}
                  onViewAll={() => console.log('View all')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">With Tasks</p>
              </div>
              <div>
                <ProgressCardLeft
                  dailyProgressPct={0}
                  doneCount={0}
                  totalCount={0}
                  tasksToday={[]}
                  showList={true}
                  onCreateTask={() => console.log('Create task')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Empty State</p>
              </div>
              <div>
                <ProgressCardLeft
                  dailyProgressPct={75}
                  doneCount={12}
                  totalCount={16}
                  isLoading={true}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Loading State</p>
              </div>
            </div>
          </div>

          {/* DailyProgressCard - 旧版保留 */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">
              DailyProgressCard - 今日目标完成度卡片（旧版）
            </h3>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <DailyProgressCard
                  dailyProgressPct={75}
                  doneCount={12}
                  totalCount={16}
                  onViewProgress={() => console.log('View progress')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Default State</p>
              </div>
              <div>
                <DailyProgressCard
                  dailyProgressPct={100}
                  doneCount={16}
                  totalCount={16}
                  onViewProgress={() => console.log('View progress')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">100% Complete</p>
              </div>
            </div>
          </div>

          {/* FinanceCard */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">FinanceCard - 今日财报卡片</h3>
            <div className="grid grid-cols-3 gap-4">
              <div>
                <FinanceCard
                  data={mockFinanceData}
                  onRefresh={() => console.log('Refresh')}
                  onViewDetails={() => console.log('Details')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">
                  Default State (Positive)
                </p>
              </div>
              <div>
                <FinanceCard
                  data={{
                    ...mockFinanceData,
                    changePct: -1.25,
                  }}
                  onRefresh={() => console.log('Refresh')}
                  onViewDetails={() => console.log('Details')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Negative Change</p>
              </div>
              <div>
                <FinanceCard
                  isLoading={true}
                  onRefresh={() => console.log('Refresh')}
                  onViewDetails={() => console.log('Details')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Loading State</p>
              </div>
            </div>
            <div className="mt-4">
              <FinanceCard
                error="Failed to load data"
                onRefresh={() => console.log('Refresh')}
                onViewDetails={() => console.log('Details')}
              />
              <p className="text-xs text-muted-foreground mt-2">Error State</p>
            </div>
          </div>

          {/* TimelineTaskCard */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">
              TimelineTaskCard - 任务时间线卡片
            </h3>
            <div className="bg-card rounded-2xl p-6 border border-border space-y-0">
              <TimelineTaskCard
                taskId="1"
                title="Completed Task"
                desc="This task has been completed successfully with all deliverables."
                time="10:00"
                status="done"
                buttonText="Check summary"
                onButtonClick={() => console.log('Task 1')}
              />
              <TimelineTaskCard
                taskId="2"
                title="In Progress Task (Active)"
                desc="Currently working on this task with high priority and focus."
                time="12:00"
                status="in_progress"
                isActive={true}
                buttonText="Check process"
                onButtonClick={() => console.log('Task 2')}
              />
              <TimelineTaskCard
                taskId="3"
                title="Pending Task"
                desc="This task is scheduled to start later today."
                time="14:30"
                status="pending"
                buttonText="Check summary"
                onButtonClick={() => console.log('Task 3')}
              />
            </div>
          </div>

          {/* VASection */}
          <div className="mb-8">
            <h3 className="text-lg text-foreground mb-3">VASection - Virtual Assistant</h3>
            <div className="grid grid-cols-2 gap-4">
              <div>
                <VASection
                  vaStatus="online"
                  onSettingsClick={() => console.log('Settings')}
                  onInteract={() => console.log('Interact')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Online</p>
              </div>
              <div>
                <VASection
                  vaStatus="offline"
                  onSettingsClick={() => console.log('Settings')}
                  onInteract={() => console.log('Interact')}
                />
                <p className="text-xs text-muted-foreground mt-2 text-center">Offline</p>
              </div>
            </div>
          </div>
        </section>

        {/* 数据键说明 */}
        <section className="mb-12">
          <h2 className="text-xl text-foreground mb-4 border-b border-border pb-2">
            Data Keys Reference
          </h2>
          <div className="bg-card rounded-2xl p-6 border border-border">
            <div className="space-y-4 text-sm">
              <div>
                <h4 className="text-foreground mb-2">DailyProgressCard</h4>
                <ul className="text-muted-foreground space-y-1 ml-4">
                  <li>• daily_progress_pct: number (0-100) - 进度百分比</li>
                  <li>• done_count: number - 已完成任务数</li>
                  <li>• total_count: number - 总任务数</li>
                </ul>
              </div>
              <div>
                <h4 className="text-foreground mb-2">FinanceCard</h4>
                <ul className="text-muted-foreground space-y-1 ml-4">
                  <li>• price: number - 当前价格</li>
                  <li>• change_pct: number (±) - 涨跌百分比</li>
                  <li>• volume: number - 成交量</li>
                  <li>• last_update: string - 最后更新时间</li>
                  <li>• series_intraday: {'{'}t: string, v: number{'}'} - 折线数据</li>
                </ul>
              </div>
              <div>
                <h4 className="text-foreground mb-2">TimelineTaskCard</h4>
                <ul className="text-muted-foreground space-y-1 ml-4">
                  <li>• task_id: string - 任务ID</li>
                  <li>• title: string - 任务标题</li>
                  <li>• desc: string - 任务描述</li>
                  <li>• time: string - 任务时间</li>
                  <li>• status: 'done' | 'in_progress' | 'pending' - 任务状态</li>
                </ul>
              </div>
              <div>
                <h4 className="text-foreground mb-2">VASection</h4>
                <ul className="text-muted-foreground space-y-1 ml-4">
                  <li>• va_status: 'online' | 'offline' - 虚拟助手状态</li>
                  <li>• placeholder_img: string - 占位图URL (可选)</li>
                  <li>• placeholder_url: string - WebView URL (预留)</li>
                </ul>
              </div>
            </div>
          </div>
        </section>
      </div>
    </div>
  );
}
