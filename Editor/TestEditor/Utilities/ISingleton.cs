namespace TestEditor.Utility
{
	public interface ISingleton<T> where T : class, new()
	{
		protected static T Instance { get; set; }
		protected static T SingleInstance => Instance;

		/// <param name="instance"></param>
		/// <exception cref="SingletonException"></exception>
		public static void SetInstance(T instance)
		{
			if (Instance is not null)
			{
				throw new SingletonException($"Duplicated instance of {nameof(T)}");
			}

			Instance = instance;
		}
		public static bool TryInstance(T instance)
		{
			if (Instance is not null)
			{
				return false;
			}

			Instance = instance;
			return true;
		}
		public static T GetInstance()
		{
			lock (Instance)
			{
				return Instance;
			}
		}
	}

	[Serializable]
	class SingletonException : ApplicationException
	{
		public SingletonException() : base()
		{ }
		public SingletonException(string message) : base(message)
		{ }
	}
}
