using Microsoft.Graphics.Canvas.UI.Xaml;

using Windows.Foundation;

namespace TestEditor
{
	public sealed partial class EditorCanvas : UserControl
	{
		public TypedEventHandler<CanvasControl, CanvasDrawEventArgs> Draw { get; set; }

		public EditorCanvas()
		{
			InitializeComponent();
		}
	}
}
