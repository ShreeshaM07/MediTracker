from datetime import datetime,timedelta
import pytz
from cal_setup import get_calendar_service

service=get_calendar_service()

def add_event_to_calendar(editedTabList):
    print(editedTabList)
    for i in range(len(editedTabList)-1):
    
        # Get current date and time in India timezone
        india_timezone = pytz.timezone('Asia/Kolkata')
        start_time = datetime.now(india_timezone) + timedelta(days=1)

        
        # Extract information from editedTabList
        medicine_name = editedTabList[i][0]
        time_of_day = editedTabList[i][1:-1]  # Extract all elements except the first and last
        duration_days = int(editedTabList[i][-1])  # Last element is the duration in days

        # Determine start time based on time_of_day
        for time in time_of_day:
            if time.lower() == 'before morning':
                start_time = start_time.replace(hour=7, minute=30, second=0, microsecond=0)
            elif time.lower() == 'after morning':
                start_time = start_time.replace(hour=9, minute=0, second=0, microsecond=0)
            elif time.lower() == 'before afternoon':
                start_time = start_time.replace(hour=11, minute=30, second=0, microsecond=0)
            elif time.lower() == 'after afternoon':
                start_time = start_time.replace(hour=13, minute=0, second=0, microsecond=0)
            elif time.lower() == 'before evening':
                start_time = start_time.replace(hour=16, minute=30, second=0, microsecond=0)
            elif time.lower() == 'after evening':
                start_time = start_time.replace(hour=18, minute=0, second=0, microsecond=0)
            elif time.lower() == 'before night':
                start_time = start_time.replace(hour=20, minute=30, second=0, microsecond=0)
            elif time.lower() == 'after night':
                start_time = start_time.replace(hour=22, minute=0, second=0, microsecond=0)

            # Calculate end time as start time + 1 hour (daily recurrence)
            end_time = start_time + timedelta(hours=1)

            # Calculate recurrence rule for daily recurrence
            recurrence_rule = f"RRULE:FREQ=DAILY;COUNT={duration_days}"

            event = {
                'summary': medicine_name,
                'description': medicine_name,
                'start': {
                    'dateTime': start_time.strftime('%Y-%m-%dT%H:%M:%S'),
                    'timeZone': 'Asia/Kolkata',
                },
                'end': {
                    'dateTime': end_time.strftime('%Y-%m-%dT%H:%M:%S'),
                    'timeZone': 'Asia/Kolkata',
                },
                'recurrence': [recurrence_rule],
            }

            try:
                # Insert the event into Google Calendar
                # Make sure you have the 'service' object ready before calling this function
                event = service.events().insert(calendarId='primary', body=event).execute()
                #return event.get('id')
            except Exception as e:
                print(f'Error adding event to Google Calendar: {str(e)}')
                return None
    print('Added events successfully')
   