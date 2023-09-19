using Microsoft.Graphics.Canvas.UI.Xaml;
using Microsoft.UI;
using Microsoft.UI.Xaml.Navigation;

namespace TestEditor
{
	public sealed partial class EditorPage : Page
	{
		public EditorPage()
		{
			InitializeComponent();
		}

		protected override void OnNavigatedTo(NavigationEventArgs e)
		{
			base.OnNavigatedTo(e);

			if (e.Parameter is EditorTransitionInfo info)
			{
				OnTransition(info.transitionCategory);
			}
		}
		private void OnTransition(EditorTransitionCategory cat)
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

		private void editorCanvas_Draw(CanvasControl sender, CanvasDrawEventArgs args)
		{
			args.DrawingSession.DrawEllipse(155, 115, 80, 30, Colors.Black, 3);
			args.DrawingSession.DrawText("Hello, Win2D world!", 100, 100, Colors.Yellow);
		}
	}
}
