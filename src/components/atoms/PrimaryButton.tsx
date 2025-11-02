import { Loader2 } from 'lucide-react';

interface PrimaryButtonProps {
  text: string;
  onClick: () => void;
  isLoading?: boolean;
  loadingText?: string;
}

export function PrimaryButton({ text, onClick, isLoading = false, loadingText = '用户正在输入…' }: PrimaryButtonProps) {
  return (
    <button
      onClick={onClick}
      disabled={isLoading}
      className="w-full h-12 bg-primary text-primary-foreground rounded-lg flex items-center justify-center gap-2 transition-transform active:scale-[0.98] disabled:opacity-80"
    >
      {isLoading && <Loader2 className="w-5 h-5 animate-spin" />}
      <span>{isLoading ? loadingText : text}</span>
    </button>
  );
}
