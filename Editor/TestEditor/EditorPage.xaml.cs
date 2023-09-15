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
			//var testmap = new Map();
			//using (MapHelper.SaveMap(testmap, mapfile))
		}
	}
}
