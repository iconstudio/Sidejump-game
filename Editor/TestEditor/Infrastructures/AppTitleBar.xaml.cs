using Microsoft.UI.Xaml.Media;

namespace TestEditor
{
	public sealed partial class AppTitleBar : UserControl
	{
		public static readonly Style defaultStyle;
		public static readonly Brush defaultBackground;

		public static DependencyProperty TextProperty { get; }
		public static DependencyProperty ColorProperty { get; }
		public static DependencyProperty TextStyleProperty { get; }
		public static DependencyProperty TextAlignmentProperty { get; }
		public static DependencyProperty HorizontalTextAlignmentProperty { get; }

		public string Text
		{
			get => (string) GetValue(TextProperty);
			set => SetValue(TextProperty, value);
		}
		public Brush TextColor
		{
			get => (Brush) GetValue(ColorProperty);
			set => SetValue(ColorProperty, value);
		}
		public Style TextStyle
		{
			get => (Style) GetValue(TextStyleProperty);
			set => SetValue(TextStyleProperty, value);
		}
		public TextAlignment TextAlignment
		{
			get => (TextAlignment) GetValue(TextAlignmentProperty);
			set => SetValue (TextAlignmentProperty, value);
		}
		public TextAlignment HorizontalTextAlignment
		{
			get => (TextAlignment) GetValue(HorizontalTextAlignmentProperty);
			set => SetValue(HorizontalTextAlignmentProperty, value);
		}

		static AppTitleBar()
		{
			defaultStyle = Application.Current.Resources["BodyTextBlockStyle"] as Style;
			defaultBackground = Application.Current.Resources["AccentFillColorSelectedTextBackgroundBrush"] as Brush;

			Type my_type = typeof(AppTitleBar);

			TextProperty = DependencyProperty.Register("Text", typeof(string), my_type, new PropertyMetadata("Application"));
			ColorProperty = DependencyProperty.Register("TextColor", typeof(Brush), my_type, new PropertyMetadata(null));
			TextStyleProperty = DependencyProperty.Register("TextStyle", typeof(Style), my_type, new PropertyMetadata(defaultStyle));
			TextAlignmentProperty = DependencyProperty.Register("TextAlignment", typeof(TextAlignment), my_type, new PropertyMetadata(TextAlignment.Center));
			HorizontalTextAlignmentProperty = DependencyProperty.Register("HorizontalTextAlignment", typeof(TextAlignment), my_type, new PropertyMetadata(TextAlignment.Center));
		}
		public AppTitleBar()
		{
			InitializeComponent();

			TextStyle = defaultStyle;
			Background = defaultBackground;
			Height = 32;
			MinHeight = 32;
		}
	}
}
