using Microsoft.Graphics.Canvas;
using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI;
using Microsoft.UI.Xaml.Navigation;

using Windows.UI;
using Windows.UI.WindowManagement;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;
using WinUIEx;

namespace TestEditor
{
	using WindowOption = WINDOW_EX_STYLE;
	using WindowStyle = WINDOW_STYLE;

	public sealed partial class EditorPage : Page
	{
		private const int toolWidth = 200;
		private const int toolHeight = 400;
		private const WindowStyle toolStyle = WindowStyle.WS_CAPTION | WindowStyle.WS_SYSMENU;
		private const WindowOption toolOption = WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED | WindowOption.WS_EX_NOACTIVATE;

		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private ChildWindowCollection childWindows;
		private ToolWindow layerPanel, palettePanel;
		private bool ignoreNcActivate;
		private Color flushColour = Transparent;

		internal ChildWindowCollection Children => childWindows;

		public EditorPage()
		{
			InitializeComponent();

			childWindows = new();
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
		private ToolWindow CreateToolPanel()
		{
			var panel = WindowHelper.CreateWindow<ToolWindow>();
			if (panel is not null)
			{
				var proj = Children.Emplace(panel);
				panel.SetWindowSize(toolWidth, toolHeight);

				proj.SubRoutines += ToolWindowHook;
				proj.Styles = toolStyle;
				proj.Options = toolOption;
			}

			return panel;
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
			palettePanel = CreateToolPanel();
			palettePanel?.Activate();

			layerPanel = CreateToolPanel();
			layerPanel?.Activate();

			if (palettePanel is not null || layerPanel is not null)
			{
				App.GetInstance().SubRoutines += EditorHook;
			}
		}
		private void OnUnloaded(object sender, RoutedEventArgs e)
		{
			foreach (var child in Children)
			{
				child.Window.Close();
			}
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
						foreach (var child in Children)
						{
							if (child.Window is ToolWindow toolwindow)
							{
								toolwindow.ForceActiveBar = false;
								if (toolwindow.Visible)
								{
									PInvoke.PostMessage(child.Projection, PInvoke.WM_NCACTIVATE, 0, IntPtr.Zero);
								}

								toolwindow.myPresenter.IsAlwaysOnTop = false;
							}
						}

						ignoreNcActivate = true;

						return (LRESULT) 0;
					}
					else if (wparam == 1) // activated
					{
						PInvoke.SendMessage(hwnd, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);

						// activate children
						foreach (var child in Children)
						{
							if (child.Window is ToolWindow toolwindow)
							{
								toolwindow.ForceActiveBar = true;
								if (toolwindow.Visible)
								{
									PInvoke.SendMessage(child.Projection, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
								}

								toolwindow.myPresenter.IsAlwaysOnTop = true;
							}
						}

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
					foreach (var child in Children)
					{
						if (child.Window is ToolWindow toolwindow)
						{
							if (toolwindow.ForceActiveBar)
							{
								PInvoke.SendMessage(App.GetInstance().myProject, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
							}
						}
					}

					return (LRESULT) 1;
				}
			}

			return PInvoke.DefSubclassProc(hwnd, msg, wparam, lparam);
		}
	}

	public class CanvasCreationException : Exception
	{
		public CanvasCreationException(string message)
			: base(message)
		{ }
	}
}
