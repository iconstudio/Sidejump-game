using System.Diagnostics;

using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Xaml.Navigation;

using Windows.ApplicationModel;
using Windows.Storage;
using Windows.UI;

namespace TestEditor
{
	public sealed partial class HomePage : Page
	{
		private static readonly Color Transparent = Color.FromArgb(0, 0, 0, 0);

		private static readonly string appVersion = string.Format(null, "v{0}.{1}.{2}.{3}",
					Package.Current.Id.Version.Major,
					Package.Current.Id.Version.Minor,
					Package.Current.Id.Version.Build,
					Package.Current.Id.Version.Revision);

		private bool isSettingOpened;

		public HomePage()
		{
			InitializeComponent();

			appVersionText.Text = appVersion;

			panelFooter.Children.Remove(settingSap);
			panelFooter.Children.Remove(backBtn);
		}
		private async void CreateButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = await FilePickHelper.OpenSavePicker(this.GetWindow());
			if (picker is StorageFile mapfile)
			{
				MapHelper.MemoLastFile(mapfile);

				NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.saveTransition);
			}
		}
		private async void OpenButton_Click(object sender, RoutedEventArgs e)
		{
			var picker = await FilePickHelper.OpenLoadPicker(this.GetWindow());
			if (picker is StorageFile mapfile)
			{
				MapHelper.MemoLastFile(mapfile);

				NavigationHelper.Goto(typeof(EditorPage), new DrillInNavigationTransitionInfo(), EditorTransitionInfo.loadTransition);
			}
		}
		private void SettingButton_Click(object sender, RoutedEventArgs e)
		{
			if (!isSettingOpened)
			{
				isSettingOpened = true;

				//settingSap.Opacity = 1;
				//backBtn.Opacity = 1;
				//panelFooter.Children.Add(settingSap);
				panelFooter.Children.Remove(settingBtn);
				panelFooter.Children.Add(backBtn);
			}
		}
		private void BackButton_Click(object sender, RoutedEventArgs e)
		{
			if (isSettingOpened)
			{
				isSettingOpened = false;

				//settingSap.Opacity = 0;
				//backBtn.Opacity = 0;
				//panelFooter.Children.Remove(settingSap);
				panelFooter.Children.Remove(backBtn);
				panelFooter.Children.Add(settingBtn);
			}
		}
		private void AnimationButton_PointerPressed(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState((UIElement) sender, "Pressed");
		}
		private void AnimationButton_PointerReleased(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState((UIElement) sender, "PressedToNormal");
		}
		private void AnimationButton_PointerEntered(object sender, PointerRoutedEventArgs e)
		{
			AnimatedIcon.SetState((UIElement) sender, "PointerOver");
		}
		protected override void OnNavigatedTo(NavigationEventArgs e)
		{
			settingBtn.AddHandler(PointerPressedEvent,
				new PointerEventHandler(AnimationButton_PointerPressed), true);
			settingBtn.AddHandler(PointerReleasedEvent,
				new PointerEventHandler(AnimationButton_PointerReleased), true);

			base.OnNavigatedTo(e);
		}
		protected override void OnNavigatedFrom(NavigationEventArgs e)
		{
			settingBtn.RemoveHandler(PointerPressedEvent,
				(PointerEventHandler) AnimationButton_PointerPressed);
			settingBtn.RemoveHandler(PointerReleasedEvent,
				(PointerEventHandler) AnimationButton_PointerReleased);

			base.OnNavigatedFrom(e);
		}
	}
}
