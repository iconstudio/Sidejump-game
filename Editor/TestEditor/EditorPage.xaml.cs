using System.Diagnostics.Contracts;
using System.Numerics;

using Microsoft.Graphics.Canvas;
using Microsoft.UI;
using Microsoft.UI.Xaml.Navigation;

using Windows.Foundation;
using Windows.UI;

using TestEditor.WinUI;
using Microsoft.Graphics.Canvas.UI.Xaml;

namespace TestEditor
{
	public sealed partial class EditorPage : Page
	{
		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private WindowView clientView;

		public float CanvasHeight
		{
			get
			{
				var by = (double) (MainWindow.GetInstance()?.AppWindow.ClientSize.Height ?? 500.0) - 32;

				var h1 = editorCommands?.Height ?? 48;
				by -= double.IsNormal(h1) ? h1 : 48;

				var h2 = editorMenu?.Height ?? 32;
				by -= double.IsNormal(h2) ? h2 : 32;

				return (float) by;
			}
		}

		public EditorPage()
		{
			InitializeComponent();
		}

		private void Render(CanvasDrawingSession context)
		{
			using (context)
			{
				context.Clear(Colors.Blue);

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
		private void OnCanvasLoaded(object sender, RoutedEventArgs _)
		{
			Window window = this.GetWindow();
			clientView = new(window);
		}
		private void OnCanvasSizeChanged(object sender, SizeChangedEventArgs e)
		{
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
