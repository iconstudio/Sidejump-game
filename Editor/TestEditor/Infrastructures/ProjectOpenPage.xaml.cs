using Microsoft.UI.Xaml.Media.Animation;

using Windows.Storage;
using TestEditor.Utility;
using TestEditor.WinUI;
using TestEditor.Editor;

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

				var handle = App.GetInstance().myProject.NativeHandle;
				if (await FilePickHelper.OpenSavePicker(handle, EditorFileHelper.mapSaveExtensions) is StorageFile mapfile)
				{
					EditorFileHelper.MemoLastFile(mapfile);

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

				var handle = App.GetInstance().myProject.NativeHandle;
				if (await FilePickHelper.OpenLoadPicker(handle, EditorFileHelper.MapExtension) is StorageFile mapfile)
				{
					EditorFileHelper.MemoLastFile(mapfile);

					NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.loadTransition);
				}

				isPickerOpened = false;
			}
		}
	}
}
