emails = [
   "eric@gmail.com",
   "foo@bar.com",
   "sally@gmail.com",
   "spur@gmail.com",
   "ian@college.edu"
]

require Sender

func = fn -> Task.async_stream(emails, &Sender.run/1, on_timeout: :kill_task) |> Enum.each(&IO.inspect/1) end

func2 = fn -> 
   Sender.EmailTaskSupervisor 
   |> Task.Supervisor.async_stream_nolink(emails, &Sender.run/1, on_timeout: :kill_task) 
   |> Enum.each(&IO.inspect/1) 
end
