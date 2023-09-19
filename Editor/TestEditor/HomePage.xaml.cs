using Microsoft.UI.Xaml.Input;
using Microsoft.UI.Xaml.Media.Animation;
using Microsoft.UI.Xaml.Navigation;

using Windows.ApplicationModel;
using Windows.UI;

namespace TestEditor
{
	public sealed partial class HomePage : Page
	{
		private static readonly string appVersion = string.Format(null, "v{0}.{1}.{2}.{3}",
					Package.Current.Id.Version.Major,
					Package.Current.Id.Version.Minor,
					Package.Current.Id.Version.Build,
					Package.Current.Id.Version.Revision);

		private bool isSettingOpened;
		private bool isSettingTransitioning;
		private readonly TimeSpan settingTransitionDuration;

		public HomePage()
		{
			InitializeComponent();

			appVersionText.Text = appVersion;

			if (Resources["SettingTransitionDuration"] is string represent)
			{
				settingTransitionDuration = TimeSpan.Parse(represent, null);
			}
			else
			{
				settingTransitionDuration = TimeSpan.FromSeconds(1);
			}

			menuStateHome.Duration = settingTransitionDuration;
			menuStateSetting.Duration = settingTransitionDuration;

			homeContents.Navigate(typeof(ProjectOpenPage));
		}

#pragma warning disable CS4014
		private void OpenSetting()
		{
			if (!isSettingOpened && !isSettingTransitioning)
			{
				isSettingTransitioning = true;

				menuStateSetting.Begin();
				panelFooter.IsHitTestVisible = false;
				backBtn.Visibility = Visibility.Visible;

				homeContents.Navigate(typeof(SettingPage));
			}
		}
		private void QuitSetting()
		{
			if (isSettingOpened && !isSettingTransitioning)
			{
				isSettingTransitioning = true;

				menuStateHome.Begin();
				panelFooter.IsHitTestVisible = false;
				settingBtn.Visibility = Visibility.Visible;

				homeContents.Navigate(typeof(ProjectOpenPage));
			}
		}
#pragma warning restore CS4014
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
		private void settingBtnFadeOutAnimation_Complete(object sender, object _)
		{
			if (sender is DoubleAnimation)
			{
				settingBtn.Visibility = Visibility.Collapsed;
			}
		}
		private void backBtnFadeOutAnimation_Complete(object sender, object _)
		{
			if (sender is DoubleAnimation)
			{
				backBtn.Visibility = Visibility.Collapsed;
			}
		}
		private void menuStateSetting_Completed(object sender, object _)
		{
			if (sender is Storyboard)
			{
				lock (panelFooter)
				{
					panelFooter.IsHitTestVisible = true;

					isSettingOpened = true;
					isSettingTransitioning = false;
				}
			}
		}
		private void menuStateHome_Completed(object sender, object _)
		{
			if (sender is Storyboard)
			{
				lock (panelFooter)
				{
					panelFooter.IsHitTestVisible = true;

					isSettingOpened = false;
					isSettingTransitioning = false;
				}
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

			isSettingTransitioning = false;

			base.OnNavigatedFrom(e);
		}
	}
}
