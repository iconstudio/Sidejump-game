using Microsoft.UI.Xaml.Media;

namespace TestEditor
{
	public sealed partial class EditorTitleBar : UserControl
	{
		private static readonly Style defaultStyle;
		private static readonly Brush defaultBackground;

		public string Text { get; set; } = "Application";
		public Brush TextColor { get; set; }
		public Style TextStyle { get; set; } = defaultStyle;
		public TextAlignment TextAlignment { get; set; } = TextAlignment.Center;
		public TextAlignment HorizontalTextAlignment { get; set; } = TextAlignment.Center;

		static EditorTitleBar()
		{
			defaultStyle = Application.Current.Resources["BodyTextBlockStyle"] as Style;
			defaultBackground = Application.Current.Resources["AccentFillColorSelectedTextBackgroundBrush"] as Brush;
		}
		public EditorTitleBar()
		{
			InitializeComponent();

			TextStyle = defaultStyle;
			Background = defaultBackground;
			Height = 32;
			MinHeight = 32;
		}
	}
}
