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
		}

		public void Clear()
		{

		}
		public void RemoveFromVisualTree()
		{
			Canvas.RemoveFromVisualTree();
		}
	}
}
