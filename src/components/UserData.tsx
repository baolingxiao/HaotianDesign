export interface UserProfile {
  username: string;
  email: string;
  joinDate: string;
  level: number;
  xp: number;
  maxXp: number;
  tasksCompleted: number;
  totalTasks: number;
  membershipLevel: string;
}

export const defaultUser: UserProfile = {
  username: 'john_doe',
  email: 'john@example.com',
  joinDate: '2024年1月',
  level: 4,
  xp: 2450,
  maxXp: 3000,
  tasksCompleted: 8,
  totalTasks: 12,
  membershipLevel: '高级会员',
};
