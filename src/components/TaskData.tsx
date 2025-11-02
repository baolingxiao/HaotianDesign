export interface Task {
  id: string;
  time: string;
  title: string;
  description: string;
  status: 'completed' | 'in-progress' | 'pending';
  buttonText: string;
  isPrimary?: boolean;
}

export const taskData: Task[] = [
  {
    id: '1',
    time: '10.00am',
    title: 'Wireframing',
    description: 'Make sure ideation from sketch and wireframes are ready for design phase.',
    status: 'completed',
    buttonText: 'Check summary',
    isPrimary: false,
  },
  {
    id: '2',
    time: '12.00pm',
    title: 'UI Design',
    description: 'Create high-fidelity mockups based on approved wireframes and brand guidelines.',
    status: 'in-progress',
    buttonText: 'Check process',
    isPrimary: true,
  },
  {
    id: '3',
    time: '2.30pm',
    title: 'Usability Testing',
    description: 'Conduct user testing sessions to validate design decisions and gather feedback.',
    status: 'pending',
    buttonText: 'Check summary',
    isPrimary: false,
  },
  {
    id: '4',
    time: '4.00pm',
    title: 'Design Review',
    description: 'Present final designs to stakeholders and incorporate feedback.',
    status: 'pending',
    buttonText: 'Check summary',
    isPrimary: false,
  },
];

export interface DateChip {
  id: string;
  day: string;
  date: number;
  fullDate: string;
}

export const dateChips: DateChip[] = [
  { id: '1', day: 'Tue', date: 23, fullDate: 'July 23, 2024' },
  { id: '2', day: 'Wed', date: 24, fullDate: 'July 24, 2024' },
  { id: '3', day: 'Thu', date: 25, fullDate: 'July 25, 2024' },
  { id: '4', day: 'Fri', date: 26, fullDate: 'July 26, 2024' },
  { id: '5', day: 'Sat', date: 27, fullDate: 'July 27, 2024' },
  { id: '6', day: 'Sun', date: 28, fullDate: 'July 28, 2024' },
  { id: '7', day: 'Mon', date: 29, fullDate: 'July 29, 2024' },
];
