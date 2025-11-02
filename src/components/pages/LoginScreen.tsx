import { useState } from 'react';
import { User, Lock } from 'lucide-react';
import { InputField } from '../atoms/InputField';
import { PrimaryButton } from '../atoms/PrimaryButton';
import { ModeToggle } from '../atoms/ModeToggle';

interface LoginScreenProps {
  onLoginSuccess: (username: string, password: string) => void;
}

export function LoginScreen({ onLoginSuccess }: LoginScreenProps) {
  const [mode, setMode] = useState('登录');
  const [username, setUsername] = useState('');
  const [password, setPassword] = useState('');
  const [isLoading, setIsLoading] = useState(false);
  const [error, setError] = useState('');

  const handleSubmit = () => {
    if (!username || !password) {
      setError('请输入用户名和密码');
      return;
    }

    if (username.length < 3) {
      setError('用户名至少需要3个字符');
      return;
    }

    if (password.length < 6) {
      setError('密码至少需要6个字符');
      return;
    }

    setError('');
    setIsLoading(true);

    // Simulate login
    setTimeout(() => {
      setIsLoading(false);
      onLoginSuccess(username, password);
    }, 1500);
  };

  return (
    <div className="min-h-screen bg-background flex items-center justify-center p-6">
      <div className="w-full max-w-[400px]">
        {/* Card Container */}
        <div className="bg-card border border-border rounded-2xl p-6 shadow-[0_8px_24px_rgba(0,0,0,0.2)]">
          {/* Title */}
          <h1 className="text-primary mb-2">WELCOME BACK</h1>
          
          {/* Subtitle */}
          <p className="text-muted-foreground mb-6">连接到你的专属档案</p>

          {/* Mode Toggle */}
          <div className="mb-6">
            <ModeToggle
              options={['登录', '注册']}
              selected={mode}
              onSelect={setMode}
            />
          </div>

          {/* Username Input */}
          <div className="mb-4">
            <InputField
              icon={<User className="w-5 h-5" />}
              type="text"
              placeholder="用户名"
              value={username}
              onChange={setUsername}
            />
          </div>

          {/* Password Input */}
          <div className="mb-2">
            <InputField
              icon={<Lock className="w-5 h-5" />}
              type="password"
              placeholder="密码"
              value={password}
              onChange={setPassword}
            />
          </div>

          {/* Error Message */}
          {error && (
            <p className="text-destructive text-sm mb-4">{error}</p>
          )}

          {/* Submit Button */}
          <div className="mt-6">
            <PrimaryButton
              text={mode === '登录' ? '登录' : '注册'}
              onClick={handleSubmit}
              isLoading={isLoading}
              loadingText="连接到你的专属档案中…"
            />
          </div>
        </div>
      </div>
    </div>
  );
}
