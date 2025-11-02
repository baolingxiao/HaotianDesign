import { Home, CheckSquare, User } from 'lucide-react';

interface BottomNavProps {
  activeTab: 'home' | 'todo' | 'profile';
  onTabChange: (tab: 'home' | 'todo' | 'profile') => void;
}

const navItems = [
  { id: 'home' as const, label: 'Home', icon: Home },
  { id: 'todo' as const, label: 'To-do', icon: CheckSquare },
  { id: 'profile' as const, label: 'Profile', icon: User },
];

export function BottomNav({ activeTab, onTabChange }: BottomNavProps) {
  return (
    <div className="fixed bottom-6 left-1/2 -translate-x-1/2 bg-card/95 backdrop-blur-xl border border-border rounded-3xl shadow-2xl px-3 py-2.5 flex gap-1.5">
      {navItems.map((item) => {
        const Icon = item.icon;
        const isActive = activeTab === item.id;

        return (
          <button
            key={item.id}
            onClick={() => onTabChange(item.id)}
            className={`flex items-center gap-2 px-5 py-2.5 rounded-3xl transition-all duration-300 ${
              isActive
                ? 'bg-primary text-primary-foreground shadow-md scale-105'
                : 'text-muted-foreground hover:text-foreground hover:bg-secondary/50'
            }`}
          >
            <Icon className="w-5 h-5" />
            <span className="text-sm">{item.label}</span>
          </button>
        );
      })}
    </div>
  );
}
