using System.Diagnostics.CodeAnalysis;

using Microsoft.UI.Dispatching;

using Windows.Foundation;

namespace TestEditor.WinUI
{
	using DispatcherQueueTimerTicket = TypedEventHandler<DispatcherQueueTimer, object>;

	internal static class DispatcherQueueTimerExtension
	{
		public static
			void
			SetLoop(this DispatcherQueueTimer timer, bool loop)
		{
			timer.IsRepeating = loop;
		}
		public static
			void
			SetInterval(this DispatcherQueueTimer timer, in TimeSpan duration)
		{
			timer.Interval = duration;
		}
		public static
			void
			AddEventHandler(this DispatcherQueueTimer timer, [DisallowNull] DispatcherQueueTimerTicket handler)
		{
			if (timer is not null)
			{
				timer.Tick += handler;
			}
		}
		public static
			void
			RemoveEventHandler(this DispatcherQueueTimer timer, [DisallowNull] DispatcherQueueTimerTicket handler)
		{
			if (timer is not null)
			{
				timer.Tick -= handler;
			}
		}
		public static bool IsLooping(this DispatcherQueueTimer timer) => timer.IsRepeating;
	}
}
