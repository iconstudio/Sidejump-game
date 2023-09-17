using System.Diagnostics.CodeAnalysis;

using Microsoft.UI.Dispatching;

using Windows.Foundation;

namespace TestEditor
{
	using DispatcherQueueTimerTicket = TypedEventHandler<DispatcherQueueTimer, object>;

	internal enum DispatcherContinuationPolicy
	{

	}

	internal static class DispatcherQueueExtension
	{
		public static
			DispatcherQueueTimer
			CreateTask([DisallowNull] this DispatcherQueue queue)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(false);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask([DisallowNull] this DispatcherQueue queue, [DisallowNull] ref DispatcherQueueTimerTicket ticket)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(false);
			task_timer?.AddEventHandler(ref ticket);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask([DisallowNull] this DispatcherQueue queue, in TimeSpan duration, bool loop = false)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(loop);
			task_timer?.SetInterval(duration);

			return task_timer;
		}
		public static
			DispatcherQueueTimer
			CreateTask([DisallowNull] this DispatcherQueue queue, [DisallowNull] ref DispatcherQueueTimerTicket ticket, in TimeSpan duration, bool loop = false)
		{
			var task_timer = queue.CreateTimer();
			task_timer?.SetLoop(loop);
			task_timer?.SetInterval(duration);
			task_timer?.AddEventHandler(ref ticket);

			return task_timer;
		}
	}
}
