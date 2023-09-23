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
	public sealed partial class EditorPage : Page
	{
		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);
		private Color flushColour = Transparent;

		private WindowView clientView;
		private ToolWindow paletteWindow, layerWindow;
		private bool ignoreNcActivate;

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
						paletteWindow.ForceActiveBar = false;
						if (paletteWindow.Visible)
						{
							PInvoke.PostMessage(paletteWindow.myProject, PInvoke.WM_NCACTIVATE, 0, IntPtr.Zero);
						}

						ignoreNcActivate = true;

						return (LRESULT) 1;
					}
					else if (wparam == 1) // activated
					{
						PInvoke.SendMessage(clientView, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);

						// activate children
						paletteWindow.ForceActiveBar = true;
						if (paletteWindow.Visible)
						{
							PInvoke.SendMessage(paletteWindow.myProject, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
						}

						return (LRESULT) 1;
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
				if (paletteWindow.ForceActiveBar && wparam == 0)
				{
					PInvoke.SendMessage(clientView, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);

					return (LRESULT) 1;
				}
			}

			return PInvoke.DefSubclassProc(hwnd, msg, wparam, lparam);
		}

		private void OnLoaded(object sender, RoutedEventArgs _)
		{
			Window window = this.GetWindow();
			clientView = new(window);

			paletteWindow = WindowHelper.CreateWindow<ToolWindow>();
			paletteWindow.SetWindowSize(240, 400);

			paletteWindow.Activate();

			App.GetInstance().SubRoutines += EditorHook;
			paletteWindow.myProject.SubRoutines += ToolWindowHook;

		}
		private void OnUnloaded(object sender, RoutedEventArgs e)
		{
			paletteWindow.Close();
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
	}

	public class CanvasCreationException : Exception
	{
		public CanvasCreationException(string message)
			: base(message)
		{ }
	}
}
