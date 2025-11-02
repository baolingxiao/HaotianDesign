/**
 * ProgressRing - 环形进度条组件
 * 
 * Data keys:
 * - percentage: number (0-100) - 进度百分比
 * - size: number - 圆环直径
 * - strokeWidth: number - 圆环宽度
 * 
 * States: default, loading
 */

interface ProgressRingProps {
  percentage: number; // 0-100
  size?: number;
  strokeWidth?: number;
  className?: string;
}

export function ProgressRing({
  percentage,
  size = 120,
  strokeWidth = 12,
  className = '',
}: ProgressRingProps) {
  const radius = (size - strokeWidth) / 2;
  const circumference = radius * 2 * Math.PI;
  const offset = circumference - (percentage / 100) * circumference;

  return (
    <div className={`relative inline-flex items-center justify-center ${className}`}>
      <svg width={size} height={size} className="transform -rotate-90">
        {/* 背景圆环 */}
        <circle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="var(--color-progress-track)"
          strokeWidth={strokeWidth}
          fill="none"
        />
        {/* 进度圆环 */}
        <circle
          cx={size / 2}
          cy={size / 2}
          r={radius}
          stroke="var(--color-primary)"
          strokeWidth={strokeWidth}
          fill="none"
          strokeDasharray={circumference}
          strokeDashoffset={offset}
          strokeLinecap="round"
          className="transition-all duration-500 ease-out"
        />
      </svg>
      {/* 中间文字 */}
      <div className="absolute inset-0 flex items-center justify-center">
        <span className="text-3xl text-foreground" style={{ fontWeight: 600 }}>
          {Math.round(percentage)}%
        </span>
      </div>
    </div>
  );
}
