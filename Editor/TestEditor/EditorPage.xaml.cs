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

		public float CanvasHeight
		{
			get
			{
				var bound = ActualSize;
				var pos = editorContents.ActualOffset;

				return bound.Y - pos.Y;
			}
		}

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

			mySurface.Present(0);
		}
		private void UpdateSwapChain(Size actual_size)
		{
			if (mySurface is not null)
			{
				mySurface.ResizeBuffers(actual_size);

				Render();
			}
		}
		private void UpdateSwapChain(float hr, float vt)
		{
			if (mySurface is not null)
			{
				mySurface.ResizeBuffers(hr, vt);

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
			//FindName(nameof(editorContents));
		}
		private void OnCanvasLoaded(object sender, RoutedEventArgs _)
		{
			Window window = this.GetWindow();
			clientView = new(window);

			CanvasDevice device = CanvasDevice.GetSharedDevice();
			if (device is null)
			{
				throw new DriveNotFoundException(nameof(device));
			}

			var dpi = clientView.Dpi;
			var size = clientView.AppWindow.ClientSize;
			size.Height -= (int) editorCommands.ActualHeight;
			size.Height -= (int) editorMenu.ActualHeight;
			CanvasSwapChain surface = new(device, (float) size.Width, (float) size.Height, dpi);

			//CanvasSwapChain surface = new(device, bound.X, bound.Y, dpi);
			if (surface is null)
			{
				throw new CanvasCreationException(nameof(surface));
			}

			editorCanvas.SwapChain = mySurface = surface;

			Render();
		}
		private void OnCanvasSizeChanged(object sender, SizeChangedEventArgs e)
		{
			if (mySurface is null)
			{
				OnCanvasLoaded(sender, null);
			}
			else
			{
				UpdateSwapChain(e.NewSize);

				Render();
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

	public class CanvasCreationException : Exception
	{
		public CanvasCreationException(string message)
			: base(message)
		{ }
	}
}
