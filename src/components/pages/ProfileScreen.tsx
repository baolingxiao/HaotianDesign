import { User, Mail, Calendar, Award, Settings, LogOut } from 'lucide-react';
import { defaultUser } from '../UserData';

interface ProfileScreenProps {
  username: string;
  onLogout: () => void;
}

const getStatsData = () => [
  { label: 'Level', value: defaultUser.level.toString(), icon: Award },
  { label: 'XP', value: defaultUser.xp.toString(), icon: Award },
  { label: 'Tasks Done', value: `${defaultUser.tasksCompleted}/${defaultUser.totalTasks}`, icon: Award },
];

const getAccountInfo = (username: string) => [
  { label: '用户名', value: username, icon: User },
  { label: '邮箱', value: defaultUser.email, icon: Mail },
  { label: '加入日期', value: defaultUser.joinDate, icon: Calendar },
];

export function ProfileScreen({ username, onLogout }: ProfileScreenProps) {
  const statsData = getStatsData();
  const accountInfo = getAccountInfo(username);

  return (
    <div className="h-full flex flex-col pt-12 pb-24 px-6 overflow-y-auto scrollbar-hide">
      {/* Header */}
      <div className="flex-shrink-0 mb-6">
        <h1 className="mb-1">我的档案</h1>
        <p className="text-muted-foreground">管理你的个人信息</p>
      </div>

      {/* Profile Card */}
      <div className="bg-card border border-border rounded-2xl p-6 shadow-md mb-4">
        {/* Avatar */}
        <div className="flex flex-col items-center mb-6">
          <div className="w-24 h-24 rounded-full bg-primary/20 border-2 border-primary flex items-center justify-center mb-3">
            <User className="w-12 h-12 text-primary" />
          </div>
          <h2 className="text-foreground mb-1">{username}</h2>
          <span className="text-sm text-muted-foreground">{defaultUser.membershipLevel}</span>
        </div>

        {/* Stats Grid */}
        <div className="grid grid-cols-3 gap-3 mb-6">
          {statsData.map((stat) => {
            const Icon = stat.icon;
            return (
              <div key={stat.label} className="bg-background border border-border rounded-xl p-3 text-center">
                <Icon className="w-5 h-5 text-primary mx-auto mb-2" />
                <div className="text-foreground mb-1">{stat.value}</div>
                <div className="text-xs text-tertiary-foreground">{stat.label}</div>
              </div>
            );
          })}
        </div>

        {/* Account Info */}
        <div className="space-y-3">
          {accountInfo.map((info, index) => {
            const Icon = info.icon;
            return (
              <div key={info.label}>
                <div className="flex items-center gap-3">
                  <Icon className="w-5 h-5 text-tertiary-foreground" />
                  <div className="flex-1">
                    <div className="text-xs text-tertiary-foreground mb-0.5">{info.label}</div>
                    <div className="text-sm text-foreground">{info.value}</div>
                  </div>
                </div>
                {index < accountInfo.length - 1 && (
                  <div className="h-px bg-divider/20 mt-3" />
                )}
              </div>
            );
          })}
        </div>
      </div>

      {/* Action Buttons */}
      <div className="space-y-3">
        <button className="w-full bg-card border border-border rounded-2xl p-4 shadow-md flex items-center gap-3 hover:bg-accent transition-colors">
          <Settings className="w-5 h-5 text-tertiary-foreground" />
          <span className="text-foreground">设置</span>
        </button>

        <button 
          onClick={onLogout}
          className="w-full bg-card border border-border rounded-2xl p-4 shadow-md flex items-center gap-3 hover:bg-destructive/10 transition-colors"
        >
          <LogOut className="w-5 h-5 text-destructive" />
          <span className="text-destructive">退出登录</span>
        </button>
      </div>
    </div>
  );
}
