/**
 * FinanceCard - 今日财报卡片
 * 
 * Data keys:
 * - price: number - 当前价格
 * - change_pct: number (±) - 涨跌百分比
 * - volume: number - 成交量
 * - last_update: string (datetime) - 最后更新时间
 * - series_intraday: Array<{t: string, v: number}> - 日内折线数据
 * 
 * States: default, loading, error
 */

import { useState } from 'react';
import { RefreshCw, ChevronRight, TrendingUp, TrendingDown } from 'lucide-react';
import { LineChart, Line, XAxis, YAxis, ResponsiveContainer, Tooltip } from 'recharts';
import { Skeleton } from '../ui/skeleton';

interface FinanceData {
  price: number;
  changePct: number;
  volume: number;
  lastUpdate: string;
  seriesIntraday: Array<{ t: string; v: number }>;
}

interface FinanceCardProps {
  data?: FinanceData;
  isLoading?: boolean;
  error?: string;
  onRefresh?: () => void;
  onViewDetails?: () => void;
}

export function FinanceCard({
  data,
  isLoading = false,
  error,
  onRefresh,
  onViewDetails,
}: FinanceCardProps) {
  const [isRefreshing, setIsRefreshing] = useState(false);

  const handleRefresh = async () => {
    setIsRefreshing(true);
    onRefresh?.();
    // 360° 旋转动画持续时间
    setTimeout(() => setIsRefreshing(false), 600);
  };

  if (error) {
    return (
      <div className="bg-card rounded-2xl p-4 shadow-lg border border-border">
        <div className="flex flex-col items-center justify-center py-8">
          <p className="text-destructive text-sm mb-3">加载失败</p>
          <button
            onClick={handleRefresh}
            className="px-4 py-2 bg-secondary text-secondary-foreground rounded-lg text-xs hover:bg-secondary/80 transition-colors"
          >
            重试
          </button>
        </div>
      </div>
    );
  }

  if (isLoading) {
    return (
      <div className="bg-card rounded-2xl p-4 shadow-lg border border-border">
        <div className="flex items-center justify-between mb-3">
          <Skeleton className="h-4 w-16" />
          <Skeleton className="h-4 w-20" />
        </div>
        <Skeleton className="h-20 w-full mb-3" />
        <div className="grid grid-cols-2 gap-2 mb-3">
          <Skeleton className="h-8 w-full" />
          <Skeleton className="h-8 w-full" />
        </div>
        <Skeleton className="h-6 w-full" />
      </div>
    );
  }

  const isPositive = (data?.changePct ?? 0) >= 0;

  return (
    <div className="bg-gradient-to-br from-card to-secondary rounded-2xl p-4 shadow-lg border border-border transition-opacity duration-200">
      {/* 顶部 */}
      <div className="flex items-center justify-between mb-3">
        <h3 className="text-foreground text-sm">今日财报</h3>
        <div className="flex items-center gap-2">
          <span className="px-2 py-0.5 bg-primary/20 text-primary text-[10px] rounded-full">
            Real-time
          </span>
          <button
            onClick={handleRefresh}
            className="text-muted-foreground hover:text-foreground transition-colors"
          >
            <RefreshCw 
              className={`w-3.5 h-3.5 transition-transform duration-[600ms] ${
                isRefreshing ? 'rotate-[360deg]' : 'rotate-0'
              }`}
            />
          </button>
        </div>
      </div>

      {/* 图表 */}
      {data && (
        <div className="mb-3">
          <ResponsiveContainer width="100%" height={80}>
            <LineChart data={data.seriesIntraday}>
              <XAxis dataKey="t" hide />
              <YAxis hide domain={['dataMin', 'dataMax']} />
              <Tooltip
                contentStyle={{
                  backgroundColor: 'var(--color-card)',
                  border: '1px solid var(--color-border)',
                  borderRadius: '8px',
                  fontSize: '12px',
                }}
              />
              <Line
                type="monotone"
                dataKey="v"
                stroke={isPositive ? 'var(--color-success)' : 'var(--color-destructive)'}
                strokeWidth={2}
                dot={false}
              />
            </LineChart>
          </ResponsiveContainer>
        </div>
      )}

      {/* 指标 */}
      {data && (
        <div className="grid grid-cols-2 gap-2 mb-3">
          <div className="bg-background/30 rounded-lg p-2">
            <p className="text-[10px] text-muted-foreground mb-0.5">价格</p>
            <p className="text-sm text-foreground">${data.price.toFixed(2)}</p>
          </div>
          <div className="bg-background/30 rounded-lg p-2">
            <p className="text-[10px] text-muted-foreground mb-0.5">涨跌幅</p>
            <p
              className={`text-sm flex items-center gap-1 ${
                isPositive ? 'text-success' : 'text-destructive'
              }`}
            >
              {isPositive ? <TrendingUp className="w-3 h-3" /> : <TrendingDown className="w-3 h-3" />}
              {isPositive ? '+' : ''}
              {data.changePct.toFixed(2)}%
            </p>
          </div>
          <div className="bg-background/30 rounded-lg p-2">
            <p className="text-[10px] text-muted-foreground mb-0.5">成交量</p>
            <p className="text-sm text-foreground">{(data.volume / 1000000).toFixed(2)}M</p>
          </div>
          <div className="bg-background/30 rounded-lg p-2">
            <p className="text-[10px] text-muted-foreground mb-0.5">更新时间</p>
            <p className="text-sm text-foreground">{data.lastUpdate}</p>
          </div>
        </div>
      )}

      {/* 底部 */}
      <button
        onClick={onViewDetails}
        className="w-full py-2 bg-secondary/50 text-foreground rounded-lg text-xs hover:bg-secondary/70 transition-colors flex items-center justify-center gap-1"
      >
        查看详情
        <ChevronRight className="w-3 h-3" />
      </button>

      {/* 数据来源 */}
      <p className="text-[9px] text-tertiary-foreground text-center mt-2">
        Data source: Fidelity API
      </p>
    </div>
  );
}
