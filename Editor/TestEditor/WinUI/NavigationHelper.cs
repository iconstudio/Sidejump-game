using Microsoft.UI.Xaml.Media.Animation;

namespace TestEditor.WinUI
{
	internal static class NavigationHelper
	{
		public static MainWindow CurrentWindow => MainWindow.GetInstance();

		public static
			void
			Goto(Type target, NavigationTransitionInfo transition, object parameter = null, Type current = null)
		{
			if (target != current)
			{
				CurrentWindow.GetContent().Navigate(target, parameter, transition);
			}
		}
		public static
			void
			Goto(Type target, object parameter = null, Type current = null)
		{
			if (target != current)
			{
				CurrentWindow.GetContent().Navigate(target, parameter);
			}
		}
	}
}
