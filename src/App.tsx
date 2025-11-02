import { useState } from 'react';
import { LoginScreen } from './components/pages/LoginScreen';
import { Dashboard } from './components/pages/Dashboard';
import { TodoScreen } from './components/pages/TodoScreen';
import { ProfileScreen } from './components/pages/ProfileScreen';
import { BottomNav } from './components/BottomNav';

type Screen = 'login' | 'home' | 'todo' | 'profile';

export default function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('login');
  const [activeTab, setActiveTab] = useState<'home' | 'todo' | 'profile'>('home');
  const [username, setUsername] = useState('');
  const [isTransitioning, setIsTransitioning] = useState(false);

  const handleLoginSuccess = (user: string) => {
    setUsername(user);
    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentScreen('home');
      setActiveTab('home');
      setIsTransitioning(false);
    }, 300);
  };

  const handleLogout = () => {
    setIsTransitioning(true);
    setTimeout(() => {
      setCurrentScreen('login');
      setUsername('');
      setIsTransitioning(false);
    }, 300);
  };

  const handleTabChange = (tab: 'home' | 'todo' | 'profile') => {
    setActiveTab(tab);
    setCurrentScreen(tab);
  };

  // Login Screen (full screen)
  if (currentScreen === 'login') {
    return (
      <div className={`min-h-screen bg-background transition-opacity duration-300 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}>
        <LoginScreen onLoginSuccess={handleLoginSuccess} />
      </div>
    );
  }

  // Main App with iPhone Frame
  return (
    <div className={`min-h-screen bg-background flex items-center justify-center p-4 transition-opacity duration-300 ${isTransitioning ? 'opacity-0' : 'opacity-100'}`}>
      {/* iPhone Frame */}
      <div className="w-[390px] h-[844px] bg-background rounded-[60px] shadow-2xl overflow-hidden relative border-8 border-[#1A2332]">
        {/* Content Container */}
        <div className="h-full flex flex-col">
          {/* Screen Content */}
          {currentScreen === 'home' && (
            <Dashboard 
              onLogout={handleLogout} 
              username={username}
              onNavigateToTodo={() => handleTabChange('todo')}
            />
          )}
          
          {currentScreen === 'todo' && (
            <TodoScreen />
          )}
          
          {currentScreen === 'profile' && (
            <ProfileScreen username={username} onLogout={handleLogout} />
          )}
        </div>

        {/* Bottom Navigation */}
        <BottomNav activeTab={activeTab} onTabChange={handleTabChange} />
      </div>

      <style>{`
        .scrollbar-hide::-webkit-scrollbar {
          display: none;
        }
        .scrollbar-hide {
          -ms-overflow-style: none;
          scrollbar-width: none;
        }
      `}</style>
    </div>
  );
}
