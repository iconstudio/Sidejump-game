using System.Diagnostics;

using Microsoft.Graphics.Canvas;
using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI;
using Microsoft.UI.Windowing;
using Microsoft.UI.Xaml.Navigation;

using Windows.UI;
using Windows.Win32;
using Windows.Win32.Foundation;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.Contents;
using TestEditor.WinUI;
using TestEditor.Editor;

namespace TestEditor
{
    using WindowOption = WINDOW_EX_STYLE;
    using WindowStyle = WINDOW_STYLE;

    public sealed partial class EditorPage : Page
	{
		private const int toolWidth = 240;
		private const int toolHeight = 300;
		private const WindowOption toolOption = WindowOption.WS_EX_PALETTEWINDOW | WindowOption.WS_EX_COMPOSITED | WindowOption.WS_EX_NOACTIVATE;

		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);
		private Color flushColour = Colors.Plum;

		private ToolWindow paletteWindow;
		private bool ignoreNcActivate;

		public EditorPage()
		{
			InitializeComponent();
		}

		private void OpenMap(in Map map)
		{
			EditorContentManager.CurrentMap = map;
			editorCanvas.Clear();
		}
		private void CloseCurrentMap()
		{
			EditorContentManager.CurrentMap = null;
			editorCanvas.Clear();
		}
		private async void ProcessTransition(EditorTransitionCategory cat)
		{
			switch (cat)
			{
				case EditorTransitionCategory.Home:
				{ }
				break;

				case EditorTransitionCategory.Create:
				{
					try
					{
						using (EditorFileHelper.SaveMap(Map.EmptyMap, EditorFileHelper.LastFile))
						{
							Debug.Print("Map is saved");
						}
					}
					catch
					{
						Debug.Fail($"Cannot save the map to {EditorFileHelper.LastFile}");
					}
				}
				break;

				case EditorTransitionCategory.Load:
				{
					if (await EditorFileHelper.LoadMap(EditorFileHelper.LastFile) is Map map)
					{
						Debug.Print($"A map '{map.Name}' is loaded");

						OpenMap(map);
					}
					else
					{
						Debug.Fail($"Cannot load the map from {EditorFileHelper.LastFile}");
					}
				}
				break;

				case EditorTransitionCategory.Exit:
				{
					CloseCurrentMap();
				}
				break;

				default:
				break;
			}
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
						paletteWindow.LoseActivate();

						ignoreNcActivate = true;

						return (LRESULT) 0;
					}
					else if (wparam == 1) // activated
					{
						PInvoke.SendMessage(hwnd, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);

						// activate children
						paletteWindow.ForceActivate();

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
					if (paletteWindow.ForceActiveBar)
					{
						PInvoke.SendMessage(App.GetInstance().myProject, PInvoke.WM_NCACTIVATE, 1, IntPtr.Zero);
					}

					return (LRESULT) 1;
				}
			}

			return PInvoke.DefSubclassProc(hwnd, msg, wparam, lparam);
		}

		private void OnLoaded(object sender, RoutedEventArgs _)
		{
			var app = App.GetInstance();
			app.SubRoutines += EditorHook;

			var client = app.myWindow.AppWindow;
			var client_pos = client.Position;
			var client_bnd = client.Size;

			uint dpi = app.myProject.Dpi;
			float scaling = (float) dpi / 96f;
			var w = (int) (toolWidth * scaling);
			var h = (int) (toolHeight * scaling);

			paletteWindow = WindowHelper.CreateWindow<ToolWindow>();

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
				paletteWindow.AppWindow.Move(client_pos);
			}

			paletteWindow.AppWindow.ResizeClient(new(w, h));

			paletteWindow.myProjection.SubRoutines += ToolWindowHook;
			paletteWindow.SetOptions(toolOption);
			paletteWindow.Activate();
		}
		private void OnUnloaded(object sender, RoutedEventArgs e)
		{
			paletteWindow.Close();
		}
		private void OnFocused(object sender, RoutedEventArgs e)
		{
			//paletteWindow.SetAlwaysOnTop(true);
		}
		private void OnLostFocus(object sender, RoutedEventArgs e)
		{
			//paletteWindow.SetAlwaysOnTop(false);
		}
		protected override void OnNavigatedTo(NavigationEventArgs e)
		{
			base.OnNavigatedTo(e);

			if (e.Parameter is EditorTransitionInfo info)
			{
				ProcessTransition(info.TransitionCategory);
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

				editorCanvas.Height = height;
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
