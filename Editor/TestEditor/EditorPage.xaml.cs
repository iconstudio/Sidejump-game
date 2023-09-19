using System.Diagnostics.Contracts;
using System.Numerics;

using Microsoft.Graphics.Canvas;
using Microsoft.UI;
using Microsoft.UI.Xaml.Navigation;

using Windows.Foundation;
using Windows.UI;

using TestEditor.WinUI;

namespace TestEditor
{
	public sealed partial class EditorPage : Page
	{
		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private CanvasSwapChain mySurface;
		private WindowView clientView;

		public EditorPage()
		{
			InitializeComponent();
		}

		private void Render()
		{
			using (var session = mySurface.CreateDrawingSession(Colors.Aquamarine))
			{
				session.DrawEllipse(155, 115, 80, 30, Colors.Black, 3);
				session.DrawText("Hello, Win2D world!", 100, 100, Colors.Yellow);
			}

			mySurface.Present(1);
		}
		[Pure]
		private Size AcquireClientSize()
		{
			return editorContents.ActualSize.ToSize();
		}
		private void UpdateSwapChain(Size size)
		{
			if (mySurface is not null)
			{
				float scaling = (float) clientView.Dpi / 96;
				size.Width *= scaling;
				size.Height *= scaling;

				mySurface.ResizeBuffers(size);

				Render();
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
			FindName(nameof(editorContents));
		}
		private void OnCanvasLoaded(object sender, RoutedEventArgs _)
		{
			Window window = this.GetWindow();
			clientView = new(window);

			var device = CanvasDevice.GetSharedDevice();
			if (device is null)
			{
				throw new DriveNotFoundException(nameof(device));
			}

			var dpi = clientView.Dpi;
			var size = clientView.AppWindow.ClientSize;

			var surface = new CanvasSwapChain(device, size.Width, size.Height, dpi);
			if (surface is null)
			{
				throw new NullReferenceException(nameof(surface));
			}

			editorCanvas.SwapChain = mySurface = surface;

			UpdateSwapChain(AcquireClientSize());
		}
		private void OnCanvasSizeChanged(object sender, SizeChangedEventArgs e)
		{
			if (mySurface is null)
			{
				OnCanvasLoaded(sender, null);
			}
			else
			{
				UpdateSwapChain(AcquireClientSize());
			}
		}
		private void OnCanvasUnloaded(object sender, RoutedEventArgs _)
		{
			mySurface?.Dispose();
			mySurface = null;

			editorCanvas.RemoveFromVisualTree();
			editorCanvas = null;
		}
	}
}
