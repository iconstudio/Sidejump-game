using System.Diagnostics;

using Windows.Storage;

namespace TestEditor
{
	public sealed partial class EditorPage : Page
	{
		public EditorPage()
		{
			InitializeComponent();
		}

		public async
			void
			LoadMap(StorageFile file)
		{
			if (file is null)
			{
				throw new ArgumentNullException(nameof(file));
			}

			using var fstream = await StorageHelper.TryOpenReadOnlyFile(file);

			if (fstream is null || !fstream.CanRead)
			{
				Debug.Print("Inappropriate file stream");
				return;
			}

			var length = fstream.Length;
			if (0 == length)
			{
				Debug.Print("Zero sized file");
				return;
			}

			fstream.Seek(0, SeekOrigin.Begin);

			byte[] mbuffer = new byte[length];
			var work_sz = await fstream.ReadAsync(mbuffer);

			if (0 == work_sz)
			{
				Debug.Print("Read zero size");
				return;
			}
		}
	}
}
