namespace TestEditor.Utility
{
	public interface ISingleton<T> where T : class, new()
	{
		private static T _Instance;

		public static T SingleInstance => _Instance;

		/// <param name="instance"></param>
		/// <exception cref="SingletonException"></exception>
		public static void SetInstance(T instance)
		{
			if (_Instance is not null)
			{
				throw new SingletonException($"Duplicated instance of {nameof(T)}");
			}

			_Instance = instance;
		}
		public static bool TryInstance(T instance)
		{
			if (_Instance is not null)
			{
				return false;
			}

			_Instance = instance;
			return true;
		}
		public static T GetInstance()
		{
			lock (SingleInstance)
			{
				return SingleInstance;
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
