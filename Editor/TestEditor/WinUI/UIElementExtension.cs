namespace TestEditor.WinUI
{
	internal static class UIElementExtension
	{
		public static Window GetWindow(this UIElement element)
		{
			if (element.XamlRoot != null)
			{
				foreach (Window window in WindowHelper.trackedWindows)
				{
					if (element.XamlRoot == window.Content.XamlRoot)
					{
						return window;
					}
				}
			}

			return null;
		}
	}
}
