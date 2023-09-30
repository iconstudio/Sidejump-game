using Microsoft.UI.Composition.SystemBackdrops;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Media;

using Windows.Win32;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;

namespace TestEditor
{
	internal sealed partial class ToolWindow : Window
	{
		private readonly DesktopAcrylicBackdrop acrylicBackdrop;
		private OverlappedPresenter myPresenter;
		internal WindowProjection myProjection;
		internal bool ForceActiveBar = true;

		public ToolWindow() : base()
		{
			InitializeComponent();

			if (DesktopAcrylicController.IsSupported())
			{
				acrylicBackdrop = new();
				SystemBackdrop = acrylicBackdrop;
			}

			myProjection = WindowProjection.CreateFrom(this);
		}

		public void SetPresenter(OverlappedPresenter presenter)
		{
			myPresenter = presenter;
		}
		public void SetAlwaysOnTop(bool flag)
		{
			myPresenter.IsAlwaysOnTop = flag;
		}
		public void SetOptions(WINDOW_EX_STYLE flag)
		{
			myProjection.Options = flag;
		}
		public void AddOptions(WINDOW_EX_STYLE flag)
		{
			myProjection.Options |= flag;
		}
		public void RemoveOptions(WINDOW_EX_STYLE flag)
		{
			myProjection.Options &= ~flag;
		}
		public void ForceActivate()
		{
			ForceActiveBar = true;
			if (Visible)
			{
				PInvoke.SendMessage(myProjection, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
			}
			SetAlwaysOnTop(true);

		}
		public void LoseActivate()
		{
			ForceActiveBar = false;
			if (Visible)
			{
				PInvoke.PostMessage(myProjection, PInvoke.WM_NCACTIVATE, 0, IntPtr.Zero);
			}
			SetAlwaysOnTop(false);

		}
	}
}
