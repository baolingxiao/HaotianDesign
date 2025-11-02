import { useState } from 'react';
import { Calendar, User } from 'lucide-react';
import { IconButton } from '../IconButton';
import { CalendarChip } from '../CalendarChip';
import { TaskCard } from '../TaskCard';
import { taskData, dateChips } from '../TaskData';

export function TodoScreen() {
  const [selectedDateIndex, setSelectedDateIndex] = useState(3);

  const selectedDate = dateChips[selectedDateIndex];
  const dayOfWeek = selectedDate.day === 'Fri' ? 'Friday' : 
                    selectedDate.day === 'Sat' ? 'Saturday' :
                    selectedDate.day === 'Sun' ? 'Sunday' :
                    selectedDate.day === 'Mon' ? 'Monday' :
                    selectedDate.day === 'Tue' ? 'Tuesday' :
                    selectedDate.day === 'Wed' ? 'Wednesday' : 'Thursday';

  return (
    <div className="h-full flex flex-col pt-12 pb-24 px-6">
      {/* Header Section */}
      <div className="flex-shrink-0 mb-6">
        {/* Title and Icons Row */}
        <div className="flex items-start justify-between mb-4">
          <div>
            <h1 className="mb-1">{dayOfWeek}</h1>
            <p className="text-muted-foreground">{selectedDate.fullDate}</p>
          </div>
          
          <div className="flex gap-2">
            <IconButton>
              <Calendar className="w-5 h-5 text-tertiary-foreground" />
            </IconButton>
            <IconButton>
              <User className="w-5 h-5 text-tertiary-foreground" />
            </IconButton>
          </div>
        </div>

        {/* Horizontal Date Picker */}
        <div className="flex gap-2 overflow-x-auto pb-2 -mx-1 px-1 scrollbar-hide">
          {dateChips.map((chip, index) => (
            <CalendarChip
              key={chip.id}
              day={chip.day}
              date={chip.date}
              isSelected={selectedDateIndex === index}
              onClick={() => setSelectedDateIndex(index)}
            />
          ))}
        </div>
      </div>

      {/* Tasks Timeline Section */}
      <div className="flex-1 overflow-y-auto -mr-2 pr-2 scrollbar-hide">
        <div className="relative pl-6">
          {/* Vertical Timeline */}
          <div className="absolute left-2 top-0 bottom-0 w-0.5 bg-progress-track" />
          
          {/* Task Cards */}
          <div className="space-y-4">
            {taskData.map((task) => (
              <div key={task.id} className="relative">
                {/* Timeline Node */}
                <div className="absolute -left-[25px] top-6 w-3 h-3 rounded-full bg-primary border-2 border-background" />
                
                {/* Task Card */}
                <TaskCard
                  time={task.time}
                  title={task.title}
                  description={task.description}
                  status={task.status}
                  buttonText={task.buttonText}
                  isPrimary={task.isPrimary}
                />
              </div>
            ))}
          </div>
        </div>
      </div>
    </div>
  );
}
