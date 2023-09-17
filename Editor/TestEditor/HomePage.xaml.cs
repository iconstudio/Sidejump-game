using Microsoft.UI.Dispatching;
using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Xaml.Navigation;

using Windows.ApplicationModel;
using Windows.Storage;
using Windows.System.Threading;
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
		private bool isSettingTransitioning;
		private ThreadPoolTimer settingTransitionTimer;
		private readonly TimeSpan settingTransitionDuration;

		public HomePage()
		{
			InitializeComponent();

			appVersionText.Text = appVersion;

			panelFooter.Children.Remove(settingSap);
			panelFooter.Children.Remove(backBtn);

			var duration = Resources["SettingTransitionDuration"];
			if (duration is string represent)
			{
				settingTransitionDuration = TimeSpan.Parse(represent, null);
			}
			else
			{
				settingTransitionDuration = TimeSpan.FromSeconds(1);
			}
		}

#pragma warning disable CS4014
		private void OpenSetting()
		{
			if (!isSettingOpened && !isSettingTransitioning)
			{
				isSettingTransitioning = true;

				panelFooter.Children.Remove(settingBtn);
				panelFooter.Children.Add(backBtn);

				var task_timer = DispatcherQueue.CreateTask((s, _) =>
				{
					isSettingOpened = true;
					isSettingTransitioning = false;
				}, settingTransitionDuration);

				if (task_timer != null)
				{
					task_timer.Start();
				}
				else
				{
					DispatcherQueue.TryEnqueue(DispatcherQueuePriority.Normal, () =>
					{
						isSettingOpened = true;
						isSettingTransitioning = false;
					});
				}
			}
		}
		private void QuitSetting()
		{
			if (isSettingOpened && !isSettingTransitioning)
			{
				isSettingTransitioning = true;

				panelFooter.Children.Remove(backBtn);
				panelFooter.Children.Add(settingBtn);

				var task_timer = DispatcherQueue.CreateTask((s, _) =>
				{
					isSettingOpened = true;
					isSettingTransitioning = false;
				}, settingTransitionDuration);

				if (task_timer != null)
				{
					task_timer.Start();
				}
				else
				{
					DispatcherQueue.TryEnqueue(DispatcherQueuePriority.Normal, () =>
					{
						isSettingOpened = true;
						isSettingTransitioning = false;
					});
				}
			}
		}
#pragma warning restore CS4014

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
			lock (panelFooter)
			{
				OpenSetting();
			}
		}
		private void BackButton_Click(object sender, RoutedEventArgs e)
		{
			lock (panelFooter)
			{
				QuitSetting();
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

			if (0 < (settingTransitionTimer?.Delay.Milliseconds ?? 0))
			{
				settingTransitionTimer?.Cancel();
			}
			isSettingTransitioning = false;

			base.OnNavigatedFrom(e);
		}
	}
}
