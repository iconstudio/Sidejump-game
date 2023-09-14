using Microsoft.UI.Xaml.Media.Animation;

namespace TestEditor
{
	internal static class NavigationHelper
	{
		public static MainWindow CurrentWindow => MainWindow.GetInstance();

		public static
			void
			Goto(Type target, object parameter = null, NavigationTransitionInfo transition = null, Type current = null)
		{
			if (target != current)
			{
				if (transition is null)
				{
					CurrentWindow.GetContent().Navigate(target, parameter);
				}
				else
				{
					CurrentWindow.GetContent().Navigate(target, parameter, transition);
				}
			}
		}
	}
}
