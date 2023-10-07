using Windows.Foundation;

namespace TestEditor.Editor
{
	internal class EditorCamera
	{
		private Rect myRect;

		public Rect Region
		{
			get => myRect;
			set => myRect = value;
		}
		public double X
		{
			get => myRect.X;
			set => myRect.X = value;
		}
		public double Y
		{
			get => myRect.Y;
			set => myRect.Y = value;
		}
		public double W
		{
			get => myRect.Width;
			set => myRect.Width = value;
		}
		public double H
		{
			get => myRect.Height;
			set => myRect.Height = value;
		}
		public double Left => myRect.Left;
		public double Right => myRect.Right;
		public double Top => myRect.Top;
		public double Bottom => myRect.Bottom;
	}
}
