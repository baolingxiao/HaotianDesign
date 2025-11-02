/**
 * VASection - Virtual Assistant 虚拟助手区域
 * 
 * Data keys:
 * - va_status: 'online' | 'offline' - 虚拟助手状态
 * - placeholder_img: string - 占位图URL (可选)
 * - placeholder_url: string - WebView URL (预留)
 * 
 * States: online, offline, loading
 */

import { MoreVertical } from 'lucide-react';

interface VASectionProps {
  vaStatus?: 'online' | 'offline';
  placeholderImg?: string;
  onSettingsClick?: () => void;
  onInteract?: () => void;
}

export function VASection({
  vaStatus = 'online',
  placeholderImg,
  onSettingsClick,
  onInteract,
}: VASectionProps) {
  return (
    <div className="bg-card rounded-2xl p-4 shadow-lg border border-border">
      {/* 标题栏 */}
      <div className="flex items-center justify-between mb-4">
        <div className="flex items-center gap-2">
          <h3 className="text-foreground text-sm">Virtual Assistant</h3>
          <div className="flex items-center gap-1">
            <div
              className={`w-1.5 h-1.5 rounded-full ${
                vaStatus === 'online' ? 'bg-success animate-pulse' : 'bg-muted-foreground'
              }`}
            />
            <span
              className={`text-[10px] ${
                vaStatus === 'online' ? 'text-success' : 'text-muted-foreground'
              }`}
            >
              {vaStatus === 'online' ? 'Online' : 'Offline'}
            </span>
          </div>
        </div>
        <button
          onClick={onSettingsClick}
          className="text-muted-foreground hover:text-foreground transition-colors"
        >
          <MoreVertical className="w-4 h-4" />
        </button>
      </div>

      {/* Live2D 占位区域 */}
      <button
        onClick={onInteract}
        className="w-full bg-secondary/30 rounded-2xl p-8 mb-3 border border-border hover:border-primary/50 transition-all cursor-pointer group"
      >
        <div className="flex flex-col items-center justify-center text-center">
          {/* 占位图标 */}
          <div className="w-16 h-16 rounded-full bg-primary/10 flex items-center justify-center mb-3 group-hover:scale-110 transition-transform">
            <svg
              className="w-8 h-8 text-primary"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
            >
              <path
                strokeLinecap="round"
                strokeLinejoin="round"
                strokeWidth={2}
                d="M14.828 14.828a4 4 0 01-5.656 0M9 10h.01M15 10h.01M21 12a9 9 0 11-18 0 9 9 0 0118 0z"
              />
            </svg>
          </div>
          
          <p className="text-muted-foreground text-sm mb-1">Live2D avatar will render here</p>
          <p className="text-tertiary-foreground text-xs">WebView integration coming soon</p>
        </div>
      </button>

      {/* 说明文字 */}
      <p className="text-center text-tertiary-foreground text-[11px]">
        Click to interact • Hover for expressions
      </p>
    </div>
  );
}
