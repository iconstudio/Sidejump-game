using Microsoft.Graphics.Canvas.UI;
using Microsoft.Graphics.Canvas.UI.Xaml;

using TestEditor.Contents;

using Windows.Foundation;

namespace TestEditor
{
	public sealed partial class EditorCanvas : UserControl
	{
		public Map CurrentMap { get; set; }
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
			if (CurrentMap is not null)
			{
				var session = e.DrawingSession;

				foreach (var tile in CurrentMap.Tiles)
				{
					var id = tile.Id;
					var dx = tile.X;
					var dy = tile.Y;

					var img_ref = CurrentMap.Tileset?.TileMap[id] ?? null;
					if (img_ref is TileImage img)
					{
						img.Draw(session, dx, dy);
					}
				}
			}
		}
	}
}
