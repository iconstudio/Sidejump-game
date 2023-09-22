using Microsoft.UI.Xaml.Markup;
using Microsoft.UI.Xaml.Media;

namespace TestEditor
{
	[ContentProperty(Name = "Text")]
	public sealed partial class AppTitleBar : UserControl
	{
		public static readonly Style defaultStyle;
		public static readonly Brush defaultBackground;

		public static DependencyProperty TextProperty { get; }
		public static DependencyProperty ColorProperty { get; }
		public static DependencyProperty TextStyleProperty { get; }
		public static DependencyProperty TextAlignmentProperty { get; }
		public static DependencyProperty HorizontalTextAlignmentProperty { get; }
		public static DependencyProperty IconProperty { get; }
		public static DependencyProperty IconAlignmentProperty { get; }
		public static DependencyProperty IconMarginProperty { get; }

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
			set => SetValue(TextAlignmentProperty, value);
		}
		public TextAlignment HorizontalTextAlignment
		{
			get => (TextAlignment) GetValue(HorizontalTextAlignmentProperty);
			set => SetValue(HorizontalTextAlignmentProperty, value);
		}
		public IconSource IconSource
		{
			get => (IconSource) GetValue(IconProperty);
			set => SetValue(IconProperty, value);
		}
		public AppTitleBarIconAlignment IconAlignment
		{
			get => (AppTitleBarIconAlignment) GetValue(IconAlignmentProperty);
			set => SetValue(IconAlignmentProperty, value);
		}
		public Thickness IconMargin
		{
			get => (Thickness) GetValue(IconMarginProperty);
			set => SetValue(IconMarginProperty, value);
		}
		public bool IsIconAvailable => IconSource != null;

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
			IconProperty = DependencyProperty.Register("IconSource", typeof(IconSource), my_type, new PropertyMetadata(null));
			IconAlignmentProperty = DependencyProperty.Register("IconAlignment", typeof(AppTitleBarIconAlignment), my_type, new PropertyMetadata(AppTitleBarIconAlignment.Left, SetIconAlignment));
			IconMarginProperty = DependencyProperty.Register("IconMargin", typeof(Thickness), my_type, new PropertyMetadata(new Thickness(0, 2, 0, 0)));
		}

		public AppTitleBar()
		{
			InitializeComponent();

			Background = defaultBackground;
			Height = 32;
			MinHeight = 32;
		}

		private static void SetIconAlignment(DependencyObject obj, DependencyPropertyChangedEventArgs e)
		{
			if (obj is AppTitleBar title)
			{
				var icon = title.titleIcon;
				var alignment = (AppTitleBarIconAlignment) e.NewValue;

				switch (alignment)
				{
					case AppTitleBarIconAlignment.FarLeft:
					{
						Grid.SetColumn(icon, 1);
						icon.HorizontalAlignment = HorizontalAlignment.Left;
					}
					break;

					case AppTitleBarIconAlignment.Left:
					{
						Grid.SetColumn(icon, 1);
						icon.HorizontalAlignment = HorizontalAlignment.Right;
					}
					break;

					case AppTitleBarIconAlignment.Center:
					{
						Grid.SetColumn(icon, 2);
						icon.HorizontalAlignment = HorizontalAlignment.Center;
					}
					break;

					case AppTitleBarIconAlignment.Right:
					{
						Grid.SetColumn(icon, 3);
						icon.HorizontalAlignment = HorizontalAlignment.Left;
					}
					break;

					case AppTitleBarIconAlignment.FarRight:
					{
						Grid.SetColumn(icon, 3);
						icon.HorizontalAlignment = HorizontalAlignment.Right;
					}
					break;

					default:
					break;
				}
			}
		}
	}
}
