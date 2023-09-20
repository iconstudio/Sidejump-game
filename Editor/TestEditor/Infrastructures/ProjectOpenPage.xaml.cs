using Microsoft.UI.Xaml.Media.Animation;

using Windows.Storage;

using TestEditor.Contents;
using TestEditor.Utility;
using TestEditor.WinUI;

namespace TestEditor
{
    public sealed partial class ProjectOpenPage : Page
	{
		private volatile bool isPickerOpened;

		public ProjectOpenPage()
		{
			InitializeComponent();
		}

		private async void CreateButton_Click(object sender, RoutedEventArgs e)
		{
			if (!isPickerOpened)
			{
				isPickerOpened = true;

				var picker = await FilePickHelper.OpenSavePicker(this.GetWindow());

				if (picker is StorageFile mapfile)
				{
					MapHelper.MemoLastFile(mapfile);

					NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.saveTransition);
				}

				isPickerOpened = false;
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			if (!isPickerOpened)
			{
				isPickerOpened = true;

				var picker = await FilePickHelper.OpenLoadPicker(this.GetWindow());

				if (picker is StorageFile mapfile)
				{
					MapHelper.MemoLastFile(mapfile);

					NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.loadTransition);
				}

				isPickerOpened = false;
			}
		}
	}
}
