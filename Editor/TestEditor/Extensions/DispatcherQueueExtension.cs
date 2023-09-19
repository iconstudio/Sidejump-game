using System.Diagnostics.CodeAnalysis;

using Microsoft.UI.Dispatching;

using Windows.Foundation;

namespace TestEditor
{
	using DispatcherQueueTimerTicket = TypedEventHandler<DispatcherQueueTimer, object>;
	using DispatcherQueueTimerAlterTicket = DispatcherQueueHandler;

	internal enum DispatcherFailurePolicy
	{
		DoNotContinue, ExcuteAnyway, ExecuteNow
	}

	internal static class DispatcherQueueExtension
	{
		public static
			DispatcherQueueTimer
			CreateStaticTask(this DispatcherQueue queue)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(false);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateStaticTask(this DispatcherQueue queue
				, [DisallowNull] DispatcherQueueTimerTicket ticket)
		{
			var task_timer = CreateStaticTask(queue);
			task_timer?.AddEventHandler(ticket);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateStaticTask(this DispatcherQueue queue
				, [DisallowNull] DispatcherQueueTimerAlterTicket ticket)
		{
			var task_timer = CreateStaticTask(queue);
			task_timer?.AddEventHandler((s, e) => { ticket(); });

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask(this DispatcherQueue queue
				, in TimeSpan duration
				, bool loop = false)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(loop);
			task_timer?.SetInterval(duration);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask(this DispatcherQueue queue
				, [DisallowNull] DispatcherQueueTimerTicket ticket
				, in TimeSpan duration
				, bool loop = false)
		{
			var task_timer = CreateTask(queue, duration, loop);
			task_timer?.AddEventHandler(ticket);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask(this DispatcherQueue queue
				, [DisallowNull] DispatcherQueueTimerAlterTicket ticket
				, in TimeSpan duration
				, bool loop = false)
		{
			var task_timer = CreateTask(queue, duration, loop);
			task_timer?.AddEventHandler((s, e) => { ticket(); });

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			StartTask(this DispatcherQueue queue
				, DispatcherFailurePolicy policy
				, [DisallowNull] DispatcherQueueTimerAlterTicket ticket
				, in TimeSpan duration
				, bool loop = false)
		{
			var task_timer = CreateTask(queue, duration, loop);
			if (task_timer is null)
			{
				switch (policy)
				{
					case DispatcherFailurePolicy.DoNotContinue:
					{ }
					break;

					case DispatcherFailurePolicy.ExcuteAnyway:
					{
						queue.TryEnqueue(DispatcherQueuePriority.Normal, ticket);
					}
					break;

					case DispatcherFailurePolicy.ExecuteNow:
					{
						ticket();
					}
					break;

					default:
					break;
				}
			}
			else
			{
				task_timer.AddEventHandler((s, e) => { ticket(); });
				task_timer.Start();
			}

			return task_timer;
		}
	}
}
