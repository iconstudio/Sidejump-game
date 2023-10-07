using Microsoft.Graphics.Canvas.UI;
using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI.Input;
using Microsoft.UI.Xaml.Input;

using TestEditor.Contents;
using TestEditor.Editor;

using Windows.Foundation;

namespace TestEditor
{
	public sealed partial class EditorCanvas : UserControl
	{
		private bool isDragging;
		private PointerRoutedEventArgs lastDragArgs;

		private EditorCanvasView Camera { get; }

		private class NullEditorPageException : NullReferenceException
		{
			public NullEditorPageException(string message) : base(message)
			{ }
		}

		public event TypedEventHandler<CanvasControl, CanvasDrawEventArgs> Draw
		{
			add => Canvas.Draw += value;
			remove => Canvas.Draw -= value;
		}
		public event TypedEventHandler<CanvasControl, CanvasCreateResourcesEventArgs> CreateResources
		{
			add => Canvas.CreateResources += value;
			remove => Canvas.CreateResources -= value;
		}

		public EditorCanvas()
		{
			InitializeComponent();

			Draw += Render;

			Camera = new();
		}

		public void Clear()
		{

		}
		public void RemoveFromVisualTree()
		{
			Canvas.RemoveFromVisualTree();
		}
		private void Render(CanvasControl sender, CanvasDrawEventArgs e)
		{
			var map = EditorContentManager.CurrentMap;

			if (map is not null)
			{
				var session = e.DrawingSession;

				foreach (var tile in map.Tiles)
				{
					var id = tile.Id;
					var dx = tile.X;
					var dy = tile.Y;

					if (map.Tileset?.TileMap[id] is TileImage img)
					{
						img.Draw(session, dx, dy);
					}
				}
			}
		}

		private void ContentFrame_PointerPressed(object _, PointerRoutedEventArgs e)
		{
			var point = e.GetCurrentPoint(this);
			if (point.PointerDeviceType is PointerDeviceType.Touch
				|| (point.PointerDeviceType is PointerDeviceType.Mouse && point.Properties.IsMiddleButtonPressed))
			{
				if (!isDragging)
				{
					isDragging = true;
					lastDragArgs = e;
				}
			}
			else if (point.Position is Point pos)
			{
				var x = pos.X;
				var y = pos.Y;

				if (point.IsInContact)
				{

				}
			}
		}
		private void ContentFrame_PointerMoved(object _, PointerRoutedEventArgs e)
		{
			var point = e.GetCurrentPoint(this);

			if (isDragging && point.PointerId == lastDragArgs.Pointer.PointerId)
			{

				return;
			}
		}
		private void ContentFrame_PointerReleased(object _, PointerRoutedEventArgs e)
		{
			var point = e.GetCurrentPoint(this);
			if (point.PointerDeviceType is PointerDeviceType.Touch
				|| (point.PointerDeviceType is PointerDeviceType.Mouse && point.Properties.IsMiddleButtonPressed))
			{
				if (isDragging && point.PointerId == lastDragArgs.Pointer.PointerId)
				{
					isDragging = false;
					lastDragArgs = e;
				}
			}
		}
		private void ContentFrame_PointerExited(object _, PointerRoutedEventArgs e)
		{
			var point = e.GetCurrentPoint(this);

			if (isDragging && point.PointerId == lastDragArgs.Pointer.PointerId)
			{
				isDragging = false;
				lastDragArgs = e;

				return;
			}


		}
	}
}
