# ps, start time, processes, start

ps -u "$USER" -o pid,lstart,etime,cmd --sort=start_time
