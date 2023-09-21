using Microsoft.Graphics.Canvas;
using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI;
using Microsoft.UI.Xaml.Navigation;

using Windows.UI;
using Windows.Win32.UI.WindowsAndMessaging;

using TestEditor.WinUI;
using Microsoft.UI.Windowing;
using Windows.ApplicationModel.Preview.Notes;
using Windows.Graphics;

namespace TestEditor
{
	public sealed partial class EditorPage : Page
	{
		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);
		private Color flushColour = Transparent;

		private WindowView clientView;

		private static readonly SizeInt32 defaultToolSize = new(200, 300);
		private SizeInt32 toolSize;
		private ToolWindow paletteWindow, layerWindow;

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

		private void OnLoaded(object sender, RoutedEventArgs _)
		{
			Window window = this.GetWindow();
			clientView = new(window);

			var dpi = clientView.Dpi;
			var scale = (float) dpi / 96;
			toolSize = defaultToolSize;
			toolSize.Width = (int) (Width * scale);
			toolSize.Height = (int) (Height * scale);

			paletteWindow = WindowHelper.CreateWindow<ToolWindow>();
			if (paletteWindow is not null)
			{
				var presenter = OverlappedPresenter.Create();
				presenter.SetBorderAndTitleBar(true, true);
				presenter.IsAlwaysOnTop = false;
				presenter.IsResizable = false;
				presenter.IsMaximizable = false;
				presenter.IsMinimizable = false;

				paletteWindow.AppWindow.SetPresenter(presenter);
				paletteWindow.AppWindow.Resize(toolSize);

				paletteWindow.Activate();
			}
		}
		private void OnUnloaded(object sender, RoutedEventArgs e)
		{
			paletteWindow?.Close();
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
		{}
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
