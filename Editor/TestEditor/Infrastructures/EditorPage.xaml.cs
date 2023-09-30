using Microsoft.Graphics.Canvas;
using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI;
using Microsoft.UI.Dispatching;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Navigation;

using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;
using Windows.UI;

using TestEditor.WinUI;

namespace TestEditor
{
	using WindowOption = WINDOW_EX_STYLE;
	using WindowStyle = WINDOW_STYLE;

	public sealed partial class EditorPage : Page
	{
		private const int toolWidth = 240;
		private const int toolHeight = 300;
		private const WindowStyle toolStyle = WindowStyle.WS_CAPTION | WindowStyle.WS_SYSMENU;
		private const WindowOption toolOption = WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED | WindowOption.WS_EX_NOACTIVATE;

		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private ToolWindow palettePanel;
		private bool ignoreNcActivate;
		private Color flushColour = Colors.Plum;

		public EditorPage()
		{
			InitializeComponent();
		}

		private void Render(CanvasDrawingSession context)
		{
			using (context)
			{
				context.Clear(flushColour);

				context.DrawEllipse(155, 115, 80, 30, Colors.Black, 3);
				context.DrawText("Hello, Win2D world!", 100, 100, Colors.Yellow);
			}
		}
		private static ToolWindow CreateToolPanel()
		{
			return WindowHelper.CreateWindow<ToolWindow>();
		}
		private void ProcessTransition(EditorTransitionCategory cat)
		{
			switch (cat)
			{
				case EditorTransitionCategory.Home:
				{

				}
				break;

				case EditorTransitionCategory.Create:
				{

				}
				break;

				case EditorTransitionCategory.Load:
				{

				}
				break;

				case EditorTransitionCategory.Exit:
				{

				}
				break;

				default:
				break;
			}
			//var testmap = new Map();
			//using (MapHelper.SaveMap(testmap, mapfile))
		}

		private void OnLoaded(object sender, RoutedEventArgs _)
		{
			var app = App.GetInstance();
			var client = app.myWindow.AppWindow;

			var pal_presenter = OverlappedPresenter.Create();
			if (pal_presenter is null)
			{
				throw new ToolPresenterCreationFailedException(nameof(pal_presenter));
			}

			pal_presenter.SetBorderAndTitleBar(true, true);
			pal_presenter.IsAlwaysOnTop = true;
			pal_presenter.IsResizable = false;
			pal_presenter.IsMaximizable = false;
			pal_presenter.IsMinimizable = false;

			palettePanel = CreateToolPanel();
			palettePanel.SetPresenter(pal_presenter);
			palettePanel.AppWindow.IsShownInSwitchers = false;

			var client_pos = client.Position;
			var client_bnd = client.Size;

			uint dpi = app.myProject.Dpi;
			float scaling = (float) dpi / 96f;
			var w = (int) (toolWidth * scaling);
			var h = (int) (toolHeight * scaling);

			if (client.Presenter is OverlappedPresenter client_presenter)
			{
				var gap = toolWidth + 10;
				var max_x = App.DisplaySize.Width - gap;
				if (client_presenter.State == OverlappedPresenterState.Maximized)
				{
					client_pos.X = max_x;
				}
				else
				{
					client_pos.X = Math.Min(max_x, client_pos.X + Math.Max(client_bnd.Width - gap, 0));
				}
				client_pos.Y += 48;
				palettePanel.AppWindow.Move(client_pos);
			}

			palettePanel.AppWindow.ResizeClient(new(w, h));
			palettePanel.AddOptions(toolOption);
			palettePanel.Activate();

			app.SubRoutines += EditorHook;
			palettePanel.myProjection.SubRoutines += ToolWindowHook;
		}
		private void OnUnloaded(object sender, RoutedEventArgs e)
		{
			palettePanel?.Close();
			palettePanel = null;

			App.GetInstance().SubRoutines -= EditorHook;
		}
		private void OnFocused(object sender, RoutedEventArgs e)
		{
		}
		private void OnLostFocus(object sender, RoutedEventArgs e)
		{
		}
		protected override void OnNavigatedTo(NavigationEventArgs e)
		{
			base.OnNavigatedTo(e);

			if (e.Parameter is EditorTransitionInfo info)
			{
				ProcessTransition(info.transitionCategory);
			}

			// load the canvas
			FindName(nameof(editorCanvas));
		}
		private void OnCanvasLoaded(object sender, RoutedEventArgs e)
		{ }
		private void OnContentsSizeChanged(object sender, SizeChangedEventArgs e)
		{
			if (sender is StackPanel panel)
			{
				var h1 = panel.ActualHeight;
				var height = double.IsNormal(h1) ? h1 : 300;

				var h2 = editorCommands?.ActualHeight ?? 64;
				height -= double.IsNormal(h2) ? h2 : 64; // command

				var h3 = editorMenu?.ActualHeight ?? 40;
				height -= double.IsNormal(h3) ? h3 : 40; // menubar

				editorContents.Height = height;
			}
		}
		private void OnDraw(CanvasControl sender, CanvasDrawEventArgs args)
		{
			Render(args.DrawingSession);
		}
		private void OnCanvasUnloaded(object sender, RoutedEventArgs _)
		{
			editorCanvas.RemoveFromVisualTree();
			editorCanvas = null;
		}

		private LRESULT EditorHook(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam, nuint id, nuint refdata)
		{
			switch (msg)
			{
				case PInvoke.WM_NCACTIVATE:
				{
					if (wparam == 0) // diactivated
					{
						if (ignoreNcActivate)
						{
							ignoreNcActivate = false;
						}
						else
						{
							// Send this msg again, but onto activated
							PInvoke.SendMessage(hwnd, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
						}

						return (LRESULT) 1;
					}
				}
				break;

				case PInvoke.WM_ACTIVATEAPP:
				{
					if (wparam == 0) // diactivated
					{
						PInvoke.PostMessage(hwnd, PInvoke.WM_NCACTIVATE, 0, IntPtr.Zero);

						// diactivate children
						palettePanel.LoseActivate();

						ignoreNcActivate = true;

						return (LRESULT) 0;
					}
					else if (wparam == 1) // activated
					{
						PInvoke.SendMessage(hwnd, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);

						// activate children
						palettePanel.ForceActivate();

						return (LRESULT) 0;
					}
				}
				break;
			}

			return PInvoke.DefSubclassProc(hwnd, msg, wparam, lparam);
		}
		private LRESULT ToolWindowHook(HWND hwnd, uint msg, WPARAM wparam, LPARAM lparam, nuint id, nuint refdata)
		{
			if (msg == PInvoke.WM_NCACTIVATE)
			{
				if (wparam == 0)
				{
					if (palettePanel.ForceActiveBar)
					{
						PInvoke.SendMessage(App.GetInstance().myProject, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
					}

					return (LRESULT) 1;
				}
			}

			return PInvoke.DefSubclassProc(hwnd, msg, wparam, lparam);
		}
	}

	public class ToolPresenterCreationFailedException : NullReferenceException
	{
		public ToolPresenterCreationFailedException(string message) : base(message)
		{ }
	}
	public class CanvasCreationException : Exception
	{
		public CanvasCreationException(string message)
			: base(message)
		{ }
	}
}
